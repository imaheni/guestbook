import 'dart:convert';
import 'dart:io'; // Untuk gambar
import 'package:bukutamu/api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path/path.dart';

class HomeController {
final VoidCallback initState;
final VoidCallback onImagePicked;
final VoidCallback onSubmit;

  // Konstruktor untuk HomeController dengan initState sebagai parameter
  //HomeController({required this.initState});
  HomeController({required this.initState, required this.onImagePicked, required this.onSubmit});

  bool isLoad = false;
 File? ImageFile;

  // Kontroler untuk menangani input form
  final TextEditingController nameController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  get imageFile => null;

  // Fungsi untuk mengambil gambar dari kamera
  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      ImageFile = File(pickedFile.path); // Simpan gambar yang dipilih
      onImagePicked(); // Panggil callback untuk memperbarui UI setelah gambar diambil
    }
  }

  // Fungsi untuk menambah entri tamu
  void addGuestEntry() async {
    if (nameController.text.isNotEmpty &&
        institutionController.text.isNotEmpty &&
        purposeController.text.isNotEmpty &&
        recipientController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        ImageFile != null) {

      // setState(() {
      isLoad = true;
      initState();
      
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "name": nameController.text,
        "institution": institutionController.text,
        "purpose": purposeController.text,
        "recipient": recipientController.text,
        "phone": phoneController.text,
        "image": ImageFile!.path // Kirim path gambar
      });

      var dio = Dio();
      var response = await dio.request(
        '${APIMG.MG}/guest',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print("Data berhasil dikirim: ${response.data}");
        // Reset form dan gambar setelah submit berhasil
        nameController.clear();
        institutionController.clear();
        purposeController.clear();
        recipientController.clear();
        phoneController.clear();
        ImageFile = null;
        onSubmit(); // Memperbarui UI setelah submit
      } else {
        print("Error: ${response.statusMessage}");
      }
    } else {
      print("Lengkapi semua field dan tambahkan gambar.");
    }
  }
}

