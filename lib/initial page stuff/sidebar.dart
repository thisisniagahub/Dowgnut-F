import 'package:flutter/material.dart';

import '../theme/dowgnut_logo.dart';
import '../theme/dowgnut_theme.dart';
import '../utilities.dart';

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
            'BOLD PLAYFUL\nAUTHENTIC',
            style: TextStyle(
              color: Utils.mainDark,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 0.95,
              letterSpacing: -0.8,
            ),
          )
        ],
      ),
    );
  }
}
