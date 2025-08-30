import 'package:flutter/material.dart';
import 'package:flutter_watch_os_connectivity/flutter_watch_os_connectivity.dart';

class TestWatchConnection extends StatelessWidget {
  TestWatchConnection({super.key});
  final _flutterWatchOsConnectivity = FlutterWatchOsConnectivity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Watch Connection')),
      body: Column(
        children: [
          Center(child: Text('Testing Watch Connection')),
          TextButton(
            child: Text("データを送信"),
            onPressed: () async {
              bool isReachable = await _flutterWatchOsConnectivity.getReachability();
              print("isReachable: $isReachable");

              if (isReachable) {
                await _flutterWatchOsConnectivity.sendMessage({'0': 'hogehoge', '1': 'hogehoge', '2': 'hogehoge'});
              }
            },
          ),
        ],
      ),
    );
  }
}
