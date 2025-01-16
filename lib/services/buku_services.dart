// lib/services/product_service.dart
import 'package:get_storage/get_storage.dart';
import '../model/buku.dart';
import 'dart:convert';

class BukuServices {
  final List<Buku> _Buku = [];
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'bukuData';

  BukuServices() {
    _loadBukuFromStorage();
  }

  void _loadBukuFromStorage() {
    final data = _storage.read(_storageKey);
    if (data != null) {
      final List decodedData = jsonDecode(data);
      _Buku.addAll(decodedData.map((e) => Buku.fromJson(e)).toList());
    }
  }

  void _saveBukuToStorage() {
    final data = jsonEncode(_Buku.map((e) => e.toJson()).toList());
    _storage.write(_storageKey, data);
  }

  // Create: Menambah produk baru
  void addBuku(Buku buku) {
    buku.id = DateTime.now().millisecondsSinceEpoch.toString();
    _Buku.add(buku);
    _saveBukuToStorage();
  }

  // Read: Mendapatkan semua produk
  List<Buku> getAllBuku() {
    return _Buku;
  }

  // Read: Mendapatkan produk berdasarkan ID
  Buku? getBukuById(String id) {
    try {
      return _Buku.firstWhere((Buku) => Buku.id == id);
    } catch (e) {
      return null;
    }
  }

  // Update: Memperbarui produk
  void updateBuku(Buku updatedBuku) {
    final index = _Buku.indexWhere((Buku) => Buku.id == updatedBuku.id);
    if (index != -1) {
      _Buku[index] = updatedBuku;
      _saveBukuToStorage();
    }
  }

  // Delete: Menghapus produk
  void deleteBuku(String id) {
    _Buku.removeWhere((Buku) => Buku.id == id);
    _saveBukuToStorage();
  }
}
