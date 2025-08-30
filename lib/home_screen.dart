import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.blue),
    );
  }
}
