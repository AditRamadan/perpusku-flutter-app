// lib/services/user_service.dart
import 'package:get_storage/get_storage.dart';
import '../model/user.dart';
import 'dart:convert';

class UserServices {
  final List<User> _users = [];
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'userData';

  UserServices() {
    _loadUsersFromStorage();
  }

  void _loadUsersFromStorage() {
    final data = _storage.read(_storageKey);
    if (data != null) {
      final List decodedData = jsonDecode(data);
      _users.addAll(decodedData.map((e) => User.fromJson(e)).toList());
    }
  }

  void _saveUsersToStorage() {
    final data = jsonEncode(_users.map((e) => e.toJson()).toList());
    _storage.write(_storageKey, data);
  }

  // Create: Menambah user baru
  void addUser(User user) {
    user.id = DateTime.now().millisecondsSinceEpoch.toString();
    _users.add(user);
    _saveUsersToStorage();
  }

  // Read: Mendapatkan semua user
  List<User> getAllUsers() {
    return _users;
  }

  // Read: Mendapatkan user berdasarkan ID
  User? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  // Update: Memperbarui user
  void updateUser(User updatedUser) {
    final index = _users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser;
      _saveUsersToStorage();
    }
  }

  // Delete: Menghapus user
  void deleteUser(String id) {
    _users.removeWhere((user) => user.id == id);
    _saveUsersToStorage();
  }
}
