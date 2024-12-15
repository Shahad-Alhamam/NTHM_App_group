import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  double getWidth(double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100;
  }

  double getHeight(double percentage) {
    return MediaQuery.of(context).size.height * percentage / 100;
  }

  bool isMobile() {
    return MediaQuery.of(context).size.width < 600;
  }

  bool isTablet() {
    return MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1024;
  }

  bool isDesktop() {
    return MediaQuery.of(context).size.width >= 1024;
  }

  double getFontSize(double size) {
    double deviceWidth = MediaQuery.of(context).size.width;
    if (deviceWidth < 600) {
      return size * 0.8; // Mobile
    } else if (deviceWidth >= 600 && deviceWidth < 1024) {
      return size * 0.9; // Tablet
    } else {
      return size; // Desktop
    }
  }
}
