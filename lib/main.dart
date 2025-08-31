import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:happy_code/home_screen.dart';
import 'package:happy_code/map_screen.dart';
import 'package:happy_code/profile_screen.dart';
import 'router.dart';

void main() {
  runApp(const MyApp());
}

// ===========================================
// サウナ心拍数グラフ用データ
// ===========================================
final List<List<FlSpot>> saunaHeartRateData = [
  // 1セット目
  [
    FlSpot(0, 60),
    FlSpot(3, 80),
    FlSpot(6, 130), // サウナ
    FlSpot(9, 60), // 水風呂
    FlSpot(12, 50), // 外気浴
    FlSpot(15, 50),
    FlSpot(20, 55),
  ],
  // 2セット目
  [
    FlSpot(0, 65),
    FlSpot(3, 90),
    FlSpot(6, 135),
    FlSpot(9, 70),
    FlSpot(12, 55),
    FlSpot(15, 50),
    FlSpot(20, 60),
  ],
  // 3セット目
  [
    FlSpot(0, 70),
    FlSpot(3, 95),
    FlSpot(6, 140),
    FlSpot(9, 75),
    FlSpot(12, 60),
    FlSpot(15, 55),
    FlSpot(20, 65),
  ],
];

final List<String> setTitles = ["1セット目", "2セット目", "3セット目"];

// ===========================================
// グラフのスタイル
// ===========================================
LineChartData buildColoredChartData(List<FlSpot> spots) {
  // サウナ、水風呂、外気浴の時間区間
  final saunaSpots = spots.where((e) => e.x <= 6).toList();
  final waterSpots = spots.where((e) => e.x >= 6 && e.x <= 9).toList();
  final airSpots = spots.where((e) => e.x >= 9).toList();

  // 各区間の色と線データをまとめて返す
  return LineChartData(
    backgroundColor: Colors.grey[300],
    minX: 0,
    maxX: 20,
    minY: 0,
    maxY: 140,
    gridData: FlGridData(show: true),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: Colors.black, width: 1),
    ),
    titlesData: FlTitlesData(
      // 縦軸のみ表示（左）、右は非表示
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return Text(
              '${value.toInt()} bpm',
              style: const TextStyle(fontSize: 12),
            );
          },
        ),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      // 横軸のみ表示（下）、上は非表示
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          interval: 5,
          getTitlesWidget: (value, meta) {
            return Text(
              '${value.toInt()}分',
              style: const TextStyle(fontSize: 12),
            );
          },
        ),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    ),
    lineBarsData: [
      LineChartBarData(
        spots: saunaSpots,
        isCurved: true,
        color: const Color(0xFFFDA12C),
        barWidth: 3,
        dotData: FlDotData(show: false),
      ),
      LineChartBarData(
        spots: waterSpots,
        isCurved: true,
        color: const Color(0xFF1D86E2),
        barWidth: 3,
        dotData: FlDotData(show: false),
      ),
      LineChartBarData(
        spots: airSpots,
        isCurved: true,
        color: const Color(0xFF04C501),
        dotData: FlDotData(show: false),
      ),
    ],
  );
}

// 凡例アイテムを作る小関数
Widget _legendItem(Color color, String label) {
  return Row(
    children: [
      Container(width: 16, height: 16, color: color),
      const SizedBox(width: 4),
      Text(label),
    ],
  );
}

// ===========================================
// メインアプリ
// ===========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routerrr,
      title: 'BottomNavigation + GoRouter',
      theme: ThemeData(primarySwatch: Colors.blue),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en"), Locale("ja")],
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
  DateTime selectedDate = DateTime.now();
  int _currentPage = 0; // PageView用
  final PageController _pageController = PageController(); // PageViewの制御用

  final List<Widget> _screens = [
    const HomeScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  double _currentSliderValue = 20;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      initialDate: selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2101),
    );

    if (!mounted) return;
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDA12C),
        title: const Text('ホーム', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body:
          _currentIndex == 0
              ? _buildSaunaGraphScreen()
              : IndexedStack(index: _currentIndex, children: _screens),
    );
  }

  // ===========================================
  // サウナ記録画面
  // ===========================================
  Widget _buildSaunaGraphScreen() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: _selectDate,
              child: Text(
                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
              ),
            ),
            const SizedBox(width: 8),
            const Text(' のサウナ記録'),
          ],
        ),
        const SizedBox(height: 16),

        // 凡例
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendItem(const Color(0xFFFDA12C), 'サウナ'),
            const SizedBox(width: 16),
            _legendItem(const Color(0xFF1D86E2), '水風呂'),
            const SizedBox(width: 16),
            _legendItem(const Color(0xFF04C501), '外気浴'),
          ],
        ),

        const SizedBox(height: 16),
        Expanded(
          child: Row(
            children: [
              // 左ボタン
              SizedBox(
                width: 48, // ボタン分の固定幅
                child:
                    _currentPage > 0
                        ? IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        )
                        : null, // ボタンがないときは null
              ),

              // PageView.builder
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: saunaHeartRateData.length,
                  itemBuilder: (context, index) {
                    final currentData = saunaHeartRateData[index];
                    final minRate = currentData
                        .map((e) => e.y)
                        .reduce((a, b) => a < b ? a : b);
                    final maxRate = currentData
                        .map((e) => e.y)
                        .reduce((a, b) => a > b ? a : b);

                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          setTitles[index],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: LineChart(
                              buildColoredChartData(currentData),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 円グラフ部分
                            //const SizedBox(width: 50),
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: PieChart(
                                      PieChartData(
                                        startDegreeOffset: -90,
                                        sections: [
                                          PieChartSectionData(
                                            value: 8,
                                            color: const Color(0xFFFDA12C),
                                            title: '8分',
                                          ),
                                          PieChartSectionData(
                                            value: 1,
                                            color: const Color(0xFF1D86E2),
                                            title: '1分',
                                          ),
                                          PieChartSectionData(
                                            value: 9,
                                            color: const Color(0xFF04C501),
                                            title: '9分',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    '18分',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // 最低・最高心拍数
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '最低心拍数:',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${minRate.toInt()} bpm',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text('', style: const TextStyle(fontSize: 5)),
                                  Text(
                                    '最高心拍数:',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${maxRate.toInt()} bpm',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              // 右ボタン
              SizedBox(
                width: 48, // ボタン分の固定幅
                child:
                    _currentPage < saunaHeartRateData.length - 1
                        ? IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        )
                        : null, // ボタンがないときは null
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('心地良さ度　'),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 18,
                thumbColor: const Color(0xFFFFFFFF),
                activeTrackColor: const Color(0xFFFDA12C),
              ),
              child: Slider(
                value: _currentSliderValue,
                max: 100,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
            ),
            Text(
              '${_currentSliderValue.toStringAsFixed(0)}％',
              style: const TextStyle(color: Color(0xFFF9870B)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'メモ',
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
