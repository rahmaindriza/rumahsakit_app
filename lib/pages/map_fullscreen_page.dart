import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/rumah_sakit.dart';

class MapFullscreenPage extends StatefulWidget {
  final RumahSakit rumahSakit;

  const MapFullscreenPage({super.key, required this.rumahSakit});

  @override
  State<MapFullscreenPage> createState() => _MapFullscreenPageState();
}

class _MapFullscreenPageState extends State<MapFullscreenPage> {
  late GoogleMapController _mapController;
  String _currentMapStyle = '';

  @override
  void initState() {
    super.initState();
    _loadMapStyle('default');
  }

  Future<void> _loadMapStyle(String style) async {
    String mapStyle = '';

    switch (style) {
      case 'retro':
        mapStyle = await rootBundle.loadString('assets/style_map/style_retro.json');
        break;
      case 'dark':
        mapStyle = await rootBundle.loadString('assets/style_map/style_dark.json');
        break;
      case 'night':
        mapStyle = await rootBundle.loadString('assets/style_map/style_night.json'); // opsional
        break;
      default:
        mapStyle = ''; // style default (null)
    }

    setState(() {
      _currentMapStyle = mapStyle;
    });

    _mapController.setMapStyle(_currentMapStyle);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.setMapStyle(_currentMapStyle);
  }

  @override
  Widget build(BuildContext context) {
    final LatLng posisi = LatLng(widget.rumahSakit.latitude, widget.rumahSakit.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text("Peta ${widget.rumahSakit.nama}"),
        backgroundColor: const Color(0xFF6D4C41),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: posisi,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('rs'),
                position: posisi,
                infoWindow: InfoWindow(title: widget.rumahSakit.nama),
              ),
            },
            zoomControlsEnabled: false,
          ),

          // Tombol Style Map (posisi kiri bawah)
          Positioned(
            bottom: 20,
            left: 12,
            child: Column(
              children: [
                _buildStyleButton(Icons.map, 'default', Colors.teal),
                const SizedBox(height: 8),
                _buildStyleButton(Icons.star, 'retro', Colors.orange),
                const SizedBox(height: 8),
                _buildStyleButton(Icons.dark_mode, 'dark', Colors.black),
                const SizedBox(height: 8),
                _buildStyleButton(Icons.thumb_up, 'night', Colors.brown),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyleButton(IconData icon, String style, Color color) {
    return FloatingActionButton(
      heroTag: style,
      mini: true,
      backgroundColor: color,
      onPressed: () => _loadMapStyle(style),
      child: Icon(icon, color: Colors.white),
    );
  }
}
