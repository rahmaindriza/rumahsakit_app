import 'package:flutter/material.dart';
import 'list_rumah_sakit_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7), // warna cream
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 30),

            Column(
              children: [
                const Icon(
                  Icons.local_hospital_rounded,
                  color: Color(0xFF6D4C41), // coklat
                  size: 48,
                ),
                const SizedBox(height: 12),

                // Gambar rumah sakit
                Image.asset(
                  'assets/images/rumah_sakit.jpeg',
                  height: 160,
                ),
                const SizedBox(height: 24),

                // Judul
                const Text(
                  'Rumah Sakit',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E342E), // Coklat gelap
                  ),
                ),
                const SizedBox(height: 10),

                // Deskripsi
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Lihat informasi lengkap lokasi dan tipe rumah sakit langsung dari HP Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ListRumahSakitPage()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    'Get Started',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D4C41), // coklat soft
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
