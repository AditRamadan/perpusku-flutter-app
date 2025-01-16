// lib/services/product_service.dart
import '../model/kategori.dart';

class KategoriServices {
  // Simulasi database menggunakan List
  final List<Kategori> _Kategori = [];

  // Create: Menambah produk baru
  void addKategori(Kategori kategori) {
    kategori.id = DateTime.now().millisecondsSinceEpoch.toString();
    _Kategori.add(kategori);
  }

  // Read: Mendapatkan semua produk
  List<Kategori> getAllKategori() {
    return _Kategori;
  }

  // Read: Mendapatkan produk berdasarkan ID
  Kategori? getKategoriById(String id) {
    try {
      return _Kategori.firstWhere((Kategori) => Kategori.id == id);
    } catch (e) {
      return null;
    }
  }

  // Update: Memperbarui produk
  void update(Kategori updatedKategori) {
    final index =
        _Kategori.indexWhere((Kategori) => Kategori.id == updatedKategori.id);
    if (index != -1) {
      _Kategori[index] = updatedKategori;
    }
  }

  // Delete: Menghapus produk
  void deleteKategori(String id) {
    _Kategori.removeWhere((Kategori) => Kategori.id == id);
  }
}
