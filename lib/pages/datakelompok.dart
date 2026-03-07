import 'package:flutter/material.dart';

class DataKelompok extends StatelessWidget {
  const DataKelompok({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Kelompok"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Anggota Kelompok",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text("1. Ghiva Satria Widagda - 123230209"),
            Text("2. Bertha Anang Orelya - 123230225"),
            Text("3. Favian Kirana Firjatullah - 123230227"),
            Text("4. Nurma Buana Driessen - 123230229"),
          ],
        ),
      ),
    );
  }
}