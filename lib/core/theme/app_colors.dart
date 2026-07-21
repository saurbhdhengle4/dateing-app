import 'package:flutter/material.dart';

/// Colors sampled/approximated from the reference screen recording.
/// Warm cream background, dark navy for nav & primary text, coral accent.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFFf6f1e9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF6F2EC);

  static const Color navy = Color(0xFF1C1B1F);
  static const Color navySoft = Color(0xFF2E2C33);

  static const Color coral = Color(0xFFf7afc4);
  static const Color coralSoft = Color(0xFFFFD9D2);

  static const Color textPrimary = Color(0xFF1C1B1F);
  static const Color textSecondary = Color(0xFF8C8781);
  static const Color textOnDark = Color(0xFFFFFFFF);

  static const Color online = Color(0xFF4CD964);
  static const Color divider = Color(0xFFE3DDD5);
  static const Color error = Color(0xFFE85C4A);

  static const List<Color> cardGradient = [
    Color(0x00000000),
    Color(0xCC000000),
  ];

  static Color? get white => Color(0xFFFFFFFF);

  static Color get black => Colors.black;
}
