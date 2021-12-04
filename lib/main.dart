import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

int _seconds = 00;
int _minutes = 25;
Timer? _timer;
var f = NumberFormat("00");

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${f.format(_minutes)} : ${f.format(_seconds)}",
                style: TextStyle(color: Colors.white, fontSize: 48),
              ),
            ],
          ),
          SizedBox(
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _stopTimer();
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // background
                  onPrimary: Colors.black87, // foreground
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.orange.shade300)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    "Stop",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _startTimer();
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade300, // background
                  onPrimary: Colors.black87, // foreground
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.orange.shade300)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(44.0),
                  child: Text(
                    "Start",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _stopTimer() {
    _timer!.cancel();
    _seconds = 0;
    _minutes = 25;
    print("Timer complete!");
  }

  void _startTimer() {
    if (_timer != null) {
      _stopTimer();
    }
    if (_minutes > 0) {
      _seconds = _minutes * 60;
    }
    if (_seconds > 60) {
      _minutes = (_seconds / 60).floor();
      _seconds -= (_minutes * 60);
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _seconds = 59;
            _minutes--;
          } else {
            _stopTimer();
          }
        }
      });
    });
  }
}
