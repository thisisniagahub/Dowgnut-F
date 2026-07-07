import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dowgnut_theme.dart';

class AsciiDonutWidget extends StatefulWidget {
  final double fontSize;
  final Color? color;
  final bool useBrandGradient;
  final int width;
  final int height;

  const AsciiDonutWidget({
    super.key,
    this.fontSize = 9.0,
    this.color,
    this.useBrandGradient = true,
    this.width = 56,
    this.height = 28,
  });

  @override
  State<AsciiDonutWidget> createState() => _AsciiDonutWidgetState();
}

class _AsciiDonutWidgetState extends State<AsciiDonutWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 32),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _renderFrame(
      double rotationA, double rotationB, int width, int height) {
    const double thetaSpacing = 0.08;
    const double phiSpacing = 0.035;

    const double tubeRadius = 1.0;
    const double ringRadius = 2.0;
    const double viewerDistance = 5.0;
    // Calculate K1 based on width
    final double projectionScale =
        width * viewerDistance * 3.0 / (8.0 * (tubeRadius + ringRadius));

    final List<String> output = List<String>.filled(width * height, ' ');
    final List<double> zbuffer = List<double>.filled(width * height, 0.0);

    final double cosA = math.cos(rotationA);
    final double sinA = math.sin(rotationA);
    final double cosB = math.cos(rotationB);
    final double sinB = math.sin(rotationB);

    // theta goes around the cross-sectional circle of a torus
    for (double theta = 0; theta < 2 * math.pi; theta += thetaSpacing) {
      final double costheta = math.cos(theta);
      final double sintheta = math.sin(theta);

      // phi goes around the center of revolution of a torus
      for (double phi = 0; phi < 2 * math.pi; phi += phiSpacing) {
        final double cosphi = math.cos(phi);
        final double sinphi = math.sin(phi);

        // the x,y coordinate of the circle, before revolving
        final double circlex = ringRadius + tubeRadius * costheta;
        final double circley = tubeRadius * sintheta;

        // final 3D (x,y,z) coordinate after rotations
        final double x = circlex * (cosB * cosphi + sinA * sinB * sinphi) -
            circley * cosA * sinB;
        final double y = circlex * (sinB * cosphi - sinA * cosB * sinphi) +
            circley * cosA * cosB;
        final double z =
            viewerDistance + cosA * circlex * sinphi + circley * sinA;
        final double ooz = 1.0 / z; // "one over z"

        // x and y projection.
        // y is squashed by 0.45 to compensate for terminal character aspect ratio
        final int xp = (width / 2.0 + projectionScale * ooz * x).toInt();
        final int yp =
            (height / 2.0 - projectionScale * ooz * y * 0.45).toInt();

        if (xp >= 0 && xp < width && yp >= 0 && yp < height) {
          final int idx = xp + yp * width;

          // calculate luminance
          final double L = cosphi * costheta * sinB -
              cosA * costheta * sinphi -
              sinA * sintheta +
              cosB * (cosA * sintheta - costheta * sinA * sinphi);

          if (L > 0) {
            if (ooz > zbuffer[idx]) {
              zbuffer[idx] = ooz;
              const String charPalette = ".:-=+*#%@";
              final int clampedLuminance =
                  (L * (charPalette.length - 1)).round().clamp(
                        0,
                        charPalette.length - 1,
                      );
              output[idx] = charPalette[clampedLuminance];
            }
          }
        }
      }
    }

    final StringBuffer buffer = StringBuffer();
    for (int j = 0; j < height; j++) {
      for (int i = 0; i < width; i++) {
        buffer.write(output[i + j * width]);
      }
      if (j < height - 1) {
        buffer.write('\n');
      }
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final double progress = _controller.value * math.pi * 2;
          final String asciiArt = _renderFrame(
            1.5 + progress * 0.70,
            0.5 + progress * 0.45,
            widget.width,
            widget.height,
          );

          final Widget textWidget = Text(
            asciiArt,
            textAlign: TextAlign.center,
            softWrap: false,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: widget.fontSize,
              height: 1.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.0,
              color: widget.useBrandGradient
                  ? Colors.white
                  : (widget.color ?? DowgNutColors.graffitiNavy),
            ),
          );

          if (!widget.useBrandGradient) {
            return textWidget;
          }

          return ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                DowgNutColors.graffitiNavyDark,
                DowgNutColors.graffitiNavy,
                DowgNutColors.hotPinkIcing,
                DowgNutColors.graffitiNavyLight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: textWidget,
          );
        },
      ),
    );
  }
}
