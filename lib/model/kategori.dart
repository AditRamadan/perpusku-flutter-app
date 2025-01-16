// lib/models/kategori.dart
class Kategori {
  String? id;
  String kategori;

  Kategori({
    this.id,
    required this.kategori,
  });

  // Konversi dari Product ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kategori': kategori,
    };
  }

  // Membuat Product dari Map
  factory Kategori.fromMap(Map<String, dynamic> map) {
    return Kategori(
      id: map['id'],
      kategori: map['kategori'],
    );
  }
}
