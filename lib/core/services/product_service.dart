import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../core/api/api_client.dart';
import '../../models/product.dart';

class ProductService extends GetxService {
  static const String _productsBoxName = 'products';
  static const String _favoritesBoxName = 'favorites';
  
  late final Box<Product> _productsBox;
  late final Box<String> _favoritesBox;
  final ApiClient _apiClient = Get.find<ApiClient>();
  
  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> favorites = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    _initHive();
  }
  
  Future<void> _initHive() async {
    _productsBox = await Hive.openBox<Product>(_productsBoxName);
    _favoritesBox = await Hive.openBox<String>(_favoritesBoxName);
    _loadCachedData();
  }
  
  void _loadCachedData() {
    // Load cached products
    final cachedProducts = _productsBox.values.toList();
    if (cachedProducts.isNotEmpty) {
      products.value = cachedProducts;
    }
    
    // Load favorites
    final favoriteIds = _favoritesBox.values.toList();
    final favoriteProducts = products.where((product) => favoriteIds.contains(product.id)).toList();
    favorites.value = favoriteProducts;
  }
  
  Future<void> fetchProducts({String? category, String? search}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Simulate API call - replace with actual API endpoint
      // final response = await _apiClient.get('/products', queryParameters: {
      //   if (category != null) 'category': category,
      //   if (search != null) 'search': search,
      // });
      
      // For demo purposes, simulate API response
      await Future.delayed(const Duration(seconds: 1));
      
      // Generate demo products
      final demoProducts = _generateDemoProducts();
      
      // Filter by category if provided
      List<Product> filteredProducts = demoProducts;
      if (category != null && category.isNotEmpty) {
        filteredProducts = demoProducts.where((product) => 
          product.category.toLowerCase() == category.toLowerCase()
        ).toList();
      }
      
      // Filter by search if provided
      if (search != null && search.isNotEmpty) {
        filteredProducts = filteredProducts.where((product) =>
          product.name.toLowerCase().contains(search.toLowerCase()) ||
          product.description.toLowerCase().contains(search.toLowerCase()) ||
          product.tags.any((tag) => tag.toLowerCase().contains(search.toLowerCase()))
        ).toList();
      }
      
      products.value = filteredProducts;
      
      // Cache products
      await _cacheProducts(filteredProducts);
      
    } catch (e) {
      errorMessage.value = 'Failed to load products: ${e.toString()}';
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> fetchProductById(String id) async {
    try {
      // Check cache first
      final cachedProduct = _productsBox.get(id);
      if (cachedProduct != null) {
        return;
      }
      
      // Simulate API call
      // final response = await _apiClient.get('/products/$id');
      
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo, generate a product with the given ID
      final product = _generateDemoProduct(id);
      
      // Cache the product
      await _productsBox.put(id, product);
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to load product details');
    }
  }
  
  Future<void> _cacheProducts(List<Product> products) async {
    await _productsBox.clear();
    final Map<String, Product> productMap = {
      for (var product in products) product.id: product
    };
    await _productsBox.putAll(productMap);
  }
  
  Future<void> toggleFavorite(Product product) async {
    try {
      final isFavorite = favorites.any((p) => p.id == product.id);
      
      if (isFavorite) {
        // Remove from favorites
        favorites.removeWhere((p) => p.id == product.id);
        await _favoritesBox.delete(product.id);
      } else {
        // Add to favorites
        favorites.add(product);
        await _favoritesBox.put(product.id, product.id);
      }
      
      Get.snackbar(
        'Success', 
        isFavorite ? 'Removed from favorites' : 'Added to favorites'
      );
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to update favorites');
    }
  }
  
  bool isFavorite(String productId) {
    return favorites.any((product) => product.id == productId);
  }
  
  List<Product> getPopularProducts() {
    return products.where((product) => product.rating >= 4.5).toList();
  }
  
  List<Product> getNewProducts() {
    final now = DateTime.now();
    return products.where((product) => 
      now.difference(product.createdAt).inDays <= 7
    ).toList();
  }
  
  List<Product> getProductsByCategory(String category) {
    return products.where((product) => 
      product.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }
  
  Future<List<Product>> getProducts() async {
    try {
      // For demo purposes, return cached products or generate demo data
      if (_productsBox.isEmpty) {
        final demoProducts = _generateDemoProducts();
        await _cacheProducts(demoProducts);
        return demoProducts;
      }
      
      return _productsBox.values.toList();
    } catch (e) {
      // Fallback to demo data if cache fails
      return _generateDemoProducts();
    }
  }
  
  // Demo data generation
  List<Product> _generateDemoProducts() {
    return [
      Product(
        id: '1',
        name: 'Margherita Pizza',
        description: 'Classic Italian pizza with tomato sauce, mozzarella, and fresh basil',
        price: 18.99,
        rating: 4.8,
        reviewCount: 156,
        imageUrl: 'assets/images/pizza.jpg',
        category: 'Pizza',
        tags: ['Italian', 'Vegetarian', 'Popular'],
        isPopular: true,
        isNew: false,
        preparationTime: 25,
        deliveryFee: 2.99,
        isAvailable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Product(
        id: '2',
        name: 'Classic Burger',
        description: 'Juicy beef burger with lettuce, tomato, and special sauce',
        price: 12.99,
        rating: 4.6,
        reviewCount: 89,
        imageUrl: 'assets/images/burger.jpg',
        category: 'Burgers',
        tags: ['American', 'Beef', 'Fast Food'],
        isPopular: true,
        isNew: false,
        preparationTime: 15,
        deliveryFee: 2.99,
        isAvailable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
      ),
      Product(
        id: '3',
        name: 'Greek Salad',
        description: 'Fresh salad with feta cheese, olives, and Mediterranean dressing',
        price: 11.99,
        rating: 4.4,
        reviewCount: 67,
        imageUrl: 'assets/images/pizza.jpg',
        category: 'Salads',
        tags: ['Healthy', 'Vegetarian', 'Mediterranean'],
        isPopular: false,
        isNew: true,
        preparationTime: 10,
        deliveryFee: 2.99,
        isAvailable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Product(
        id: '4',
        name: 'Chicken Pasta',
        description: 'Creamy pasta with grilled chicken and parmesan cheese',
        price: 16.99,
        rating: 4.7,
        reviewCount: 123,
        imageUrl: 'assets/images/pasta.jpg',
        category: 'Pasta',
        tags: ['Italian', 'Chicken', 'Creamy'],
        isPopular: true,
        isNew: false,
        preparationTime: 20,
        deliveryFee: 2.99,
        isAvailable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      Product(
        id: '5',
        name: 'Sushi Roll Set',
        description: 'Assorted sushi rolls with soy sauce and wasabi',
        price: 24.99,
        rating: 4.9,
        reviewCount: 234,
        imageUrl: 'assets/images/sushi.jpg',
        category: 'Sushi',
        tags: ['Japanese', 'Seafood', 'Premium'],
        isPopular: true,
        isNew: false,
        preparationTime: 30,
        deliveryFee: 3.99,
        isAvailable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
    ];
  }
  
  Product _generateDemoProduct(String id) {
    return Product(
      id: id,
      name: 'Demo Product $id',
      description: 'This is a demo product for testing purposes',
      price: 15.99,
      rating: 4.5,
      reviewCount: 50,
      imageUrl: 'assets/images/demo.jpg',
      category: 'Demo',
      tags: ['Demo', 'Test'],
      isPopular: false,
      isNew: true,
      preparationTime: 20,
      deliveryFee: 2.99,
      isAvailable: true,
      createdAt: DateTime.now(),
    );
  }
  
  @override
  void onClose() {
    _productsBox.close();
    _favoritesBox.close();
    super.onClose();
  }
} 