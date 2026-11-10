import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark Cyber Blue Backgrounds
  static const Color background = Color(0xFF030712); // Deep midnight black/blue
  static const Color surface = Color(0xFF0B1528); // Dark cyber navy
  static const Color surfaceLight = Color(0xFF13233F);
  static const Color cardBg = Color(0xFF0D1B36);

  // Blue Gradients & Accents
  static const Color primaryBlue = Color(0xFF0072FF); // Vivid electric blue
  static const Color cyanAccent = Color(0xFF00D2FF); // Neon cyan
  static const Color brightGlow = Color(0xFF38BDF8); // Sky blue glow
  static const Color deepNavy = Color(0xFF002244);

  // Neutral / White
  static const Color textWhite = Color(0xFFF8FAFC);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textDark = Color(0xFF64748B);
  static const Color borderGlow = Color(0x3338BDF8);
  static const Color borderLight = Color(0x1AFFFFFF);

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [cyanAccent, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF0F2042), Color(0xFF081226)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroTextGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFBAE6FD), cyanAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glowGradient = LinearGradient(
    colors: [Color(0x3300D2FF), Color(0x110072FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primaryBlue,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlue,
        secondary: AppColors.cyanAccent,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: AppColors.textWhite,
        displayColor: AppColors.textWhite,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0A162D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0x3338BDF8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0x2238BDF8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cyanAccent, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.textMuted),
        hintStyle: const TextStyle(color: Color(0xFF64748B)),
      ),
    );
  }
}

