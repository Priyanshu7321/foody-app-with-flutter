import 'package:get/get.dart';
import '../core/services/cart_service.dart';
import '../models/product.dart';

class CartViewModel extends GetxController {
  final CartService _cartService = Get.find<CartService>();
  
  // Reactive variables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString specialInstructions = ''.obs;
  
  // Computed values
  List<CartItem> get cartItems => _cartService.cartItems;
  double get subtotal => _cartService.subtotal;
  double get deliveryFee => _cartService.deliveryFee;
  double get tax => _cartService.tax;
  double get total => _cartService.total;
  int get itemCount => _cartService.itemCount;
  bool get isEmpty => _cartService.isEmpty;
  
  @override
  void onInit() {
    super.onInit();
    // Listen to cart changes
    ever(_cartService.cartItems, (_) => update());
  }
  
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    try {
      await _cartService.addToCart(
        product, 
        quantity: quantity,
        specialInstructions: specialInstructions.value.isNotEmpty ? specialInstructions.value : null,
      );
      specialInstructions.value = '';
    } catch (e) {
      Get.snackbar('Error', 'Failed to add to cart');
    }
  }
  
  Future<void> updateQuantity(String productId, int newQuantity) async {
    try {
      await _cartService.updateQuantity(productId, newQuantity);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update quantity');
    }
  }
  
  Future<void> removeFromCart(String productId) async {
    try {
      await _cartService.removeFromCart(productId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove from cart');
    }
  }
  
  Future<void> clearCart() async {
    try {
      await _cartService.clearCart();
    } catch (e) {
      Get.snackbar('Error', 'Failed to clear cart');
    }
  }
  
  Future<bool> placeOrder({
    required String deliveryAddress,
    required String paymentMethod,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final success = await _cartService.placeOrder(
        deliveryAddress: deliveryAddress,
        paymentMethod: paymentMethod,
        specialInstructions: specialInstructions.value.isNotEmpty ? specialInstructions.value : null,
      );
      
      if (success) {
        specialInstructions.value = '';
        Get.offAllNamed('/order-confirmation');
      }
      
      return success;
      
    } catch (e) {
      errorMessage.value = 'Failed to place order: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  CartItem? getCartItem(String productId) {
    return _cartService.getCartItem(productId);
  }
  
  bool isInCart(String productId) {
    return _cartService.isInCart(productId);
  }
  
  int getQuantity(String productId) {
    return _cartService.getQuantity(productId);
  }
  
  void updateSpecialInstructions(String instructions) {
    specialInstructions.value = instructions;
  }
  
  void clearSpecialInstructions() {
    specialInstructions.value = '';
  }
  
  // Helper methods for UI
  String getFormattedSubtotal() => '\$${subtotal.toStringAsFixed(2)}';
  String getFormattedDeliveryFee() => '\$${deliveryFee.toStringAsFixed(2)}';
  String getFormattedTax() => '\$${tax.toStringAsFixed(2)}';
  String getFormattedTotal() => '\$${total.toStringAsFixed(2)}';
  
  String getItemCountText() {
    if (itemCount == 0) return 'Empty Cart';
    if (itemCount == 1) return '1 Item';
    return '$itemCount Items';
  }
  
  String getDeliveryTimeEstimate() {
    if (isEmpty) return '';
    
    // Calculate estimated delivery time based on items
    int maxPrepTime = 0;
    for (final item in cartItems) {
      if (item.product.preparationTime > maxPrepTime) {
        maxPrepTime = item.product.preparationTime;
      }
    }
    
    final deliveryTime = maxPrepTime + 15; // 15 minutes for delivery
    return '$deliveryTime-${deliveryTime + 10} min';
  }
  
  List<CartItem> getItemsByCategory(String category) {
    return cartItems.where((item) => 
      item.product.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }
  
  double getSubtotalByCategory(String category) {
    return getItemsByCategory(category)
        .fold(0.0, (sum, item) => sum + item.totalPrice);
  }
  
  void applyDiscount(double discountPercentage) {
    // This would be implemented with actual discount logic
    // For now, just show a message
    Get.snackbar('Discount Applied', '${discountPercentage.toStringAsFixed(0)}% discount applied!');
  }
  
  void applyPromoCode(String code) {
    // This would validate and apply promo codes
    // For demo purposes, show a message
    Get.snackbar('Promo Code', 'Promo code "$code" applied!');
  }
} 