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
  final int preparationTime; // in minutes
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

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      tags: List<String>.from(json['tags']),
      isPopular: json['isPopular'] ?? false,
      isNew: json['isNew'] ?? false,
      preparationTime: json['preparationTime'] ?? 30,
      deliveryFee: json['deliveryFee']?.toDouble() ?? 2.99,
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
} 