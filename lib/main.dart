import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_code/home_screen.dart';
import 'package:happy_code/map_screen.dart';
import 'package:happy_code/profile_screen.dart';
import 'router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routerrr,
      title: 'BottomNavigation + GoRouter',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key, required this.title});
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Map 画面に遷移するボタン
//             ElevatedButton(
//               onPressed: () {
//                 context.go('/map');
//               },
//               child: const Text('Go to Map Screen'),
//             ),
//             const SizedBox(height: 16), // ボタン間の余白
//             // Config 画面に遷移するボタン
//             ElevatedButton(
//               onPressed: () {
//                 context.go('/configs');
//               },
//               child: const Text('Go to Config Screen'),
//             ),
//             const SizedBox(height: 16), // ボタン間の余白
//             // Start 画面に遷移するボタン
//             ElevatedButton(
//               onPressed: () {
//                 context.go('/start');
//               },
//               child: const Text('Go to Start Screen'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ConfigScreen extends StatelessWidget {
//   const ConfigScreen({super.key, required this.title});
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 // GoRouter で /details に遷移
//                 context.go('/');
//               },
//               child: const Text('Go to Home Screen'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key, required this.title});
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 // GoRouter で /details に遷移
//                 context.go('/');
//               },
//               child: const Text('Go to Home Screen'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StartScreen extends StatelessWidget {
//   const StartScreen({super.key, required this.title});
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 // GoRouter で /details に遷移
//                 context.go('/');
//               },
//               child: const Text('Go to Home Screen'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
