import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Colour palette ──────────────────────────────────────────────
class AppColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primary = Color(0xFFFC3D39);
  static const Color accent = Color(0xFF3B2C2C);
  static const Color cardWhite = Colors.white;
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF7A7A7A);
  static const Color starYellow = Color(0xFFFFB800);
  static const Color lightRed = Color(0xFFFFEBEB);
  static const Color divider = Color(0xFFEAEAEA);
}

// ── Theme data ──────────────────────────────────────────────────
class AppTheme {
  static ThemeData get lightTheme {
    final base = GoogleFonts.poppinsTextTheme();
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        background: AppColors.background,
      ),
      textTheme: base.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
    );
  }
}

// ── Neumorphic helpers ──────────────────────────────────────────
class AppNeumorphic {
  static BoxDecoration soft({
    Color color = Colors.white,
    double radius = 22,
    double blur = 16,
    double yOffset = 6,
    Color shadow = const Color(0x10000000),
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: shadow,
          blurRadius: blur,
          offset: Offset(0, yOffset),
        ),
      ],
    );
  }
}
