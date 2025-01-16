class Admin {
  final String username;
  final String password;

  Admin({required this.username, required this.password});

  // Method untuk validasi username dan password

  bool isValid(String inputUsername, String inputPassword) {
    return username == inputUsername && password == inputPassword;
  }
}
