import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // WhatsApp-like colors
  static const Color primaryGreen = Color(0xFF075E54);
  static const Color secondaryGreen = Color(0xFF128C7E);
  static const Color lightGreen = Color(0xFF25D366);
  static const Color accentBlue = Color(0xFF34B7F1);
  static const Color background = Color(0xFFECE5DD);
  static const Color chatBackground = Color(0xFFECE5DD);
  static const Color outgoingMessage = Color(0xFFDCF8C6);
  static const Color incomingMessage = Colors.white;
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: secondaryGreen,
        surface: Colors.white,
        background: background,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: lightGreen,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF1F2C34),
        secondary: secondaryGreen,
        surface: Color(0xFF121B22),
        background: Color(0xFF0B141A),
        onPrimary: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF0B141A),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F2C34),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
