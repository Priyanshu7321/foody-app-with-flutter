import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api/api_client.dart';

class AuthService extends GetxService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _userNameKey = 'user_name';
  
  late final SharedPreferences _prefs;
  final ApiClient _apiClient = Get.find<ApiClient>();
  
  final RxBool isLoggedIn = false.obs;
  final RxString token = ''.obs;
  final RxString userId = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userName = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    _initPrefs();
  }
  
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadStoredAuth();
  }
  
  void _loadStoredAuth() {
    final storedToken = _prefs.getString(_tokenKey);
    final storedUserId = _prefs.getString(_userIdKey);
    final storedEmail = _prefs.getString(_userEmailKey);
    final storedName = _prefs.getString(_userNameKey);
    
    if (storedToken != null && storedToken.isNotEmpty) {
      token.value = storedToken;
      userId.value = storedUserId ?? '';
      userEmail.value = storedEmail ?? '';
      userName.value = storedName ?? '';
      isLoggedIn.value = true;
    }
  }
  
  Future<bool> login(String email, String password) async {
    try {
      // Simulate API call - replace with actual API endpoint
      // final response = await _apiClient.post('/auth/login', data: {
      //   'email': email,
      //   'password': password,
      // });
      
      // For demo purposes, simulate successful login
      await Future.delayed(const Duration(seconds: 1));
      
      // Simulate response data
      final responseData = <String, dynamic>{
        'token': 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
        'user': <String, dynamic>{
          'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
          'email': email,
          'name': 'Demo User',
        }
      };
      
      final userData = responseData['user'] as Map<String, dynamic>;
      
      await _saveAuthData(
        responseData['token'] as String,
        userData['id'] as String,
        userData['email'] as String,
        userData['name'] as String,
      );
      
      Get.snackbar('Success', 'Login successful!');
      return true;
      
    } catch (e) {
      Get.snackbar('Error', 'Login failed. Please check your credentials.');
      return false;
    }
  }
  
  Future<bool> register(String name, String email, String password) async {
    try {
      // Simulate API call - replace with actual API endpoint
      // final response = await _apiClient.post('/auth/register', data: {
      //   'name': name,
      //   'email': email,
      //   'password': password,
      // });
      
      // For demo purposes, simulate successful registration
      await Future.delayed(const Duration(seconds: 1));
      
      // Simulate response data
      final responseData = <String, dynamic>{
        'token': 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
        'user': <String, dynamic>{
          'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
          'email': email,
          'name': name,
        }
      };
      
      final userData = responseData['user'] as Map<String, dynamic>;
      
      await _saveAuthData(
        responseData['token'] as String,
        userData['id'] as String,
        userData['email'] as String,
        userData['name'] as String,
      );
      
      Get.snackbar('Success', 'Registration successful!');
      return true;
      
    } catch (e) {
      Get.snackbar('Error', 'Registration failed. Please try again.');
      return false;
    }
  }
  
  Future<void> _saveAuthData(String token, String userId, String email, String name) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setString(_userIdKey, userId);
    await _prefs.setString(_userEmailKey, email);
    await _prefs.setString(_userNameKey, name);
    
    this.token.value = token;
    this.userId.value = userId;
    this.userEmail.value = email;
    this.userName.value = name;
    isLoggedIn.value = true;
  }
  
  Future<void> logout() async {
    try {
      // Call logout API if needed
      // await _apiClient.post('/auth/logout');
      
      // Clear local storage
      await _prefs.remove(_tokenKey);
      await _prefs.remove(_userIdKey);
      await _prefs.remove(_userEmailKey);
      await _prefs.remove(_userNameKey);
      
      // Reset reactive variables
      token.value = '';
      userId.value = '';
      userEmail.value = '';
      userName.value = '';
      isLoggedIn.value = false;
      
      Get.snackbar('Success', 'Logged out successfully');
      
    } catch (e) {
      Get.snackbar('Error', 'Logout failed');
    }
  }
  
  Future<void> updateProfile(String name, String email) async {
    try {
      // Simulate API call
      // final response = await _apiClient.put('/auth/profile', data: {
      //   'name': name,
      //   'email': email,
      // });
      
      await Future.delayed(const Duration(seconds: 1));
      
      // Update local storage
      await _prefs.setString(_userEmailKey, email);
      await _prefs.setString(_userNameKey, name);
      
      userEmail.value = email;
      userName.value = name;
      
      Get.snackbar('Success', 'Profile updated successfully');
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    }
  }
  
  bool get hasValidToken => token.value.isNotEmpty;
  
  String? get authToken => token.value.isNotEmpty ? token.value : null;
} 