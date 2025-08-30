import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_code/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routerrr,
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.amber[400])),
      title: 'Flutter Demo',
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Map 画面に遷移するボタン
            ElevatedButton(
              onPressed: () {
                context.go('/map');
              },
              child: const Text('Go to Map Screen'),
            ),
            const SizedBox(height: 16), // ボタン間の余白
            // Config 画面に遷移するボタン
            ElevatedButton(
              onPressed: () {
                context.go('/configs');
              },
              child: const Text('Go to Config Screen'),
            ),
            const SizedBox(height: 16), // ボタン間の余白
            // Start 画面に遷移するボタン
            ElevatedButton(
              onPressed: () {
                context.go('/start');
              },
              child: const Text('Go to Start Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // GoRouter で /details に遷移
                context.go('/');
              },
              child: const Text('Go to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // GoRouter で /details に遷移
                context.go('/');
              },
              child: const Text('Go to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // GoRouter で /details に遷移
                context.go('/');
              },
              child: const Text('Go to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
