import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF1F2A6D);
  static const Color primaryDark = Color(0xFF7B91F5);
  static const Color darkBackground = Color(0xFF0F1120);
  static const Color darkSurface = Color(0xFF1A1E36);
  static const Color darkCard = Color(0xFF232845);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: Color(0xFF8A8FB9),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSurface: Color(0xFF1A1A2E),
    ),
    fontFamily: 'SF Pro Display',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: primaryColor,
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFD7E0EB)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
    ),
    iconTheme: const IconThemeData(color: primaryColor),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1A1A2E)),
      bodyMedium: TextStyle(color: Color(0xFF4A4A6A)),
      titleLarge: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    primaryColor: primaryDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryDark,
      secondary: Color(0xFF8A8FB9),
      surface: darkSurface,
      onPrimary: Colors.white,
      onSurface: Color(0xFFE8EAFF),
    ),
    fontFamily: 'SF Pro Display',
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: primaryDark,
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF2E3460)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2E3460),
    ),
    iconTheme: const IconThemeData(color: primaryDark),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFE8EAFF)),
      bodyMedium: TextStyle(color: Color(0xFFAAB0D8)),
      titleLarge: TextStyle(color: Color(0xFFE8EAFF), fontWeight: FontWeight.bold),
    ),
  );
}