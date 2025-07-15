import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../core/api/api_client.dart';
import '../../models/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final String? specialInstructions;
  
  CartItem({
    required this.product,
    required this.quantity,
    this.specialInstructions,
  });
  
  double get totalPrice => product.price * quantity;
  
  CartItem copyWith({
    Product? product,
    int? quantity,
    String? specialInstructions,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }
}

class CartService extends GetxService {
  static const String _cartBoxName = 'cart';
  
  late final Box<CartItem> _cartBox;
  final ApiClient _apiClient = Get.find<ApiClient>();
  
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Computed values
  double get subtotal => cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => cartItems.isNotEmpty ? 2.99 : 0.0;
  double get tax => subtotal * 0.08; // 8% tax
  double get total => subtotal + deliveryFee + tax;
  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => cartItems.isEmpty;
  
  @override
  void onInit() {
    super.onInit();
    _initHive();
  }
  
  Future<void> _initHive() async {
    _cartBox = await Hive.openBox<CartItem>(_cartBoxName);
    _loadCachedCart();
  }
  
  void _loadCachedCart() {
    final cachedItems = _cartBox.values.toList();
    cartItems.value = cachedItems;
  }
  
  Future<void> addToCart(Product product, {int quantity = 1, String? specialInstructions}) async {
    try {
      final existingIndex = cartItems.indexWhere((item) => item.product.id == product.id);
      
      if (existingIndex != -1) {
        // Update existing item
        final existingItem = cartItems[existingIndex];
        final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
          specialInstructions: specialInstructions ?? existingItem.specialInstructions,
        );
        
        cartItems[existingIndex] = updatedItem;
        await _cartBox.put(product.id, updatedItem);
      } else {
        // Add new item
        final newItem = CartItem(
          product: product,
          quantity: quantity,
          specialInstructions: specialInstructions,
        );
        
        cartItems.add(newItem);
        await _cartBox.put(product.id, newItem);
      }
      
      Get.snackbar('Success', 'Added to cart');
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to add to cart');
    }
  }
  
  Future<void> updateQuantity(String productId, int newQuantity) async {
    try {
      final index = cartItems.indexWhere((item) => item.product.id == productId);
      
      if (index != -1) {
        if (newQuantity <= 0) {
          // Remove item
          await removeFromCart(productId);
        } else {
          // Update quantity
          final item = cartItems[index];
          final updatedItem = item.copyWith(quantity: newQuantity);
          
          cartItems[index] = updatedItem;
          await _cartBox.put(productId, updatedItem);
        }
      }
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to update quantity');
    }
  }
  
  Future<void> removeFromCart(String productId) async {
    try {
      cartItems.removeWhere((item) => item.product.id == productId);
      await _cartBox.delete(productId);
      
      Get.snackbar('Success', 'Removed from cart');
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove from cart');
    }
  }
  
  Future<void> clearCart() async {
    try {
      cartItems.clear();
      await _cartBox.clear();
      
      Get.snackbar('Success', 'Cart cleared');
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to clear cart');
    }
  }
  
  Future<bool> placeOrder({
    required String deliveryAddress,
    required String paymentMethod,
    String? specialInstructions,
  }) async {
    try {
      if (cartItems.isEmpty) {
        Get.snackbar('Error', 'Cart is empty');
        return false;
      }
      
      isLoading.value = true;
      errorMessage.value = '';
      
      // Prepare order data
      final orderData = {
        'items': cartItems.map((item) => {
          'productId': item.product.id,
          'quantity': item.quantity,
          'price': item.product.price,
          'specialInstructions': item.specialInstructions,
        }).toList(),
        'deliveryAddress': deliveryAddress,
        'paymentMethod': paymentMethod,
        'specialInstructions': specialInstructions,
        'subtotal': subtotal,
        'deliveryFee': deliveryFee,
        'tax': tax,
        'total': total,
      };
      
      // Simulate API call - replace with actual API endpoint
      // final response = await _apiClient.post('/orders', data: orderData);
      
      // For demo purposes, simulate order placement
      await Future.delayed(const Duration(seconds: 2));
      
      // Clear cart after successful order
      await clearCart();
      
      Get.snackbar('Success', 'Order placed successfully!');
      return true;
      
    } catch (e) {
      errorMessage.value = 'Failed to place order: ${e.toString()}';
      Get.snackbar('Error', 'Failed to place order');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  CartItem? getCartItem(String productId) {
    try {
      return cartItems.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }
  
  bool isInCart(String productId) {
    return cartItems.any((item) => item.product.id == productId);
  }
  
  int getQuantity(String productId) {
    final item = getCartItem(productId);
    return item?.quantity ?? 0;
  }
  
  @override
  void onClose() {
    _cartBox.close();
    super.onClose();
  }
} 