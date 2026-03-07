import 'package:flutter/material.dart';

class tambahKurang extends StatefulWidget {
  const tambahKurang({super.key});

  @override
  State<tambahKurang> createState() => _tambahKurangState();
}

class _tambahKurangState extends State<tambahKurang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalkulator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
