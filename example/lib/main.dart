import 'dart:async';

import 'package:flutter/material.dart';
import 'package:platform_timezone/platform_timezone.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _timezone = 'Unknown';
  List<String> _availableTimezones = List<String>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      _timezone = await PlatformTimezone.getLocalTimezone();
    } catch (e) {
      print('Could not get the local timezone');
    }
    try {
      _availableTimezones = await PlatformTimezone.getAvailableTimezones();
    } catch (e) {
      print('Could not get available timezones');
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Local timezone app'),
        ),
        body: Column(
          children: <Widget>[
            Text('Local timezone: $_timezone\n'),
            Text('Available timezones:'),
            Expanded(
              child: ListView.builder(
                itemCount: _availableTimezones.length,
                itemBuilder: (_, index) => Text(_availableTimezones[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
