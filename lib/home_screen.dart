import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int t5MinToSec = 10;
  static const int maxCycle = 4;

  static const int t15MinToSec = 5;
  static const int t15Min = 15;
  static const int t20MinToSec = 60 * 20;
  static const int t20Min = 20;
  static const int t25MinToSec = 60 * 25;
  static const int t25Min = 25;
  static const int t30MinToSec = 60 * 30;
  static const int t30Min = 30;
  static const int t35MinToSec = 60 * 35;
  static const int t35Min = 35;

  int totalSeconds = t25MinToSec,
      totalCycle = 0,
      totalRound = 0,
      selectedTime = t25MinToSec;

  bool isRunning = false, isRestTime = false;

  String timeState = "";

  late Timer timer;

  void onTick(Timer timer) {
    if (isRestTime) {
      setState(() {
        timeState = "Rest Time";
      });
      if (totalSeconds == 0) {
        setState(() {
          isRestTime = false;
          totalSeconds = selectedTime;
          totalCycle = 0;
        });
      } else {
        setState(() {
          totalSeconds -= 1;
        });
      }
    } else if (isRunning) {
      setState(() {
        timeState = "Remain Time";

        if (totalSeconds == 0) {
          totalCycle++;
          totalSeconds = selectedTime;

          if (totalCycle >= maxCycle) {
            totalRound++;
            isRestTime = true;
            totalSeconds = t5MinToSec;
          }
        } else {
          totalSeconds -= 1;
        }
      });
    } else {
      timer.cancel();
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
      selectedTime = seconds;
    });
  }

  void setTime15min() {
    setTime(t15MinToSec);
  }

  void setTime20min() {
    setTime(t20MinToSec);
  }

  void setTime25min() {
    setTime(t25MinToSec);
  }

  void setTime30min() {
    setTime(t30MinToSec);
  }

  void setTime35min() {
    setTime(t35MinToSec);
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      isRestTime = false;

      totalCycle = 0;
      totalRound = 0;
      totalSeconds = selectedTime;

      timeState = "";
    });
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
            flex: 4,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    timeState,
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    format(totalSeconds),
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 89,
                        fontWeight: FontWeight.w600),
                  ),
                ],
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
                  OutlinedButton(
                      onPressed: setTime15min,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(context).cardColor,
                          side: const BorderSide(color: Colors.transparent)),
                      child: Text(
                        "$t15Min",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )),
                  OutlinedButton(
                      onPressed: setTime20min,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(context).cardColor,
                          side: const BorderSide(color: Colors.transparent)),
                      child: Text(
                        "$t20Min",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )),
                  OutlinedButton(
                      onPressed: setTime25min,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(context).cardColor,
                          side: const BorderSide(color: Colors.transparent)),
                      child: Text(
                        "$t25Min",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )),
                  OutlinedButton(
                      onPressed: setTime30min,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(context).cardColor,
                          side: const BorderSide(color: Colors.transparent)),
                      child: Text(
                        "$t30Min",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )),
                  OutlinedButton(
                      onPressed: setTime35min,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(context).cardColor,
                          side: const BorderSide(color: Colors.transparent)),
                      child: Text(
                        "$t35Min",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )),
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
          Flexible(
            flex: 1,
            child: TextButton(
                onPressed: resetTimer,
                child: Text(
                  "Reset",
                  style: TextStyle(
                      color: Theme.of(context).cardColor, fontSize: 20),
                )),
          ),
          // Count
          Flexible(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cycle",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.color,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "$totalCycle/$maxCycle",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.color,
                                fontSize: 58,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Round",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.color,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "$totalRound",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.color,
                                fontSize: 58,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
