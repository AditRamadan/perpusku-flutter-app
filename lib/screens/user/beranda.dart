import 'dart:convert'; // Add this import at the top of the file

import 'package:flutter/material.dart';
import '../../model/buku.dart';
import '../../services/buku_services.dart';
import 'buku_page.dart';
import 'katalog.dart';
import 'koleksi.dart';
import 'profil_screen.dart';
import 'login_page.dart';

class Beranda extends StatelessWidget {
  final BukuServices _bukuServices = BukuServices(); // Instance BukuServices

  Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    List<Buku> bukuList = _bukuServices.getAllBuku(); // Ambil semua buku

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Row(
          children: [
            Text(
              "PERPUSKU",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari buku",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[700]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nabil Dzaka',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Katalog Buku'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Katalog()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.collections_bookmark),
              title: Text('Koleksi'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Koleksi()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Tentang'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Buku Terbaru",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              _daftarBuku(context, bukuList), // Tampilkan daftar buku
            ],
          ),
        ),
      ),
    );
  }

  Widget _daftarBuku(BuildContext context, List<Buku> bukuList) {
    return GridView.builder(
      shrinkWrap: true, // Agar GridView menyesuaikan konten
      physics: NeverScrollableScrollPhysics(), // Hindari konflik scroll
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 kolom per baris
        crossAxisSpacing: 8.0, // Jarak antar kolom
        mainAxisSpacing: 8.0, // Jarak antar baris
        childAspectRatio: 0.65, // Rasio aspek untuk tampilan card
      ),
      itemCount: bukuList.length,
      itemBuilder: (context, index) {
        Buku buku = bukuList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BukuPage(
                  buku: buku,
                  allBooks: bukuList,
                ),
              ),
            );
          },
          child: _cardBuku(buku),
        );
      },
    );
  }

  Widget _cardBuku(Buku buku) {
    return Container(
      width: 150, // Tentukan lebar card agar lebih konsisten
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4, // Rasio aspek cover buku
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: buku.cover_buku.isNotEmpty
                  ? (buku.cover_buku.startsWith('data:image')
                      ? Image.memory(
                          base64Decode(buku.cover_buku.split(',').last),
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          buku.cover_buku,
                          fit: BoxFit.cover,
                        ))
                  : Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.book,
                        size: 50,
                        color: Colors.grey[700],
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Teks judul buku dengan overflow dan maxLines 1
                Text(
                  buku.judul,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                // Teks kategori dengan overflow dan maxLines 1
                Text(
                  buku.kategori,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
