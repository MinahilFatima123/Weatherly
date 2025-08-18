import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 71,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}
