import 'package:flutter/material.dart';
import '../models/rumah_sakit.dart';
import '../services/api_service.dart';
import 'list_rumah_sakit_page.dart';

class FormTambahRumahSakit extends StatefulWidget {
  const FormTambahRumahSakit({super.key});

  @override
  State<FormTambahRumahSakit> createState() => _FormTambahRumahSakitState();
}

class _FormTambahRumahSakitState extends State<FormTambahRumahSakit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final TextEditingController tipeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      final rumahSakit = RumahSakit(
        id: 0,
        nama: namaController.text,
        alamat: alamatController.text,
        telepon: teleponController.text,
        tipe: tipeController.text,
        latitude: double.tryParse(latitudeController.text) ?? 0.0,
        longitude: double.tryParse(longitudeController.text) ?? 0.0,
      );

      final success = await ApiService.tambahRumahSakit(rumahSakit);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil ditambahkan')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ListRumahSakitPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menambahkan data')),
        );
      }
    }
  }

  Widget buildInput(String label, TextEditingController controller, IconData icon, Color iconColor,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: iconColor),
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Colors.brown[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) =>
        value == null || value.isEmpty ? '$label tidak boleh kosong' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7), // Cream background
      appBar: AppBar(
        title: const Text('Tambah Rumah Sakit'),
        backgroundColor: const Color(0xFF6D4C41), // Coklat
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildInput('Nama Rumah Sakit', namaController, Icons.local_hospital, const Color(0xFF6D4C41)),
              buildInput('Alamat', alamatController, Icons.location_on, Colors.deepOrange),
              buildInput('Telepon', teleponController, Icons.phone, Colors.green,
                  inputType: TextInputType.phone),
              buildInput('Tipe Rumah Sakit', tipeController, Icons.apartment, Colors.blueAccent),
              buildInput('Latitude', latitudeController, Icons.map, Colors.teal,
                  inputType: TextInputType.number),
              buildInput('Longitude', longitudeController, Icons.map, Colors.teal,
                  inputType: TextInputType.number),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: submitForm,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Simpan Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D4C41),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
