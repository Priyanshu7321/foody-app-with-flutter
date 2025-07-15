import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'app_routes.dart';

class RouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Get the auth view model
    final authViewModel = Get.find<AuthViewModel>();
    
    // If user is not authenticated and trying to access protected routes
    if (!authViewModel.isLoggedIn.value && _isProtectedRoute(route)) {
      return const RouteSettings(name: AppRoutes.auth);
    }
    
    // If user is authenticated and trying to access auth/onboarding
    if (authViewModel.isLoggedIn.value && _isAuthRoute(route)) {
      return const RouteSettings(name: AppRoutes.home);
    }
    
    return null;
  }
  
  bool _isProtectedRoute(String? route) {
    if (route == null) return false;
    
    final protectedRoutes = [
      AppRoutes.home,
      AppRoutes.cart,
      AppRoutes.profile,
      AppRoutes.favorites,
      AppRoutes.orderConfirmation,
      AppRoutes.orderSummary,
      AppRoutes.orderTracking,
      AppRoutes.paymentStatus,
      AppRoutes.settings,
      AppRoutes.orderHistory,
      AppRoutes.paymentMethods,
      AppRoutes.addresses,
      AppRoutes.addAddress,
      AppRoutes.editProfile,
      AppRoutes.notifications,
      AppRoutes.helpSupport,
      AppRoutes.about,
    ];
    
    return protectedRoutes.contains(route);
  }
  
  bool _isAuthRoute(String? route) {
    if (route == null) return false;
    
    final authRoutes = [
      AppRoutes.onboarding,
      AppRoutes.auth,
    ];
    
    return authRoutes.contains(route);
  }
} 