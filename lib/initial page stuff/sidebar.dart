import 'package:flutter/material.dart';

import '../theme/dowgnut_logo.dart';
import '../theme/dowgnut_theme.dart';

class DonutSideMenu extends StatelessWidget {
  const DonutSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DowgNutColors.neonLime,
      padding: const EdgeInsets.all(40),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: DowgNutLogo(size: 58),
          ),
          DowgNutLogo(size: 36, showText: false),
          Text(
            'GOOD VIBES &\nGOOD DOWG',
            semanticsLabel: DowgNutText.tagline,
            style: TextStyle(
              color: Colors.white,
              fontFamily: DowgNutText.taglineFontFamily,
              fontSize: 32,
              fontWeight: FontWeight.w400,
              height: 0.92,
              letterSpacing: 0.5,
              shadows: DowgNutText.taglineShadows,
            ),
          )
        ],
      ),
    );
  }
}
