import 'dart:convert'; // Add this import at the top of the file
import 'package:flutter/material.dart';
import 'buku_page.dart';
import 'package:class_perpusku/model/buku.dart';

class Katalog extends StatelessWidget {
  final List<Buku> bukuList;

  const Katalog({super.key, required this.bukuList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Katalog Buku",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bagianKategori(context, 'Buku Pelajaran',
                  _filterBukuByKategori('Buku Pelajaran')),
              _bagianKategori(context, 'Novel Remaja',
                  _filterBukuByKategori('Novel Remaja')),
              _bagianKategori(
                  context, 'Biografi', _filterBukuByKategori('Biografi')),
              _bagianKategori(context, 'Buku Pengembangan Diri',
                  _filterBukuByKategori('Pengembangan Diri')),
              _bagianKategori(context, 'Buku Referensi',
                  _filterBukuByKategori('Referensi')),
              _bagianKategori(context, 'Buku Teknologi',
                  _filterBukuByKategori('Teknologi')),
            ],
          ),
        ),
      ),
    );
  }

  List<Buku> _filterBukuByKategori(String kategori) {
    return bukuList.where((buku) => buku.kategori == kategori).toList();
  }

  Widget _bagianKategori(
      BuildContext context, String title, List<Buku> bukuKategori) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bukuKategori.length,
            itemBuilder: (context, index) {
              final buku = bukuKategori[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BukuPage(buku: buku, allBooks: bukuList),
                    ),
                  );
                },
                child: _cardBuku(buku),
              );
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _cardBuku(Buku buku) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
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
                  : Icon(Icons.image, color: Colors.grey[700]),
            ),
            SizedBox(height: 5),
            Text(
              buku.judul,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
