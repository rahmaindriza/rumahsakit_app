import 'package:flutter/material.dart';
import '../models/rumah_sakit.dart';
import '../services/api_service.dart';

class EditRumahSakitPage extends StatefulWidget {
  final RumahSakit rumahSakit;
  const EditRumahSakitPage({super.key, required this.rumahSakit});

  @override
  State<EditRumahSakitPage> createState() => _EditRumahSakitPageState();
}

class _EditRumahSakitPageState extends State<EditRumahSakitPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _alamatController;
  late TextEditingController _teleponController;
  late TextEditingController _tipeController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.rumahSakit.nama);
    _alamatController = TextEditingController(text: widget.rumahSakit.alamat);
    _teleponController = TextEditingController(text: widget.rumahSakit.telepon);
    _tipeController = TextEditingController(text: widget.rumahSakit.tipe);
    _latitudeController = TextEditingController(text: widget.rumahSakit.latitude.toString());
    _longitudeController = TextEditingController(text: widget.rumahSakit.longitude.toString());
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final updatedRS = RumahSakit(
        id: widget.rumahSakit.id,
        nama: _namaController.text,
        alamat: _alamatController.text,
        telepon: _teleponController.text,
        tipe: _tipeController.text,
        latitude: double.tryParse(_latitudeController.text) ?? 0.0,
        longitude: double.tryParse(_longitudeController.text) ?? 0.0,
      );

      final success = await ApiService.updateRumahSakit(updatedRS.id!, updatedRS);

      if (success && mounted) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan perubahan')),
        );
      }
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon,
      Color iconColor,
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
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _teleponController.dispose();
    _tipeController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      appBar: AppBar(
        title: const Text('Edit Rumah Sakit'),
        backgroundColor: const Color(0xFF6D4C41),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('Nama Rumah Sakit', _namaController, Icons.local_hospital, const Color(0xFF6D4C41)),
              _buildTextField('Alamat', _alamatController, Icons.location_on, Colors.deepOrange),
              _buildTextField('No Telepon', _teleponController, Icons.phone, Colors.green,
                  inputType: TextInputType.phone),
              _buildTextField('Tipe Rumah Sakit', _tipeController, Icons.apartment, Colors.blueAccent),
              _buildTextField('Latitude', _latitudeController, Icons.map, Colors.teal,
                  inputType: TextInputType.number),
              _buildTextField('Longitude', _longitudeController, Icons.map, Colors.teal,
                  inputType: TextInputType.number),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Siman Perubahan',
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
