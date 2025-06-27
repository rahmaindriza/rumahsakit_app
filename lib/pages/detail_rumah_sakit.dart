import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/rumah_sakit.dart';
import 'map_fullscreen_page.dart'; // halaman tambahan

class DetailRumahSakitPage extends StatelessWidget {
  final RumahSakit rumahSakit;

  const DetailRumahSakitPage({super.key, required this.rumahSakit});

  @override
  Widget build(BuildContext context) {
    final LatLng posisi = LatLng(rumahSakit.latitude, rumahSakit.longitude);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7), // warna cream lembut
      appBar: AppBar(
        backgroundColor: const Color(0xFF6D4C41), // coklat
        foregroundColor: Colors.white,
        title: Text(rumahSakit.nama), // judul sesuai nama rumah sakit
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Peta kecil di atas
          SizedBox(
            height: 240,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: posisi,
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('rs'),
                  position: posisi,
                  infoWindow: InfoWindow(title: rumahSakit.nama),
                ),
              },
            ),
          ),

          const SizedBox(height: 16),

          // Detail info
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: ListView(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          rumahSakit.nama,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4E342E),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.deepOrange),
                    title: const Text('Alamat'),
                    subtitle: Text(rumahSakit.alamat),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.green),
                    title: const Text('No Telepon'),
                    subtitle: Text(rumahSakit.telepon),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.apartment, color: Colors.blueAccent),
                    title: const Text('Tipe Rumah Sakit'),
                    subtitle: Text(rumahSakit.tipe),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapFullscreenPage(rumahSakit: rumahSakit),
                          ),
                        );
                      },
                      icon: const Icon(Icons.map),
                      label: const Text(
                        'Detail Map',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6D4C41),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
