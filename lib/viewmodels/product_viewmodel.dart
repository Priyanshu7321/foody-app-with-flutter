import 'package:get/get.dart';
import '../core/services/product_service.dart';
import '../models/product.dart';

class ProductViewModel extends GetxController {
  final ProductService _productService = Get.find<ProductService>();
  
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Filtered products
  final RxList<Product> popularProducts = <Product>[].obs;
  final RxList<Product> newProducts = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }
  
  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final productsList = await _productService.getProducts();
      products.value = productsList;
      
      // Update filtered lists
      _updateFilteredProducts();
      
    } catch (e) {
      errorMessage.value = 'Failed to load products: ${e.toString()}';
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }
  
  void _updateFilteredProducts() {
    popularProducts.value = products.where((product) => product.isPopular).toList();
    newProducts.value = products.where((product) => product.isNew).toList();
  }
  
  Future<void> refreshProducts() async {
    await loadProducts();
  }
  
  List<Product> getProductsByCategory(String category) {
    return products.where((product) => product.category == category).toList();
  }
  
  List<Product> searchProducts(String query) {
    if (query.isEmpty) return products;
    
    final lowercaseQuery = query.toLowerCase();
    return products.where((product) {
      return product.name.toLowerCase().contains(lowercaseQuery) ||
             product.description.toLowerCase().contains(lowercaseQuery) ||
             product.category.toLowerCase().contains(lowercaseQuery) ||
             product.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }
  
  Product? getProductById(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
  
  List<Product> getPopularProducts({int limit = 4}) {
    return popularProducts.take(limit).toList();
  }
  
  List<Product> getNewProducts({int limit = 4}) {
    return newProducts.take(limit).toList();
  }
} 