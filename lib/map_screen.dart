import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'router.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map'), backgroundColor: Colors.blue),
    );
  }
}
