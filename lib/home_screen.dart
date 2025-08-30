import 'package:flutter/material.dart';
import 'package:happy_code/test_watch_connection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.blue), body: TestWatchConnection());
  }
}
