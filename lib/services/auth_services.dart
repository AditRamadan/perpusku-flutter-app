import '../model/user.dart';
import '../model/admin.dart';
import 'user_services.dart';

class AuthServices {
  final UserServices _userServices = UserServices();
  final Admin _admin =
      Admin(username: 'admin', password: '1234'); // Data dummy admin

  // Login untuk pengguna biasa
  User? loginUser(String username, String password) {
    try {
      final user = _userServices
          .getAllUsers()
          .firstWhere((u) => u.username == username && u.password == password);
      return user;
    } catch (e) {
      return null; // Return null jika tidak ada user yang cocok
    }
  }

  // Login untuk admin
  bool loginAdmin(String username, String password) {
    return _admin.isValid(username, password);
  }
}
