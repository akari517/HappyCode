import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'router.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center)),
    );
  }
}
