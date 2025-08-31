import 'dart:math';

import 'package:flutter/material.dart';
import 'package:happy_code/profile_screen.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,

        title: Transform.translate(
          offset: const Offset(0, 0),
          child: const Text('Profile'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 右上の Edit Profile ボタン
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右に配置
                  children: [
                    // 左上 Cancel
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // 前の画面に戻る
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ),
                    // 右上 Confirm
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // プロフィール画像と中央揃え文章
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  const SizedBox(height: 0),
                  Row(
                    mainAxisSize: MainAxisSize.min, // 中央揃え
                    children: [
                      // 左の透明アイコン（バランス用）
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.transparent,
                        ),
                        onPressed: () {},
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      const Text(
                        'sea grape',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      // 右の編集アイコン
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          // 編集ボタンを押したときの処理
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Device Information
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Device Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8), // 角丸を追加
                ),
                alignment: Alignment.center,
                child: const Text(
                  'sea grapeのapplewatch',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // User Information
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'User Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Column(
                children: [
                  editInfoRow('性別', '女性'),
                  editInfoRow('体重', '60kg'),
                  editInfoRow('身長', '150cm'),
                  editInfoRow('平均心拍数', '160bpm'),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  class EditInfoRow extends StatefulWidget {
  final String label;
  final String initialValue;
  final VoidCallback? onPressed; // 任意の処理

  const EditInfoRow({
    super.key,
    required this.label,
    required this.initialValue,
    this.onPressed,
  });

  @override
  State<EditInfoRow> createState() => _EditInfoRowState();
}

class _EditInfoRowState extends State<EditInfoRow> {
  late String value; // この行の値を保持

  @override
  void initState() {
    super.initState();
    value = widget.initialValue; // 初期値をセット
  }

  // 外部から値を変更したい場合の関数
  void updateValue(String newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        width: 300,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label, style: const TextStyle(fontSize: 16)),
            TextButton(
              onPressed: () {
                if (widget.onPressed != null) {
                  widget.onPressed!();
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}