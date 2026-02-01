import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

/// Standalone script to add products to Firestore
/// Run this with: dart run lib/scripts/add_products.dart
void main() async {
  print('🚀 Starting to add products to Firestore...');
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  final firestore = FirebaseFirestore.instance;
  
  // Product data
  final products = [
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
  ];
  
  // Add products
  int count = 0;
  for (var product in products) {
    try {
      await firestore.collection('products').add(product);
      count++;
      print('✅ Added: ${product['name']}');
    } catch (e) {
      print('❌ Error adding ${product['name']}: $e');
    }
  }
  
  print('\n✨ Done! Added $count products to Firestore.');
  print('🔥 Check Firebase Console to verify: https://console.firebase.google.com/');
}
