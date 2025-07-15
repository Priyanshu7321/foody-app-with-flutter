import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../core/services/auth_service.dart';

class AuthViewModel extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  
  // Reactive variables
  final RxBool isLoading = false.obs;
  final RxBool isLoginMode = true.obs;
  final RxBool obscurePassword = true.obs;
  final RxString errorMessage = ''.obs;
  
  // Computed values
  bool get isLoggedIn => _authService.isLoggedIn.value;
  String get userName => _authService.userName.value;
  String get userEmail => _authService.userEmail.value;
  
  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes
    ever(_authService.isLoggedIn, _handleAuthStateChange);
  }
  
  void _handleAuthStateChange(bool isLoggedIn) {
    if (isLoggedIn) {
      Get.offAllNamed('/main');
    }
  }
  
  void toggleLoginMode() {
    isLoginMode.value = !isLoginMode.value;
    _clearForm();
  }
  
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
  
  void _clearForm() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    errorMessage.value = '';
  }
  
  bool _validateForm() {
    if (emailController.text.isEmpty) {
      errorMessage.value = 'Email is required';
      return false;
    }
    
    if (!GetUtils.isEmail(emailController.text)) {
      errorMessage.value = 'Please enter a valid email';
      return false;
    }
    
    if (passwordController.text.isEmpty) {
      errorMessage.value = 'Password is required';
      return false;
    }
    
    if (passwordController.text.length < 6) {
      errorMessage.value = 'Password must be at least 6 characters';
      return false;
    }
    
    if (!isLoginMode.value && nameController.text.isEmpty) {
      errorMessage.value = 'Name is required';
      return false;
    }
    
    return true;
  }
  
  Future<void> authenticate() async {
    if (!_validateForm()) return;
    
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      bool success;
      
      if (isLoginMode.value) {
        success = await _authService.login(
          emailController.text.trim(),
          passwordController.text,
        );
      } else {
        success = await _authService.register(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text,
        );
      }
      
      if (success) {
        _clearForm();
      }
      
    } catch (e) {
      errorMessage.value = 'Authentication failed: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> logout() async {
    try {
      await _authService.logout();
      Get.offAllNamed('/onboarding');
    } catch (e) {
      Get.snackbar('Error', 'Logout failed');
    }
  }
  
  Future<void> updateProfile(String name, String email) async {
    try {
      await _authService.updateProfile(name, email);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    }
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }
} 