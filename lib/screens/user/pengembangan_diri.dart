import 'package:flutter/material.dart';
import 'buku_page.dart';

class PengembanganDiri extends StatelessWidget {
  const PengembanganDiri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Katalog Buku"),
        backgroundColor: Colors.grey[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bagianKategori(context, "Buku Pengembangan Diri"),
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
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 600,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: 16,
            physics: NeverScrollableScrollPhysics(),
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
        height: 100,
        color: Colors.white,
        child: Icon(Icons.image, color: Colors.grey[700]),
      ),
    );
  }
}
