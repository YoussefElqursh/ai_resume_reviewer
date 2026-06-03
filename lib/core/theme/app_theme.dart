import 'package:flutter/material.dart';
class AppTheme {
  AppTheme._();
  static const Color primaryColor = Color(0xFF1F2A6D);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    fontFamily: 'SF Pro Display',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: primaryColor,
      centerTitle: true,
      elevation: 0,
    ),
  );
}