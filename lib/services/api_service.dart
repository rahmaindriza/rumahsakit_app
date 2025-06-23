import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/rumah_sakit.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.18.238:8000'; // ganti sesuai IP server kamu

  // GET semua rumah sakit
  static Future<List<RumahSakit>> getAllRumahSakit() async {
    final response = await http.get(Uri.parse('$baseUrl/api/rumah-sakit'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => RumahSakit.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data rumah sakit');
    }
  }

  // POST tambah rumah sakit
  static Future<bool> tambahRumahSakit(RumahSakit rs) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/rumah-sakit'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'nama': rs.nama,
        'alamat': rs.alamat,
        'telepon': rs.telepon,
        'tipe': rs.tipe,
        'latitude': rs.latitude,
        'longitude': rs.longitude,
      }),
    );

    return response.statusCode == 201;
  }

  // PUT update rumah sakit
  static Future<bool> updateRumahSakit(int id, RumahSakit rs) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/rumah-sakit/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'nama': rs.nama,
        'alamat': rs.alamat,
        'telepon': rs.telepon,
        'tipe': rs.tipe,
        'latitude': rs.latitude,
        'longitude': rs.longitude,
      }),
    );

    return response.statusCode == 200;
  }

  // DELETE rumah sakit
  static Future<bool> deleteRumahSakit(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/rumah-sakit/$id'),
    );

    return response.statusCode == 200;
  }

  // GET detail rumah sakit
  static Future<RumahSakit?> getRumahSakitById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/rumah-sakit/$id'));

    if (response.statusCode == 200) {
      return RumahSakit.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
