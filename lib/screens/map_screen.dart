// /lib/screens/map_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _miUbicacion;
  final List<Marker> _marcadores = [];

  @override
  void initState() {
    super.initState();
    _iniciarMapaOSM();
  }

  Future<void> _iniciarMapaOSM() async {
    // 1) Pedir permiso de ubicación
    LocationPermission permiso = await Geolocator.requestPermission();
    if (permiso == LocationPermission.denied ||
        permiso == LocationPermission.deniedForever) {
      return; // Si el usuario no da permiso, simplemente no obtenemos coords
    }

    // 2) Obtener la posición actual del usuario
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _miUbicacion = LatLng(pos.latitude, pos.longitude);
    });

    // 3) Simular marcadores de supermercados alrededor de mi ubicación
    //    En producción podrías cargar de tu base de datos lat/lng reales.
    final List<LatLng> posicionesSimuladas = [
      LatLng(pos.latitude + 0.005, pos.longitude + 0.005),
      LatLng(pos.latitude - 0.006, pos.longitude + 0.003),
      LatLng(pos.latitude + 0.004, pos.longitude - 0.004),
      LatLng(pos.latitude - 0.003, pos.longitude - 0.006),
      LatLng(pos.latitude + 0.002, pos.longitude + 0.007),
    ];
    final List<String> supermercadosIds = ['d1', 'exito', 'makro', 'jumbo', 'ara'];

    // 4) Crear la lista de marcadores (OSM) usando iconos genéricos
    List<Marker> nuevosMarcadores = [];

    for (int i = 0; i < supermercadosIds.length && i < posicionesSimuladas.length; i++) {
      final idSup = supermercadosIds[i];
      final posSim = posicionesSimuladas[i];

      nuevosMarcadores.add(
        Marker(
          width: 40,
          height: 40,
          point: posSim,
          builder: (ctx) => Container(
            child: Icon(
              Icons.store,
              color: Colors.blueAccent,
              size: 30.0,
            ),
          ),
        ),
      );
    }

    // 5) Agregar un marcador para mi ubicación (ícono rojo)
    if (_miUbicacion != null) {
      nuevosMarcadores.add(
        Marker(
          width: 40,
          height: 40,
          point: _miUbicacion!,
          builder: (ctx) => Container(
            child: Icon(
              Icons.person_pin_circle,
              color: Colors.redAccent,
              size: 30.0,
            ),
          ),
        ),
      );
    }

    setState(() {
      _marcadores.clear();
      _marcadores.addAll(nuevosMarcadores);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supermercados cercanos'),
        backgroundColor: Colors.teal[800],
      ),
      body: _miUbicacion == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: _miUbicacion,
                zoom: 14.0,
              ),
              children: [
                // 1) Capa del mapa (OpenStreetMap)
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.deal',
                ),

                // 2) Capa de marcadores
                MarkerLayer(
                  markers: _marcadores,
                ),
              ],
            ),
    );
  }
}
