// DowgNut brand theme — extracted from b68372d3-09ce-4dae-a36e-e949f9dddae2.jpg
// Palette: DowgNut Blue • Frosting Pink • Neon Lime • Dark Navy
// Tagline: BOLD PLAYFUL AUTHENTIC

import 'package:flutter/material.dart';

class DowgNutColors {
  // ── Primary: Graffiti Navy ──
  // The deep blue used for the "DOWGNUT" graffiti lettering & paint drips
  static const Color graffitiNavy = Color(0xFF07579B);
  static const Color graffitiNavyLight = Color(0xFF2D7FC2);
  static const Color graffitiNavyDark = Color(0xFF07334F);

  // ── Secondary: Hot Pink Icing ──
  // The bright pink donut icing / frosting that drips from the "O"
  static const Color hotPinkIcing = Color(0xFFF05A9B);
  static const Color hotPinkIcingSoft = Color(0xFFFF9AC7);
  static const Color hotPinkIcingDark = Color(0xFFC93373);

  // ── Background: Neon Lime ──
  // The vibrant yellow-green background paper
  static const Color neonLime = Color(0xFFE8F866);
  static const Color neonLimeBright = Color(0xFFF7FFD6);
  static const Color neonLimeDark = Color(0xFFB9C96A);

  // ── Accent: Soft Dough Pink ──
  // The light pink donut body/dough color from the pattern
  static const Color softDoughPink = Color(0xFFD4B36A);
  static const Color softDoughPinkLight = Color(0xFFFFF9E8);

  // ── Neutral: Splatter Grey ──
  // The grey paint splatter texture on the background
  static const Color splatterGrey = Color(0xFFAEA294);
  static const Color splatterGreyLight = Color(0xFFE0E0E0);

  // ── Semantic shortcuts ──
  static const Color onPrimary = Colors.white;
  static const Color onBackground = graffitiNavy;
  static const Color surface = Color(0xFFFFF9E8);
}

class DowgNutTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: DowgNutColors.graffitiNavy,
        brightness: Brightness.light,
        primary: DowgNutColors.graffitiNavy,
        onPrimary: Colors.white,
        secondary: DowgNutColors.hotPinkIcing,
        onSecondary: Colors.white,
        tertiary: DowgNutColors.neonLime,
        surface: DowgNutColors.surface,
        onSurface: DowgNutColors.graffitiNavy,
      ),
      scaffoldBackgroundColor: DowgNutColors.neonLimeBright,
      appBarTheme: const AppBarTheme(
        backgroundColor: DowgNutColors.graffitiNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DowgNutColors.hotPinkIcing,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: DowgNutColors.hotPinkIcing,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: DowgNutColors.surface,
        elevation: 4,
        shadowColor: DowgNutColors.graffitiNavy.withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      iconTheme: const IconThemeData(
        color: DowgNutColors.graffitiNavy,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: DowgNutColors.graffitiNavy,
        displayColor: DowgNutColors.graffitiNavy,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: DowgNutColors.hotPinkIcing,
        unselectedItemColor: DowgNutColors.splatterGrey,
        backgroundColor: Colors.white,
      ),
    );
  }
}
