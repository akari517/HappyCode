import 'package:flutter/material.dart'; // イントロダクション画面をインポート

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image.png', // このパスを実際のロゴ画像に合わせる
              width: 74,
              height: 74,
            ),
            const Text(
              'ととのい',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const Text(
              'カルテ',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // ボタンを押すとチュートリアル画面へ遷移
                Navigator.of(context).pushNamed('/introduction');
              },
              child: const Text('はじめる'),
            ),
          ],
        ),
      ),
    );
  }
}
