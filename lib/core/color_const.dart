import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF00C6FF);
  static const Color primaryPurple = Color(0xFFEE00FF);
  static const Color darkBackground = Color(0xFF0A0C2C);
  static const Color cardGradientStart = Color(0xFF2C2E4F);
  static const Color cardGradientEnd = Color(0xFF0F1030);
  // static const Color borderColorStart = Color(0xFF00C6FF); // No longer needed as fixed
  // static const Color borderColorEnd = Color(0xFFEE00FF);   // No longer needed as fixed
  static const Color searchBarBackground = Color(0xFF1E2042);
  static const Color searchBarBorder = Color(0xFF3A3C6B);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFFBFBFBF);
  static const Color chipBackground = Color(0xFF3A3C6B);
  static const Color selectedChipBackground = Color(0xFFEE00FF);

  // New: Neon-like colors for random gradients
  static const List<Color> neonColors = [
    Color(0xFF00FFFF), // Cyan
    Color(0xFF00FF00), // Lime Green
    Color(0xFFFF00FF), // Magenta
    Color(0xFFFFFF00), // Yellow
    Color(0xFFFFA500), // Orange
    Color(0xFF00BFFF), // Deep Sky Blue
    Color(0xFFE0BBE4), // Light Purple
    Color(0xFF957DAD), // Medium Purple
    Color(0xFFFF1493), // Deep Pink
  ];

  static LinearGradient generateRandomNeonGradient() {
    final random = Random();
    Color startColor = neonColors[random.nextInt(neonColors.length)];
    Color endColor = neonColors[random.nextInt(neonColors.length)];

    // Ensure start and end colors are not the same for a visible gradient
    while (startColor == endColor) {
      endColor = neonColors[random.nextInt(neonColors.length)];
    }

    return LinearGradient(
      colors: [startColor, endColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
