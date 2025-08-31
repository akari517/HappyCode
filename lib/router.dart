import 'package:go_router/go_router.dart';
import 'package:happy_code/main.dart';

final GoRouter Routerrr = GoRouter(
  //bottom tab barと全画面遷移の同時管理はGorouterは苦手(とてつもない長文になってしまう)ので、全画面遷移はNavigatorで記述することとする
  routes: [
    GoRoute(
      path: '/',
      builder:
          (context, state) => MyHomePage(), // BottomNavigationBar を持つ画面
    ),
  ],
);
