import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../utils/constants.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User Operations
  Future<void> createUser(UserModel user) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.id)
        .set(user.toMap());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .get();
    if (doc.exists) {
      return UserModel.fromMap(userId, doc.data()!);
    }
    return null;
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .update(data);
  }

  // Product Operations
  Stream<List<ProductModel>> getProducts({String? category}) {
    Query query = _firestore.collection(AppConstants.productsCollection);
    
    if (category != null && category != 'All') {
      query = query.where('category', isEqualTo: category);
    }
    
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Stream<List<ProductModel>> searchProducts(String searchQuery) {
    // Convert search query to lowercase for case-insensitive search
    final queryLower = searchQuery.toLowerCase();
    
    // Firestore doesn't support case-insensitive search natively
    // So we get all products and filter in memory
    return _firestore
        .collection(AppConstants.productsCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .where((product) =>
              product.name.toLowerCase().contains(queryLower) ||
              product.category.toLowerCase().contains(queryLower))
          .toList();
    });
  }

  // Order Operations
  Future<String> createOrder(OrderModel order) async {
    final docRef = await _firestore
        .collection(AppConstants.ordersCollection)
        .add(order.toMap());
    return docRef.id;
  }

  Stream<List<OrderModel>> getUserOrders(String userId) {
    return _firestore
        .collection(AppConstants.ordersCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
