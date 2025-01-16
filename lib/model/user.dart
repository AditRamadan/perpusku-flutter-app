// lib/models/user.dart
class User {
  String? id;
  String nama;
  String email;
  String username;
  String password;

  User({
    this.id,
    required this.nama,
    required this.email,
    required this.username,
    required this.password,
  });

  // Konversi dari Product ke Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  // Membuat Product dari Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
    );
  }
}
