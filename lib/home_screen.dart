import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  bool isRunning = false;

  late Timer timer;
  void onTick(Timer timer) {
    setState(() {
      totalSeconds -= 1;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Time
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text("$totalSeconds",
                          style: TextStyle(color: Theme.of(context).cardColor,
                                           fontSize: 89,
                                           fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // Play/Stop Button
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(onPressed: isRunning ? onPausePressed : onStartPressed,
                                icon: isRunning ? const Icon(Icons.pause_circle_outlined)
                                                : const Icon(Icons.play_circle_outline),
                                iconSize: 120,
                                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          // Count
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor,
                                              borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pomodoros",
                             style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,),
                        ),
                        Text("0",
                             style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color,
                                              fontSize: 58,
                                              fontWeight: FontWeight.w600,),
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
