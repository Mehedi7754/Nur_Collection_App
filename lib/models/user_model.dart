class UserModel {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String? address;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if (password != null) 'password': password,
      if (address != null) 'address': address,
    };
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'],
      address: map['address'],
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? address,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
    );
  }
}
