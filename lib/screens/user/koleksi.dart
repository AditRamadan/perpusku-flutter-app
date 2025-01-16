import 'package:flutter/material.dart';
import 'buku_page.dart';

class Koleksi extends StatelessWidget {
  const Koleksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Row(
          children: [
            Text(
              "PERPUSKU",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "cari buku",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _judulBagian("Buku yang di Simpan"),
          _listKartuBuku(context),
          SizedBox(height: 16),
          _judulBagian("Buku yang di Pinjam"),
          _listKartuBuku(context),
        ],
      ),
    );
  }

  Widget _judulBagian(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          ),
          Text(
            "lainnya >",
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _listKartuBuku(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => _kartuBuku(context)),
    );
  }

  Widget _kartuBuku(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 70,
              color: Colors.white,
              child: Icon(Icons.image, size: 40, color: Colors.grey[400]),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "JUDUL BUKU",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Penerbit , Tahun",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Kategori",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            Icon(Icons.bookmark_border, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
