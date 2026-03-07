import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;

  String _formattedTime = "00:00:00";

  void _start() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    });
  }

  void _stop() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _reset() {
    _stopwatch.reset();
    _timer.cancel();
    setState(() {
      _formattedTime = "00:00:00";
    });
    _stopwatch.stop();
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / 60000).truncate();

    return "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}:"
        "${hundreds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    if (_stopwatch.isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stopwatch", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formattedTime,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _start, child: const Text("Start")),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: _stop, child: const Text("Stop")),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: _reset, child: const Text("Reset")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
