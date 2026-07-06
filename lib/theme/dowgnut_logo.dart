// DowgNut logo — extracted from the supplied graffiti/street-art brand image.
// Style: blue graffiti wordmark, pink dripping donut as "O", paint accents.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dowgnut_theme.dart';

class DowgNutLogo extends StatelessWidget {
  static const String wordmarkAsset =
      'assets/brand/dowgnut_logo_wordmark_transparent.png';

  final double size;
  final bool showText;

  /// If true, renders text in white (for dark backgrounds / splash)
  final bool reversed;

  const DowgNutLogo({
    super.key,
    this.size = 64,
    this.showText = true,
    this.reversed = false,
  });

  @override
  Widget build(BuildContext context) {
    if (showText) {
      return Image.asset(
        wordmarkAsset,
        width: size * 3.35,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      );
    }

    if (!showText) {
      // Icon-only mode: just the dripping donut
      return CustomPaint(
        size: Size(size, size),
        painter: _DrippingDonutPainter(),
      );
    }

    return const SizedBox.shrink();
  }
}

/// Paints a pink dripping donut — matches the brand image "O" glyph.
/// Features:
/// - Soft pink dough body
/// - Hot pink icing on top half with wavy drip edge
/// - Navy outline
/// - Inner hole
/// - 3 paint drips hanging from bottom of icing
class _DrippingDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h * 0.42; // push donut up so drips have room
    final radius = w * 0.38;

    // ── 1. Donut body (soft pink dough) ──
    final doughPaint = Paint()..color = DowgNutColors.softDoughPink;
    canvas.drawCircle(Offset(cx, cy), radius, doughPaint);

    // ── 2. Hot pink icing on top half with clean bottom edge ──
    final icingPaint = Paint()..color = DowgNutColors.hotPinkIcing;
    final icingPath = Path();

    // Start from left edge of circle at equator
    icingPath.moveTo(cx - radius, cy);

    // Arc across the top
    icingPath.addArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      math.pi, // start at left (180°)
      math.pi, // sweep to right (top half)
    );

    // Straight bottom edge for a cleaner logo-style donut shape
    icingPath.lineTo(cx + radius, cy);
    icingPath.close();
    canvas.drawPath(icingPath, icingPaint);

    // ── 3. Inner donut hole ──
    final holePaint = Paint()
      ..color = DowgNutColors.neonLimeBright
      ..blendMode = BlendMode.srcOver;
    canvas.drawCircle(Offset(cx, cy), radius * 0.25, holePaint);

    // ── 5. Navy outline for donut ring ──
    final outlinePaint = Paint()
      ..color = DowgNutColors.graffitiNavy
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(Offset(cx, cy), radius, outlinePaint);

    // Inner hole outline
    final holeOutline = Paint()
      ..color = DowgNutColors.graffitiNavy
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.04;
    canvas.drawCircle(Offset(cx, cy), radius * 0.25, holeOutline);

    // ── 6. Highlight dot (shine) ──
    final shinePaint = Paint()..color = Colors.white.withOpacity(0.5);
    canvas.drawCircle(
      Offset(cx - radius * 0.25, cy - radius * 0.30),
      radius * 0.08,
      shinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
