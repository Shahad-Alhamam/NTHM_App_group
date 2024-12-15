import 'package:flutter/material.dart';

class CustomDecorations {
  static BoxDecoration gradientBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF368fd2),
          Color(0xFFFFFFFF),
        ],
      ),
    );
  }
}
