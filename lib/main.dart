import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


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
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
  );
}
PieChartData sampleData2() => PieChartData(
      startDegreeOffset: 270,
      sections: [
        PieChartSectionData(
          borderSide: BorderSide(color: Colors.black, width: 1),
          color: Colors.blue[300], // 色を指定
          value: 8,
          titlePositionPercentageOffset: 0.7,
          titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
          radius: 80, // 半径は少し小さめに
        ),
        PieChartSectionData(
          borderSide: BorderSide(color: Colors.black, width: 1),
          color: Colors.green[400],
          value: 1,
          titlePositionPercentageOffset: 0.8,
          titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
          radius: 80,
        ),
        PieChartSectionData(
          borderSide: BorderSide(color: Colors.black, width: 1),
          color: Colors.orange[400],
          value: 9,
          titlePositionPercentageOffset: 0.5,
          titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
          radius: 80,
        ),
      ],
      sectionsSpace: 2,       // 各セクションの間隔
      centerSpaceRadius: 50,  // これでドーナツ型になる
    );



List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("ja"),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {
  
  DateTime selectedDate = DateTime.now(); // 初期値を今日の日付にする

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      initialDate: selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2101),
    );

  if (!mounted) return; //
    if (picked != null && picked != selectedDate) {
    setState(() {
    selectedDate = picked;
  });
  }
  }

  double _currentSliderValue = 20;
  double _currentDiscreteSliderValue = 60;
  bool year2023 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _selectDate,
                child: Text(
                  '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                ),
              ),
              Text(' のサウナ記録'),
            ],
          ),
  
  // Row(children: [
  //   PieChart(sampleData2()),
  // ],),
  Flexible(
    child: Row(
      children: [
        Flexible(child: PieChart(sampleData2())),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text('最低心拍数'),
            Text('最高心拍数'),
          ],
        ),
      ],
    ),
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:[
      Text('心地良さ　'),
    Slider(
              value: _currentSliderValue,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            Text('${_currentSliderValue.toStringAsFixed(0)}％'),
    ],
  ),
  const SizedBox(
    width: 300,
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'メモ'),
    ),
  ),
  // You can add more widgets here if needed
  // LineChart(sampleData()),
        ],
      ),
    ),
    );
  }
}
