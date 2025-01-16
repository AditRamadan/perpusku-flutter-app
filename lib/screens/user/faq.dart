import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text(
          'FAQ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _faqItem(context, 'Apa itu Perpusku?',
                      'Perpusku adalah aplikasi perpustakaan digital yang memungkinkan pengguna untuk mencari dan membaca buku secara online.'),
                  _faqItem(context, 'Bagaimana cara mencari buku?',
                      'Untuk mencari buku, Anda bisa menggunakan fitur pencarian yang ada di halaman beranda atau pilih kategori buku.'),
                  _faqItem(
                      context,
                      'Apakah ada biaya untuk menggunakan aplikasi?',
                      'Aplikasi ini dapat digunakan secara gratis oleh semua pengguna, tanpa biaya tambahan.'),
                  _faqItem(context, 'Bagaimana cara mengubah profil saya?',
                      'Anda dapat mengubah profil melalui menu Pengaturan Profile yang ada di halaman profil.'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kembali',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.arrow_back, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqItem(BuildContext context, String question, String answer) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style:
                TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            answer,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
