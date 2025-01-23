import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/buku.dart';
import '../../services/buku_services.dart';
import 'buku_page.dart';
import 'katalog.dart';
import 'koleksi.dart';
import 'profil_screen.dart';
import 'login_page.dart';

class Beranda extends StatefulWidget {
  final String username;

  Beranda({super.key, required this.username});

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final BukuServices _bukuServices = BukuServices();
  late List<Buku> bukuList;
  late List<Buku> filteredBukuList; // Daftar buku yang telah difilter
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bukuList = _bukuServices.getAllBuku(); // Ambil semua buku
    filteredBukuList = bukuList; // Awalnya daftar buku tidak difilter
    _searchController
        .addListener(_filterBooks); // Dengarkan perubahan teks pencarian
  }

  void _filterBooks() {
    final query = _searchController.text.toLowerCase(); // Ambil teks pencarian
    setState(() {
      filteredBukuList = bukuList.where((buku) {
        return buku.judul.toLowerCase().contains(query); // Cocokkan nama buku
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Expanded(
              child: TextField(
                controller: _searchController, // Hubungkan dengan controller
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
                    widget.username,
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
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfilScreen(username: widget.username),
                        ),
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
                  MaterialPageRoute(
                    builder: (context) => Katalog(bukuList: bukuList),
                  ),
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
              _daftarBuku(context, filteredBukuList),
            ],
          ),
        ),
      ),
    );
  }

  Widget _daftarBuku(BuildContext context, List<Buku> bukuList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.6,
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
      width: 150,
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
            aspectRatio: 3 / 4,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
          ),
        ],
      ),
    );
  }
}
