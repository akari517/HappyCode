import 'package:flutter/material.dart';
import 'package:happy_code/saunning_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.blue),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // GoRouterを使わず通常の画面遷移（Navigator.push）で編集画面へ
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SaunningScreen()),
            );
          },
          child: const Text('Sauna Start'),
        ),
      ),
    );
  }
}
