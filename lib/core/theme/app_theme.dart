import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0E1220),
    primaryColor: const Color(0xFFA06AFF),
    cardColor: const Color(0xFF151A2C),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white.withOpacity(0.85)),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0E1220),
      elevation: 0,
    ),
  );
}
