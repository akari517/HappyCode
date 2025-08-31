import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

// メイン画面 (チュートリアル完了後の遷移先)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ホーム画面')),
      body: const Center(
        child: Text(
          'メインコンテンツ',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// チュートリアル画面
class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          scrollPhysics: const BouncingScrollPhysics(),
          pages: [
            PageViewModel(
              title: 'アプリ紹介のページへ\nようこそ!',
              body: '１ページ目だよ！',
              image: Image.asset('assets/images/first.png'),
            ),
            PageViewModel(
              title: 'アプリの使い方を説明すると\nユーザーにとって親切だよ!',
              body: '2ページ目だよ!',
              image: Image.asset('assets/images/second.png'),
            ),
            PageViewModel(
              title: '紹介ページを設けることで\n簡単にアプリをリッチにできるよ!',
              body: '3ページ目だよ!',
              image: Image.asset('assets/images/third.png'),
            ),
          ],
          onDone: () {
            // ナビゲーションスタックをクリアしてメイン画面へ
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
            );
          },
          showBackButton: true,
          next: const Icon(Icons.arrow_forward_ios),
          back: const Icon(Icons.arrow_back_ios),
          done: const Text(
            'OK!',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.blue,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
