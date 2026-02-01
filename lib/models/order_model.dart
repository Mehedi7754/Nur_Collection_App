class OrderModel {
  final String id;
  final String userId;
  final String address;
  final List<OrderProduct> products;
  final double totalPrice;
  final DateTime orderDate;
  final String? mobileNumber;
  final String? customerName;

  OrderModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.products,
    required this.totalPrice,
    required this.orderDate,
    this.mobileNumber,
    this.customerName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'address': address,
      'products': products.map((p) => p.toMap()).toList(),
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
      if (mobileNumber != null) 'mobileNumber': mobileNumber,
      if (customerName != null) 'customerName': customerName,
    };
  }

  factory OrderModel.fromMap(String id, Map<String, dynamic> map) {
    return OrderModel(
      id: id,
      userId: map['userId'] ?? '',
      address: map['address'] ?? '',
      products: (map['products'] as List? ?? [])
          .map((p) => OrderProduct.fromMap(p))
          .toList(),
      totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
      orderDate: DateTime.parse(map['orderDate'] ?? DateTime.now().toIso8601String()),
      mobileNumber: map['mobileNumber'],
      customerName: map['customerName'],
    );
  }
}

class OrderProduct {
  final String productId;
  final String status;
  final int quantity;
  final double price;

  OrderProduct({
    required this.productId,
    required this.status,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'status': status,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      productId: map['productId'] ?? '',
      status: map['status'] ?? 'Pending',
      quantity: map['quantity'] ?? 1,
      price: (map['price'] ?? 0.0).toDouble(),
    );
  }
}
