import 'package:class_perpusku/screens/user/biografi.dart';
import 'package:class_perpusku/screens/user/novel.dart';
import 'package:class_perpusku/screens/user/pendidikan.dart';
import 'package:class_perpusku/screens/user/pengembangan_diri.dart';
import 'package:class_perpusku/screens/user/referensi.dart';
import 'package:class_perpusku/screens/user/teknologi.dart';
import 'package:flutter/material.dart';
import 'buku_page.dart';

class Katalog extends StatelessWidget {
  const Katalog({super.key});

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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pendidikan()),
                  );
                },
                child: _bagianKategori(context, 'Buku Pendidikan'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Novel()),
                  );
                },
                child: _bagianKategori(context, 'Novel'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Biografi()),
                  );
                },
                child: _bagianKategori(context, 'Buku Biografi'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PengembanganDiri()),
                  );
                },
                child: _bagianKategori(context, 'Buku Pengembangan Diri'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Referensi()),
                  );
                },
                child: _bagianKategori(context, 'Buku Referensi'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Teknologi()),
                  );
                },
                child: _bagianKategori(context, 'Buku Teknologi'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bagianKategori(BuildContext context, String title) {
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
            itemCount: 6,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: _cardBuku(),
              );
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _cardBuku() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        color: Colors.white,
        child: Icon(Icons.image, color: Colors.grey[700]),
      ),
    );
  }
}
