import '../models/product.dart';

class SampleData {
  static List<Product> popularFoods = [
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
      imageUrl: 'assets/images/salad.jpg',
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
  ];

  static List<Product> newFoods = [
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
      isNew: true,
      preparationTime: 30,
      deliveryFee: 3.99,
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Product(
      id: '6',
      name: 'Vegan Bowl',
      description: 'Nutritious bowl with quinoa, roasted vegetables, and tahini dressing',
      price: 14.99,
      rating: 4.5,
      reviewCount: 78,
      imageUrl: 'assets/images/vegan_bowl.jpg',
      category: 'Healthy',
      tags: ['Vegan', 'Healthy', 'Gluten-Free'],
      isPopular: false,
      isNew: true,
      preparationTime: 18,
      deliveryFee: 2.99,
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Product(
      id: '7',
      name: 'Chocolate Cake',
      description: 'Rich chocolate cake with ganache frosting',
      price: 8.99,
      rating: 4.3,
      reviewCount: 45,
      imageUrl: 'assets/images/cake.jpg',
      category: 'Desserts',
      tags: ['Dessert', 'Chocolate', 'Sweet'],
      isPopular: false,
      isNew: true,
      preparationTime: 5,
      deliveryFee: 2.99,
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Product(
      id: '8',
      name: 'Iced Coffee',
      description: 'Smooth iced coffee with cream and vanilla syrup',
      price: 4.99,
      rating: 4.2,
      reviewCount: 112,
      imageUrl: 'assets/images/coffee.jpg',
      category: 'Beverages',
      tags: ['Coffee', 'Cold', 'Creamy'],
      isPopular: false,
      isNew: true,
      preparationTime: 3,
      deliveryFee: 1.99,
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
  ];

  static List<Product> getAllFoods() {
    return [...popularFoods, ...newFoods];
  }

  static List<Product> getFoodsByCategory(String category) {
    return getAllFoods().where((food) => food.category == category).toList();
  }

  static List<Product> getPopularFoods() {
    return popularFoods;
  }

  static List<Product> getNewFoods() {
    return newFoods;
  }
} 