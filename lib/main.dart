// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/admin/login_admin.dart';
import 'screens/user/login_page.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init(); // Inisialisasi GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpusku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
