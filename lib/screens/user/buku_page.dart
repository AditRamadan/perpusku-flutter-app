import 'package:class_perpusku/model/buku.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BukuPage extends StatelessWidget {
  final Buku buku;
  final List<Buku> allBooks;

  const BukuPage({
    super.key,
    required this.buku,
    required this.allBooks,
  });

  @override
  Widget build(BuildContext context) {
    // Filter buku yang serupa berdasarkan kategori, kecuali buku saat ini
    List<Buku> similarBooks = allBooks
        .where((b) => b.kategori == buku.kategori && b.id != buku.id)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text(
          "PERPUSKU",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 150, // Atur ukuran lebar gambar
                height: 200, // Atur ukuran tinggi gambar
                decoration: BoxDecoration(
                  color: Colors.grey[400],
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: buku.cover_buku.isNotEmpty
                      ? (buku.cover_buku.startsWith('data:image')
                          ? FittedBox(
                              fit: BoxFit.contain,
                              child: Image.memory(
                                base64Decode(buku.cover_buku.split(',').last),
                              ),
                            )
                          : FittedBox(
                              fit: BoxFit.contain,
                              child: Image.network(
                                buku.cover_buku,
                              ),
                            ))
                      : Icon(Icons.book, size: 50, color: Colors.grey[700]),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              buku.judul.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Deskripsi Buku",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
            Text(buku.deskripsi),
            SizedBox(height: 10),
            Text("Kategori: ${buku.kategori}"),
            Text("Penerbit: ${buku.penerbit}"),
            Text("Tahun Terbit: ${buku.tahun_terbit}"),
            Text("Lokasi Buku: ${buku.lokasi_buku}"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (buku.file_buku.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PdfViewerPage(pdfUrl: buku.file_buku),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("File buku tidak tersedia."),
                        ),
                      );
                    }
                  },
                  child: Text("PINJAM"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400]),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Logic to add to favorites
                  },
                  child: Text("Tambahkan Favorit"),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (similarBooks.isNotEmpty) ...[
              Text(
                "Rekomendasi Buku yang Serupa",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
              SizedBox(height: 10),
              _daftarBukuSerupa(context, similarBooks),
            ]
          ],
        ),
      ),
    );
  }

  Widget _daftarBukuSerupa(BuildContext context, List<Buku> similarBooks) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: similarBooks.length,
      itemBuilder: (context, index) {
        Buku similarBook = similarBooks[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BukuPage(
                  buku: similarBook,
                  allBooks: allBooks,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                height: 100,
                color: Colors.grey[400],
                child: similarBook.file_buku.isNotEmpty
                    ? Image.network(similarBook.file_buku, fit: BoxFit.cover)
                    : Icon(Icons.image, color: Colors.grey[700]),
              ),
              SizedBox(height: 5),
              Text(
                similarBook.judul,
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Baca Buku"),
        ),
        body: SfPdfViewer.asset(pdfUrl));
  }
}
