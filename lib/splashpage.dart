import 'dart:async';

import 'package:flutter/material.dart';

import 'theme/dowgnut_theme.dart';
import 'theme/dowgnut_logo.dart';
import 'theme/ascii_donut.dart';
import 'utilities.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Utils.mainAppNav.currentState?.pushReplacementNamed('/main');
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DowgNutColors.neonLimeBright,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const AsciiDonutWidget(
                fontSize: 7.2,
                width: 48,
                height: 22,
                useBrandGradient: true,
              ),
            ),
            const SizedBox(height: 24),
            const DowgNutLogo(size: 92, showText: true),
            const SizedBox(height: 12),
            const Text(
              DowgNutText.tagline,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: DowgNutText.taglineFontFamily,
                fontSize: 26,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.7,
                shadows: DowgNutText.taglineShadows,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
