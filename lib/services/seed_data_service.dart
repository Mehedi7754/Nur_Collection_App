import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants.dart';

/// Service to seed random product data into Firestore
/// This is useful for testing and demonstration purposes
class SeedDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Adds sample products to Firestore with real image URLs
  /// Categories match the app's filter categories: T-shirt, Shirt, Baby dress
  Future<void> seedProducts() async {
    final List<Map<String, dynamic>> dummyProducts = [
      // T-Shirts
      {
        'name': 'Classic White T-Shirt',
        'imageUrl': 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
        'price': 29.99,
        'rating': 4.5,
        'category': 'T-shirt',
        'description': 'Comfortable cotton white t-shirt for everyday wear.',
      },
      {
        'name': 'Black Cotton T-Shirt',
        'imageUrl': 'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=400',
        'price': 25.99,
        'rating': 4.6,
        'category': 'T-shirt',
        'description': 'Premium quality black t-shirt made from 100% cotton.',
      },
      {
        'name': 'Graphic Print T-Shirt',
        'imageUrl': 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=400',
        'price': 32.99,
        'rating': 4.5,
        'category': 'T-shirt',
        'description': 'Trendy graphic print t-shirt for casual wear.',
      },
      {
        'name': 'Grey V-Neck T-Shirt',
        'imageUrl': 'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=400',
        'price': 27.99,
        'rating': 4.4,
        'category': 'T-shirt',
        'description': 'Stylish grey v-neck t-shirt perfect for any occasion.',
      },
      
      // Shirts
      {
        'name': 'Blue Denim Shirt',
        'imageUrl': 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=400',
        'price': 49.99,
        'rating': 4.7,
        'category': 'Shirt',
        'description': 'Classic denim shirt perfect for casual occasions.',
      },
      {
        'name': 'Formal White Shirt',
        'imageUrl': 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=400',
        'price': 59.99,
        'rating': 4.8,
        'category': 'Shirt',
        'description': 'Elegant formal shirt for business and special events.',
      },
      {
        'name': 'Checked Casual Shirt',
        'imageUrl': 'https://images.unsplash.com/photo-1622445275463-afa2ab738c34?w=400',
        'price': 39.99,
        'rating': 4.4,
        'category': 'Shirt',
        'description': 'Stylish checked pattern shirt for everyday style.',
      },
      {
        'name': 'Navy Blue Polo Shirt',
        'imageUrl': 'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?w=400',
        'price': 44.99,
        'rating': 4.6,
        'category': 'Shirt',
        'description': 'Classic navy polo shirt for smart casual look.',
      },
      
      // Baby Dresses
      {
        'name': 'Baby Blue Romper',
        'imageUrl': 'https://images.unsplash.com/photo-1522771930-78848d9293e8?w=400',
        'price': 24.99,
        'rating': 4.9,
        'category': 'Baby dress',
        'description': 'Adorable baby romper in soft blue color.',
      },
      {
        'name': 'Pink Baby Dress',
        'imageUrl': 'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=400',
        'price': 29.99,
        'rating': 4.8,
        'category': 'Baby dress',
        'description': 'Cute pink dress perfect for baby girls.',
      },
      {
        'name': 'Cotton Baby Onesie',
        'imageUrl': 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=400',
        'price': 19.99,
        'rating': 4.7,
        'category': 'Baby dress',
        'description': 'Comfortable cotton onesie for babies.',
      },
      {
        'name': 'Yellow Baby Outfit',
        'imageUrl': 'https://images.unsplash.com/photo-1503944583220-79d8926ad5e2?w=400',
        'price': 22.99,
        'rating': 4.6,
        'category': 'Baby dress',
        'description': 'Cheerful yellow outfit for your little one.',
      },
    ];

    // Add each product to Firestore with some randomization
    for (var productData in dummyProducts) {
      // Add some randomness to price and rating for variety
      final random = Random();
      final priceVariance = (random.nextDouble() * 6) - 3; // +/- $3
      final ratingVariance = (random.nextDouble() * 0.4) - 0.2; // +/- 0.2

      double finalPrice = (productData['price'] as double) + priceVariance;
      double finalRating = (productData['rating'] as double) + ratingVariance;

      // Ensure values stay within reasonable ranges
      if (finalRating > 5.0) finalRating = 5.0;
      if (finalRating < 3.5) finalRating = 3.5;
      if (finalPrice < 15.0) finalPrice = 15.0;

      // Add product to Firestore
      await _firestore.collection(AppConstants.productsCollection).add({
        ...productData,
        'price': double.parse(finalPrice.toStringAsFixed(2)),
        'rating': double.parse(finalRating.toStringAsFixed(1)),
      });
    }
  }
}
