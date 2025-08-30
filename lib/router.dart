import 'package:go_router/go_router.dart';
import 'package:happy_code/main.dart';

final GoRouter Routerrr = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder:
          (context, state) => const MainScreen(), // BottomNavigationBar を持つ画面
    ),
  ],
  // GoRoute(
  //   path: '/',
  //   builder:
  //       (BuildContext context, GoRouterState state) =>
  //           HomeScreen(title: 'home'),
  // ),
  // GoRoute(
  //   path: '/configs',
  //   builder:
  //       (BuildContext context, GoRouterState state) =>
  //           ConfigScreen(title: 'config'),
  // ),
  // GoRoute(
  //   path: '/map',
  //   builder:
  //       (BuildContext context, GoRouterState state) =>
  //           MapScreen(title: 'map'),
  // ),
  // GoRoute(
  //   path: '/start',
  //   builder:
  //       (BuildContext context, GoRouterState state) =>
  //           StartScreen(title: 'start'),
  // ),
);
