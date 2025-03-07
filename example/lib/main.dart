import 'package:callkit_poc/call_params.dart';
import 'package:callkit_poc/call_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:callkit_poc/callkit_poc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final callService = CallService();

  void startIncomingCall() {
    final _params = CallParams(true, "", "Maxim", "", "Maxim Makarenkov", false, "", CallStatus.ringing);
    callService.startIncomingCall(_params);
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("CallKit POC"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                  ),
                  onPressed: startIncomingCall,
                  child: Text("Start Incoming call"),
              )
            ),
          ],
        ),
      ),
    );
  }
}
