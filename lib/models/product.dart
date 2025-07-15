import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final double rating;
  @HiveField(5)
  final int reviewCount;
  @HiveField(6)
  final String imageUrl;
  @HiveField(7)
  final String category;
  @HiveField(8)
  final List<String> tags;
  @HiveField(9)
  final bool isPopular;
  @HiveField(10)
  final bool isNew;
  @HiveField(11)
  final int preparationTime;
  @HiveField(12)
  final double deliveryFee;
  @HiveField(13)
  final bool isAvailable;
  @HiveField(14)
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.category,
    required this.tags,
    this.isPopular = false,
    this.isNew = false,
    this.preparationTime = 30,
    this.deliveryFee = 2.99,
    this.isAvailable = true,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: (json['price'] as num).toDouble(),
        rating: (json['rating'] as num).toDouble(),
        reviewCount: json['reviewCount'],
        imageUrl: json['imageUrl'],
        category: json['category'],
        tags: List<String>.from(json['tags']),
        isPopular: json['isPopular'] ?? false,
        isNew: json['isNew'] ?? false,
        preparationTime: json['preparationTime'] ?? 30,
        deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 2.99,
        isAvailable: json['isAvailable'] ?? true,
        createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'rating': rating,
        'reviewCount': reviewCount,
        'imageUrl': imageUrl,
        'category': category,
        'tags': tags,
        'isPopular': isPopular,
        'isNew': isNew,
        'preparationTime': preparationTime,
        'deliveryFee': deliveryFee,
        'isAvailable': isAvailable,
        'createdAt': createdAt.toIso8601String(),
      };

  // Convert from FoodItem for backward compatibility
  factory Product.fromFoodItem(dynamic foodItem) {
    if (foodItem is FoodItem) {
      return Product(
        id: foodItem.id,
        name: foodItem.name,
        description: foodItem.description,
        price: foodItem.price,
        rating: foodItem.rating,
        reviewCount: foodItem.reviewCount,
        imageUrl: foodItem.imageUrl,
        category: foodItem.category,
        tags: foodItem.tags,
        isPopular: foodItem.isPopular,
        isNew: foodItem.isNew,
        preparationTime: foodItem.preparationTime,
        deliveryFee: foodItem.deliveryFee,
        isAvailable: foodItem.isAvailable,
        createdAt: DateTime.now(),
      );
    }
    throw ArgumentError('Invalid food item type');
  }
}

// Temporary class for backward compatibility
class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String category;
  final List<String> tags;
  final bool isPopular;
  final bool isNew;
  final int preparationTime;
  final double deliveryFee;
  final bool isAvailable;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.category,
    required this.tags,
    this.isPopular = false,
    this.isNew = false,
    this.preparationTime = 30,
    this.deliveryFee = 2.99,
    this.isAvailable = true,
  });
} 