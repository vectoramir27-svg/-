import 'package:flutter/material.dart';

class AppColors {
  // Основные цвета
  static const Color primaryBlue = Color(0xFF2F80ED);
  static const Color accentCyan = Color(0xFF00D2FF);
  static const Color softPurple = Color(0xFF9B51E0);
  
  // Фоны
  static const Color bgLight = Color(0xFFFFFFFF);
  static const Color bgDark = Color(0xFF121417);
  static const Color cardLight = Color(0xFFF6F8FB);
  static const Color cardDark = Color(0xFF1E2228);
  
  // Текст
  static const Color textDark = Color(0xFF14171A);
  static const Color textGray = Color(0xFF8C96A3);
  static const Color textMuted = Color(0xFFB0B7C3);
  
  // Индикаторы и опасные действия
  static const Color dangerRed = Color(0xFFEB5757);
  static const Color successGreen = Color(0xFF27AE60);
  static const Color warningOrange = Color(0xFFF2994A);

  // Градиенты для кругов и иконок онбординга
  static const LinearGradient bluePurpleGradient = LinearGradient(
    colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient shieldGradient = LinearGradient(
    colors: [Color(0xFF6FCF97), Color(0xFF27AE60)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient ghostGradient = LinearGradient(
    colors: [Color(0xFFBB6BD9), Color(0xFF8E44AD)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient fenixGradient = LinearGradient(
    colors: [Color(0xFFFF7675), Color(0xFFD63031)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}