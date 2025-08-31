import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> saunaList = [
      {"name": "サウナA", "lat": 41.8418, "lng": 140.7669},

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('サウナマップ'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(41.8418, 140.7669), 
              initialZoom: 13.0,  
              minZoom: 5.0,
              maxZoom: 18.0,
            
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.happycode.app',
              ),
              MarkerLayer(
                markers: saunaList.map((sauna) {
                  return Marker(
                    point: LatLng(sauna['lat'], sauna['lng']),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(sauna['未来大の湯']),
                            content: const Text('心地良さ　10%'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('閉じる'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => launchUrl(
                  Uri.parse('https://www.openstreetmap.org/copyright')),
              child: Container(
                color: Colors.white70,
                padding: const EdgeInsets.all(4),
                child: const Text(
                  '© OpenStreetMap contributors',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
