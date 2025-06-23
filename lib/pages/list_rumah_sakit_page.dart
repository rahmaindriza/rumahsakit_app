import 'package:flutter/material.dart';
import '../models/rumah_sakit.dart';
import '../services/api_service.dart';
import 'form_tambah_rumah_sakit.dart';
import 'edit_rumah_sakit.dart';
import 'detail_rumah_sakit.dart';

class ListRumahSakitPage extends StatefulWidget {
  const ListRumahSakitPage({super.key});

  @override
  State<ListRumahSakitPage> createState() => _ListRumahSakitPageState();
}

class _ListRumahSakitPageState extends State<ListRumahSakitPage> {
  List<RumahSakit> _data = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchRumahSakit();
  }

  Future<void> fetchRumahSakit() async {
    try {
      final result = await ApiService.getAllRumahSakit();
      setState(() {
        _data = result;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Gagal fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7), // warna cream
      appBar: AppBar(
        backgroundColor: const Color(0xFF6D4C41), // warna coklat
        title: const Text('Daftar Rumah Sakit'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _data.isEmpty
          ? const Center(child: Text('Data tidak tersedia'))
          : RefreshIndicator(
        onRefresh: fetchRumahSakit,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: _data.length,
          itemBuilder: (context, index) {
            final rs = _data[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF6D4C41),
                  child: Icon(Icons.local_hospital,
                      color: Colors.white),
                ),
                title: Text(
                  rs.nama,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.deepOrange),
                          const SizedBox(width: 4),
                          Expanded(child: Text(rs.alamat)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.phone,
                              size: 16, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(rs.telepon),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.apartment,
                              size: 16, color: Colors.blueAccent),
                          const SizedBox(width: 4),
                          Text(rs.tipe),
                        ],
                      ),
                    ],
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      final hasil = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditRumahSakitPage(
                              rumahSakit: rs),
                        ),
                      );
                      if (hasil == true) fetchRumahSakit();
                    } else if (value == 'delete') {
                      final konfirmasi = await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Hapus Data'),
                          content: const Text(
                              'Yakin ingin menghapus data ini?'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, false),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, true),
                              child: const Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                      if (konfirmasi == true) {
                        await ApiService.deleteRumahSakit(rs.id!);
                        fetchRumahSakit();
                      }
                    } else if (value == 'detail') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailRumahSakitPage(
                              rumahSakit: rs),
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 'detail', child: Text('Lihat Detail')),
                    const PopupMenuItem(
                        value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(
                        value: 'delete', child: Text('Hapus')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const FormTambahRumahSakit()),
          ).then((_) {
            fetchRumahSakit(); // refresh setelah tambah
          });
        },
        backgroundColor: const Color(0xFF6D4C41),
        child: const Icon(Icons.add),
      ),
    );
  }
}
