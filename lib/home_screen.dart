import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int T_15_MIN_TO_SEC = 60 * 15;
  static const int T_15_MIN = 15;
  static const int T_20_MIN_TO_SEC = 60 * 20;
  static const int T_20_MIN = 20;
  static const int T_25_MIN_TO_SEC = 60 * 25;
  static const int T_25_MIN = 25;
  static const int T_30_MIN_TO_SEC = 60 * 30;
  static const int T_30_MIN = 30;
  static const int T_35_MIN_TO_SEC = 60 * 35;
  static const int T_35_MIN = 35;

  int totalSeconds = T_25_MIN_TO_SEC, totalPomodoros = 0;
  bool isRunning = false;

  late Timer timer;
  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros++;
        isRunning = false;
        totalSeconds = T_25_MIN_TO_SEC;
      });
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);

    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();

    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    String result = Duration(seconds: seconds).toString();
    result = result.split('.').first.substring(2, 7);
    return result;
  }

  void setTime(int seconds) {
    setState(() {
      totalSeconds = seconds;
    });
  }

  void setTime15min() {
    setTime(T_15_MIN_TO_SEC);
  }
  void setTime20min() {
    setTime(T_20_MIN_TO_SEC);
  }
  void setTime25min() {
    setTime(T_25_MIN_TO_SEC);
  }
  void setTime30min() {
    setTime(T_30_MIN_TO_SEC);
  }
  void setTime35min() {
    setTime(T_35_MIN_TO_SEC);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,        
        children: [
          // Time
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 89,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // Timer Option
          Flexible(
            flex: 3,
            child: SingleChildScrollView(
              //scrollDirection: Axis.horizontal,
              child: Row(              
                mainAxisAlignment: MainAxisAlignment.spaceBetween,                
                children: [
                  OutlinedButton (
                      onPressed: setTime15min,
                      style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).cardColor,
                                                      side: const BorderSide(color: Colors.transparent)),
                      child: Text("$T_15_MIN",
                                  style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color,                                
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),)),
                  OutlinedButton (
                      onPressed: setTime20min,
                      style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).cardColor,
                                                      side: const BorderSide(color: Colors.transparent)),
                      child: Text("$T_20_MIN",
                                  style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color,                                
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),)),
                  OutlinedButton (
                      onPressed: setTime25min,
                      style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).cardColor,
                                                      side: const BorderSide(color: Colors.transparent)),
                      child: Text("$T_25_MIN",
                                  style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color,                                
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),)),
                  OutlinedButton (
                      onPressed: setTime30min,
                      style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).cardColor,
                                                      side: const BorderSide(color: Colors.transparent)),
                      child: Text("$T_30_MIN",
                                  style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color,                                
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),)),
                  OutlinedButton (
                      onPressed: setTime35min,
                      style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).cardColor,
                                                      side: const BorderSide(color: Colors.transparent)),
                      child: Text("$T_35_MIN",
                                  style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color,                                
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),)),
                ],
              ),
            ),
          ),
          // Play/Stop Button
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: isRunning
                    ? const Icon(Icons.pause_circle_outlined)
                    : const Icon(Icons.play_circle_outline),
                iconSize: 120,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          // Count
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
