class Category {
  final String id;
  final String name;
  final String icon;
  final String imageUrl;
  final int itemCount;
  final bool isSelected;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageUrl,
    this.itemCount = 0,
    this.isSelected = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      imageUrl: json['imageUrl'],
      itemCount: json['itemCount'] ?? 0,
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'imageUrl': imageUrl,
      'itemCount': itemCount,
      'isSelected': isSelected,
    };
  }

  Category copyWith({
    String? id,
    String? name,
    String? icon,
    String? imageUrl,
    int? itemCount,
    bool? isSelected,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      imageUrl: imageUrl ?? this.imageUrl,
      itemCount: itemCount ?? this.itemCount,
      isSelected: isSelected ?? this.isSelected,
    );
  }
} 