import 'package:flutter/material.dart';
import 'package:happy_code/profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 通常の画面遷移（Navigator.push）で編集画面へ
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => const ProfileEditScreen(title: 'ProfileEdit'),
              ),
            );
          },
          child: const Text('Edit Profile'),
        ),
      ),
    );
  }
}
