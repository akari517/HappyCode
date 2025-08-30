import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Config Screen', style: TextStyle(fontSize: 24)),
    );
  }
}
