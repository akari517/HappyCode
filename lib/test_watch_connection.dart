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
              try {
                print('getReachability()呼び出し前');
                await _flutterWatchOsConnectivity.configureAndActivateSession();
                ActivationState _currentState = await _flutterWatchOsConnectivity.getActivateState();
                print("getActivateState(): ${_currentState}");
                while (_currentState != ActivationState.activated) {
                  await Future.delayed(Duration(seconds: 1));
                  _currentState = await _flutterWatchOsConnectivity.getActivateState();
                  print("getActivateState(): ${_currentState}");
                }
                if (_currentState == ActivationState.activated) {
                  // Continue to use the plugin
                  await _flutterWatchOsConnectivity.sendMessage({
                    "message": "This is a message sent from IOS app at ${DateTime.now().millisecondsSinceEpoch}",
                  });
                } else {
                  // Do something in this case
                }
                print('getReachability()呼び出し後');
              } catch (e, stack) {
                print('送信時にエラー: $e');
                print(stack);
              }
            },
          ),
        ],
      ),
    );
  }
}
