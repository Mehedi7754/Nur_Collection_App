class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final String category;
  final String? description;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.category,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'category': category,
      if (description != null) 'description': description,
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'category': category,
      if (description != null) 'description': description,
    };
  }

  factory ProductModel.fromMap(String id, Map<String, dynamic> map) {
    return ProductModel(
      id: id,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      rating: (map['rating'] ?? 0.0).toDouble(),
      category: map['category'] ?? '',
      description: map['description'],
    );
  }
}
