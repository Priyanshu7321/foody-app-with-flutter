import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product.dart';
import 'app_routes.dart';

class RouteHelper {
  // Navigation to main screens
  static void goToHome() {
    Get.offAllNamed(AppRoutes.home);
  }
  
  static void goToAuth() {
    Get.offAllNamed(AppRoutes.auth);
  }
  
  static void goToOnboarding() {
    Get.offAllNamed(AppRoutes.onboarding);
  }
  
  // Navigation with data
  static void goToFoodDetail(Product product) {
    Get.toNamed(AppRoutes.foodDetail, arguments: product);
  }
  
  static void goToSearch() {
    Get.toNamed(AppRoutes.search);
  }
  
  static void goToCart() {
    Get.toNamed(AppRoutes.cart);
  }
  
  static void goToProfile() {
    Get.toNamed(AppRoutes.profile);
  }
  
  static void goToFavorites() {
    Get.toNamed(AppRoutes.favorites);
  }
  
  // Order related navigation
  static void goToOrderConfirmation() {
    Get.offAllNamed(AppRoutes.orderConfirmation);
  }
  
  static void goToOrderSummary() {
    Get.toNamed(AppRoutes.orderSummary);
  }
  
  static void goToOrderTracking() {
    Get.toNamed(AppRoutes.orderTracking);
  }
  
  static void goToPaymentStatus() {
    Get.toNamed(AppRoutes.paymentStatus);
  }
  
  // Profile related navigation
  static void goToSettings() {
    Get.toNamed(AppRoutes.settings);
  }
  
  static void goToOrderHistory() {
    Get.toNamed(AppRoutes.orderHistory);
  }
  
  static void goToPaymentMethods() {
    Get.toNamed(AppRoutes.paymentMethods);
  }
  
  static void goToAddresses() {
    Get.toNamed(AppRoutes.addresses);
  }
  
  static void goToAddAddress() {
    Get.toNamed(AppRoutes.addAddress);
  }
  
  static void goToEditProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }
  
  static void goToNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }
  
  static void goToHelpSupport() {
    Get.toNamed(AppRoutes.helpSupport);
  }
  
  static void goToAbout() {
    Get.toNamed(AppRoutes.about);
  }
  
  // Back navigation
  static void goBack() {
    Get.back();
  }
  
  static void goBackToHome() {
    Get.until((route) => route.settings.name == AppRoutes.home);
  }
  
  // Utility methods
  static bool canGoBack() {
    return Navigator.canPop(Get.context!);
  }
  
  static void clearStack() {
    Get.offAllNamed(AppRoutes.home);
  }
} 