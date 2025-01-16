import 'package:class_perpusku/model/user.dart';
import 'package:class_perpusku/services/user_services.dart';
import 'package:class_perpusku/screens/admin/beranda_admin.dart';
import 'package:flutter/material.dart';

class KelolaUser extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<KelolaUser> {
  final UserServices _userServices = UserServices();
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk form
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola User'),
      ),
      body: Column(
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
          _buildUserTable(),
        ],
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
            TextFormField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Tambah User'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTable() {
    final userList = _userServices.getAllUsers();

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: DataTable(
              columns: [
                DataColumn(label: Text('Nama')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Username')),
                DataColumn(label: Text('Aksi')),
              ],
              rows: userList.map((user) {
                return DataRow(cells: [
                  DataCell(Text(user.nama)),
                  DataCell(Text(user.email)),
                  DataCell(Text(user.username)),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showEditDialog(user),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteUser(user),
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _addUser() {
    if (_formKey.currentState!.validate()) {
      final user = User(
        nama: _namaController.text,
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );

      setState(() {
        _userServices.addUser(user);
      });

      _resetForm();
    }
  }

  void _deleteUser(User user) {
    setState(() {
      _userServices.deleteUser(user.id!);
    });
  }

  void _showEditDialog(User user) {
    _namaController.text = user.nama;
    _emailController.text = user.email;
    _usernameController.text = user.username;
    _passwordController.text = user.password;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit User'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => _updateUser(user),
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _updateUser(User user) {
    if (_formKey.currentState!.validate()) {
      final updatedUser = User(
        id: user.id,
        nama: _namaController.text,
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );

      setState(() {
        _userServices.updateUser(updatedUser);
      });

      Navigator.pop(context);
      _resetForm();
    }
  }

  void _resetForm() {
    _namaController.clear();
    _emailController.clear();
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
