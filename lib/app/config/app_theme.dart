import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      //TODO: primary need to change
      // primaryColor: const Color(0xFF0044F0),
      fontFamily: 'Sora', // 👈 default font

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'SFPro', // 👈 override for specific text
          fontWeight: FontWeight.w700,
          fontSize: 32,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Sora',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Sora',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black54,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0E0E0E),
      fontFamily: 'Sora',
      textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
    );
  }
}
