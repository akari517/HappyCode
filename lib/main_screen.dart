import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
    DateTime selectedDate = DateTime.now(); // 初期値を今日の日付にする
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
  sectionsSpace: 2, // 各セクションの間隔
  centerSpaceRadius: 50, // これでドーナツ型になる
);

  double _currentSliderValue = 20;
  double _currentDiscreteSliderValue = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('aaaaa'),
      ),
      body:Center(
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
            Flexible(
              child: Row(
                children: [
                  Flexible(child: PieChart(sampleData2())),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('最低心拍数'), Text('最高心拍数')],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'メモ',
                ),
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
