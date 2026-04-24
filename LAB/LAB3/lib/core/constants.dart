import 'package:flutter/material.dart';

class AppColors {
  static const primaryGradientStart = Color(0xFF667eea);
  static const primaryGradientEnd = Color(0xFF764ba2);
  static const secondaryGradientStart = Color(0xFFf093fb);
  static const secondaryGradientEnd = Color(0xFFF5576c);
  static const successColor = Color(0xFF4ade80);
  static const expenseColor = Color(0xFFf87171);
  static const backgroundColor = Color(0xFFF5F7FA);
  static const cardBackground = Colors.white;
  static const textPrimary = Color(0xFF1e293b);
  static const textSecondary = Color(0xFF64748b);
}

class AppStyles {
  static const headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const balanceText = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 1.2,
  );
}

class AppConstants {
  static const String appName = 'NeoBank';
  static const String currency = '৳';
  static const String dbName = 'banking_system.db';
  static const int dbVersion = 1;
}
