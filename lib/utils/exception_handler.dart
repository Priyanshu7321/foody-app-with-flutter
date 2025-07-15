import 'package:flutter/material.dart';
import 'dialog_helper.dart';

class ExceptionHandler {
  static void handleException(BuildContext context, dynamic error, {String? customMessage}) {
    String message = customMessage ?? 'An unexpected error occurred. Please try again.';
    
    if (error is NetworkException) {
      message = 'Network error: Please check your internet connection.';
    } else if (error is ValidationException) {
      message = error.message;
    } else if (error is AuthenticationException) {
      message = 'Authentication failed. Please login again.';
    } else if (error is PermissionException) {
      message = 'Permission denied. Please check your settings.';
    } else if (error is TimeoutException) {
      message = 'Request timed out. Please try again.';
    } else if (error is ServerException) {
      message = 'Server error. Please try again later.';
    }
    
    DialogHelper.showErrorDialog(
      context: context,
      title: 'Error',
      message: message,
    );
  }

  static void handleNavigationException(BuildContext context, String screenName) {
    DialogHelper.showErrorDialog(
      context: context,
      title: 'Navigation Error',
      message: 'Unable to navigate to $screenName. Please try again.',
    );
  }

  static void handleActionException(BuildContext context, String action) {
    DialogHelper.showErrorDialog(
      context: context,
      title: 'Action Failed',
      message: 'Unable to $action. Please try again.',
    );
  }

  static void showFeatureNotAvailable(BuildContext context, String feature) {
    DialogHelper.showErrorDialog(
      context: context,
      title: 'Feature Not Available',
      message: '$feature is not available yet. Coming soon!',
    );
  }
}

// Custom exception classes
class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network error occurred']);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException([this.message = 'Authentication failed']);
}

class PermissionException implements Exception {
  final String message;
  PermissionException([this.message = 'Permission denied']);
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException([this.message = 'Request timed out']);
}

class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error occurred']);
} 