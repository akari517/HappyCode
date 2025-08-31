import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:happy_code/home_screen.dart';
import 'package:happy_code/map_screen.dart';
import 'package:happy_code/profile_screen.dart';
//import 'package:happy_code/test_watch_connection.dart';
import 'router.dart';

void main() {
  runApp(const MyApp());
}

LineChartData sampleData() {
  return LineChartData(
    lineTouchData: LineTouchData(enabled: false),
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 0),
          FlSpot(1, 5),
          FlSpot(2, 10),
          FlSpot(3, 5),
          FlSpot(4, 20),
          FlSpot(5, 15),
          FlSpot(6, 25),
          FlSpot(7, 10),
          FlSpot(8, 15),
          FlSpot(9, 25),
          FlSpot(10, 28),
          FlSpot(11, 15),
        ],
        isCurved: true,
        color: Colors.black,
        barWidth: 5,
      ),
    ],
    minY: 0,
    maxY: 30,
    titlesData: LineTitles.getTitleData(),
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      getDrawingVerticalLine: (value) {
        return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
      },
      getDrawingHorizontalLine: (value) {
        return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
      },
    ),
  );
}



List<Color> gradientColors = [const Color(0xff23b6e6), const Color(0xff02d39a)];

class LineTitles {
  static getTitleData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTitlesWidget: (value, meta) {
            String text;
            switch (value.toInt()) {
              case 0:
                text = 'Jan';
                break;
              case 1:
                text = 'Feb';
                break;
              case 2:
                text = 'Mar';
                break;
              case 3:
                text = 'Apr';
                break;
              case 4:
                text = 'May';
                break;
              case 5:
                text = 'Jun';
                break;
              case 6:
                text = 'Jul';
                break;
              case 7:
                text = 'Aug';
                break;
              case 8:
                text = 'Sep';
                break;
              case 9:
                text = 'Oct';
                break;
              case 10:
                text = 'Nov';
                break;
              case 11:
                text = 'Dec';
                break;
              default:
                text = '';
            }
            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(text),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          getTitlesWidget: (value, meta) {
            String text;
            switch (value.toInt()) {
              case 0:
                text = '0';
                break;
              case 10:
                text = '10';
                break;
              case 20:
                text = '20';
                break;
              case 30:
                text = '30';
                break;
              default:
                text = '';
            }
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(text),
            );
          },
        ),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routerrr,
      title: 'BottomNavigation + GoRouter',
      theme: ThemeData(primarySwatch: Colors.blue),
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [const Locale("en"), const Locale("ja")],
    );
  }
}





class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  final List<Widget> _screens = [
    const HomeScreen(),
     MapScreen(),
    const ProfileScreen(),
  ];

  


  bool year2023 = true;
   int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('aaaaa'),
      
      ),
     body: _screens[_currentIndex],
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
// Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 OutlinedButton(
//                   onPressed: _selectDate,
//                   child: Text(
//                     '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
//                   ),
//                 ),
//                 Text(' のサウナ記録'),
//               ],
//             ),
//             Flexible(
//               child: Row(
//                 children: [
//                   Flexible(child: PieChart(sampleData2())),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [Text('最低心拍数'), Text('最高心拍数')],
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('心地良さ　'),
//                 Slider(
//                   value: _currentSliderValue,
//                   max: 100,
//                   onChanged: (double value) {
//                     setState(() {
//                       _currentSliderValue = value;
//                     });
//                   },
//                 ),
//                 Text('${_currentSliderValue.toStringAsFixed(0)}％'),
//               ],
//             ),
//             const SizedBox(
//               width: 300,
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'メモ',
//                 ),
//               ),
//             ),
//             // You can add more widgets here if needed
//             // LineChart(sampleData()),
//           ],
//         ),
//       ),
//     );
//   }
// }

