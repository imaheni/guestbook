import 'package:bukutamu/feature/controller/home_controller.dart';
import 'package:bukutamu/feature/view/list_card_view.dart';
import 'package:flutter/material.dart';
//import 'dart:io'; // Untuk mengelola file

class GuestBookHomePage extends StatefulWidget {
  @override
  _GuestBookHomePageState createState() => _GuestBookHomePageState();
}

class _GuestBookHomePageState extends State<GuestBookHomePage> {
  // Data tamu akan disimpan dalam list Map
  late HomeController _controller;

  @override
 void initState() {
 super.initState();
    // Inisialisasi HomeController dengan callback untuk update UI
    _controller = HomeController(
      onImagePicked: () {
        setState(() {}); // Memperbarui UI setelah gambar diambil
      },
      onSubmit: () {
        setState(() {}); // Memperbarui UI setelah form dikirim
      }, initState: () {  },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buku Tamu', style: TextStyle(fontFamily: 'Pacifico')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildInputForm(),
              SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.card_giftcard),
                label: const Text("Tampilkan Data Tamu"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListCardsView()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Form input data tamu
  Widget _buildInputForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTextField(
              _controller.nameController, 'Nama Anda', Icons.person),
          SizedBox(height: 10),
          _buildTextField(
              _controller.institutionController, 'Instansi/Alamat', Icons.business),
          SizedBox(height: 10),
          _buildTextField(
              _controller.purposeController, 'Keperluan', Icons.assignment),
          SizedBox(height: 10),
          _buildTextField(
              _controller.recipientController, 'Orang yang akan ditemui', Icons.people),
          SizedBox(height: 10),
          _buildTextField(
              _controller.phoneController, 'Nomer Handphone', Icons.phone,
              keyboardType: TextInputType.phone),
          SizedBox(height: 20),
           ElevatedButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text('Ambil Foto'),
            onPressed: _controller.pickImageFromCamera,
          ),
          SizedBox(height: 10),
          _controller.ImageFile != null
              ? Image.file(_controller.ImageFile!, width: 150, height: 150)  // Menampilkan foto
              : Text('Belum ada foto diambil'),
          SizedBox(height: 20),

          ElevatedButton(
            onPressed: _controller.addGuestEntry,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              'Simpan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

 

  Widget _buildGuestCard(String name, String institution, String purpose,
      String recipient, String phone) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      shadowColor: Colors.teal.withOpacity(0.5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Institution: $institution'),
            Text('Purpose: $purpose'),
            Text('Meeting: $recipient'),
            Text('Phone: $phone'),
           // Text('image: $image'),
          ],
        ),
      ),
    );
  }
}
