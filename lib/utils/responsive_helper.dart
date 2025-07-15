import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = getScreenWidth(context);
    if (screenWidth < 600) {
      return baseSize * 0.8;
    } else if (screenWidth < 900) {
      return baseSize;
    } else {
      return baseSize * 1.2;
    }
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    if (screenWidth < 600) {
      return const EdgeInsets.all(16.0);
    } else if (screenWidth < 900) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  static double getResponsiveSpacing(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    if (screenWidth < 600) {
      return 8.0;
    } else if (screenWidth < 900) {
      return 12.0;
    } else {
      return 16.0;
    }
  }

  static int getGridCrossAxisCount(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    if (screenWidth < 600) {
      return 1;
    } else if (screenWidth < 900) {
      return 2;
    } else if (screenWidth < 1200) {
      return 3;
    } else {
      return 4;
    }
  }
} 