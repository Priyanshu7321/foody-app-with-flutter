import 'package:get/get.dart';
import '../api/api_client.dart';
import '../services/auth_service.dart';
import '../services/product_service.dart';
import '../services/cart_service.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../../viewmodels/cart_viewmodel.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Core Services
    Get.lazyPut<ApiClient>(() => ApiClient(), fenix: true);
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);
    Get.lazyPut<ProductService>(() => ProductService(), fenix: true);
    Get.lazyPut<CartService>(() => CartService(), fenix: true);
    
    // ViewModels
    Get.lazyPut<AuthViewModel>(() => AuthViewModel(), fenix: true);
    Get.lazyPut<ProductViewModel>(() => ProductViewModel(), fenix: true);
    Get.lazyPut<CartViewModel>(() => CartViewModel(), fenix: true);
  }
} 