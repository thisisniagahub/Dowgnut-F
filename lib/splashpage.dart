import 'dart:async';

import 'package:flutter/material.dart';

import 'theme/dowgnut_theme.dart';
import 'theme/dowgnut_logo.dart';
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
      backgroundColor: DowgNutColors.neonLime,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const DowgNutLogo(size: 120, showText: false),
            ),
            const SizedBox(height: 24),
            const DowgNutLogo(size: 92, showText: true),
            const SizedBox(height: 12),
            const Text(
              'BOLD PLAYFUL AUTHENTIC',
              style: TextStyle(
                color: DowgNutColors.graffitiNavyDark,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
