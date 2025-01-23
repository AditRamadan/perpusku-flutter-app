import 'dart:convert';
import 'package:class_perpusku/model/buku.dart';
import 'package:class_perpusku/services/buku_services.dart';
import 'package:class_perpusku/screens/admin/beranda_admin.dart'; // Ganti dengan jalur sebenarnya ke halaman BerandaAdmin
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class KelolaBuku extends StatefulWidget {
  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<KelolaBuku> {
  final BukuServices _bukuServices = BukuServices();
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk form
  final _cover_bukuController = TextEditingController();
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _penerbitController = TextEditingController();
  final _tahun_terbitController = TextEditingController();
  final _lokasi_bukuController = TextEditingController();
  final _file_bukuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Buku'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BerandaAdmin()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Kembali ke Beranda',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            _buildForm(),
            _buildBukuTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.image),
              label: Text('Pilih Cover Buku'),
            ),
            if (_cover_bukuController.text.isNotEmpty)
              Text('File: ${_getFileNameFromUrl(_cover_bukuController.text)}'),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickPdf,
              icon: Icon(Icons.file_present),
              label: Text('Pilih File Buku (PDF)'),
            ),
            if (_file_bukuController.text.isNotEmpty)
              Text('File: ${_file_bukuController.text}'),
            SizedBox(height: 16),
            TextFormField(
              controller: _judulController,
              decoration: InputDecoration(labelText: 'Judul Buku'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul Buku tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _deskripsiController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            DropdownButtonFormField<String>(
              value: _kategoriController.text.isNotEmpty
                  ? _kategoriController.text
                  : null,
              items: [
                'Buku Pelajaran',
                'Novel Remaja',
                'Biografi',
                'Pengembangan Diri',
                'Buku Referensi',
                'Teknologi',
              ]
                  .map((kategori) => DropdownMenuItem(
                        value: kategori,
                        child: Text(kategori),
                      ))
                  .toList(),
              decoration: InputDecoration(labelText: 'Kategori'),
              onChanged: (value) {
                setState(() {
                  _kategoriController.text = value ?? '';
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kategori tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _penerbitController,
              decoration: InputDecoration(labelText: 'Penerbit'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Penerbit tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _tahun_terbitController,
              decoration: InputDecoration(labelText: 'Tahun Terbit'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tahun Terbit tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _lokasi_bukuController,
              decoration: InputDecoration(labelText: 'Lokasi Buku'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lokasi Buku tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addBuku,
              child: Text('Tambah Buku'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to extract the file name from URL
  String _getFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'Unknown file';
  }

  Widget _buildBukuTable() {
    final bukuList = _bukuServices.getAllBuku();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: DataTable(
          columns: [
            DataColumn(label: Text('Cover Buku')),
            DataColumn(label: Text('Judul')),
            DataColumn(label: Text('Deskripsi')),
            DataColumn(label: Text('Kategori')),
            DataColumn(label: Text('Penerbit')),
            DataColumn(label: Text('Tahun Terbit')),
            DataColumn(label: Text('Lokasi Buku')),
            DataColumn(label: Text('File Buku')),
            DataColumn(label: Text('Aksi')),
          ],
          rows: bukuList.map((buku) {
            return DataRow(cells: [
              DataCell(
                // Show the image directly instead of the URL
                buku.cover_buku.isNotEmpty &&
                        buku.cover_buku.startsWith('data:image')
                    ? Image.memory(
                        base64Decode(
                            buku.cover_buku.split(',').last), // Decode base64
                        fit: BoxFit.cover,
                        width: 50, // You can adjust the width and height
                        height: 50,
                      )
                    : Icon(Icons.image,
                        size: 50,
                        color: Colors.grey), // Default icon if no cover
              ),
              DataCell(Text(buku.judul)),
              DataCell(Text(buku.deskripsi)),
              DataCell(Text(buku.kategori)),
              DataCell(Text(buku.penerbit)),
              DataCell(Text(buku.tahun_terbit.toString())),
              DataCell(Text(buku.lokasi_buku)),
              DataCell(Text(buku.file_buku)),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showEditDialog(buku),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteBuku(buku),
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  void _pickImage() {
    final uploadInput = html.FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsDataUrl(file); // Read as Data URL (base64)
        reader.onLoadEnd.listen((event) {
          setState(() {
            _cover_bukuController.text =
                reader.result as String; // Save the base64 URL
          });
        });
      }
    });
  }

  void _pickPdf() {
    final uploadInput = html.FileUploadInputElement()..accept = '.pdf';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsDataUrl(file); // Read as Data URL (base64)
        reader.onLoadEnd.listen((event) {
          setState(() {
            _file_bukuController.text = file.name;
          });
        });
      }
    });
  }

  void _addBuku() {
    if (_formKey.currentState!.validate()) {
      if (_cover_bukuController.text.isEmpty ||
          _file_bukuController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Cover Buku dan File Buku tidak boleh kosong')),
        );
        return;
      }

      final buku = Buku(
        cover_buku: _cover_bukuController.text,
        judul: _judulController.text,
        deskripsi: _deskripsiController.text,
        kategori: _kategoriController.text,
        penerbit: _penerbitController.text,
        tahun_terbit: int.parse(_tahun_terbitController.text),
        lokasi_buku: _lokasi_bukuController.text,
        file_buku: _file_bukuController.text,
      );

      setState(() {
        _bukuServices.addBuku(buku);
      });

      _resetForm(); // Reset form setelah menambah buku
    }
  }

  void _resetForm() {
    _cover_bukuController.clear();
    _judulController.clear();
    _deskripsiController.clear();
    _kategoriController.clear();
    _penerbitController.clear();
    _tahun_terbitController.clear();
    _lokasi_bukuController.clear();
    _file_bukuController.clear();
  }

  void _deleteBuku(Buku buku) {
    setState(() {
      _bukuServices.deleteBuku(buku.id!);
    });
  }

  void _showEditDialog(Buku buku) {
    // Pastikan controller hanya diatur saat dialog edit dibuka
    _cover_bukuController.text = buku.cover_buku;
    _judulController.text = buku.judul;
    _deskripsiController.text = buku.deskripsi;
    _kategoriController.text = buku.kategori;
    _penerbitController.text = buku.penerbit;
    _tahun_terbitController.text = buku.tahun_terbit.toString();
    _lokasi_bukuController.text = buku.lokasi_buku;
    _file_bukuController.text = buku.file_buku;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Buku'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Tombol untuk memilih cover dan file buku
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.image),
                  label: Text('Pilih Cover Buku'),
                ),
                if (_cover_bukuController.text.isNotEmpty)
                  Text('Cover Buku: ${_cover_bukuController.text}'),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickPdf,
                  icon: Icon(Icons.file_present),
                  label: Text('Pilih File Buku (PDF)'),
                ),
                if (_file_bukuController.text.isNotEmpty)
                  Text('File Buku: ${_file_bukuController.text}'),
                SizedBox(height: 16),

                // Input fields
                TextFormField(
                  controller: _judulController,
                  decoration: InputDecoration(labelText: 'Judul Buku'),
                ),
                TextFormField(
                  controller: _deskripsiController,
                  decoration: InputDecoration(labelText: 'Deskripsi'),
                ),
                TextFormField(
                  controller: _kategoriController,
                  decoration: InputDecoration(labelText: 'Kategori'),
                ),
                TextFormField(
                  controller: _penerbitController,
                  decoration: InputDecoration(labelText: 'Penerbit'),
                ),
                TextFormField(
                  controller: _tahun_terbitController,
                  decoration: InputDecoration(labelText: 'Tahun Terbit'),
                ),
                TextFormField(
                  controller: _lokasi_bukuController,
                  decoration: InputDecoration(labelText: 'Lokasi Buku'),
                ),
                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    final updatedBuku = Buku(
                      id: buku.id,
                      cover_buku: _cover_bukuController.text,
                      judul: _judulController.text,
                      deskripsi: _deskripsiController.text,
                      kategori: _kategoriController.text,
                      penerbit: _penerbitController.text,
                      tahun_terbit: int.parse(_tahun_terbitController.text),
                      lokasi_buku: _lokasi_bukuController.text,
                      file_buku: _file_bukuController.text,
                    );

                    // Update buku dengan data baru
                    _bukuServices.updateBuku(updatedBuku);

                    // Refresh tampilan dan tutup dialog
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('Update Buku'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _cover_bukuController.dispose();
    _judulController.dispose();
    _deskripsiController.dispose();
    _kategoriController.dispose();
    _penerbitController.dispose();
    _tahun_terbitController.dispose();
    _lokasi_bukuController.dispose();
    _file_bukuController.dispose();
    super.dispose();
  }
}
