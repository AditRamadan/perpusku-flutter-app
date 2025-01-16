// lib/models/buku.dart
class Buku {
  String? id;
  String cover_buku;
  String judul;
  String deskripsi;
  String kategori;
  String penerbit;
  int tahun_terbit;
  String lokasi_buku;
  String file_buku;

  Buku({
    this.id,
    required this.cover_buku,
    required this.file_buku,
    required this.judul,
    required this.deskripsi,
    required this.kategori,
    required this.penerbit,
    required this.tahun_terbit,
    required this.lokasi_buku,
  });

  // Konversi dari Product ke Map // Mengonversi JSON menjadi objek Buku
  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'],
      cover_buku: json['cover_buku'],
      file_buku: json['file_buku'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      kategori: json['kategori'],
      penerbit: json['penerbit'],
      tahun_terbit: json['tahun_terbit'],
      lokasi_buku: json['lokasi_buku'],
    );
  }

  // Mengonversi objek Buku menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cover_buku': cover_buku,
      'file_buku': file_buku,
      'judul': judul,
      'deskripsi': deskripsi,
      'kategori': kategori,
      'penerbit': penerbit,
      'tahun_terbit': tahun_terbit,
      'lokasi_buku': lokasi_buku,
    };
  }
}
