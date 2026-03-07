import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TambahKurang extends StatefulWidget {
  const TambahKurang({super.key});

  @override
  State<TambahKurang> createState() => _TambahKurangState();
}

class _TambahKurangState extends State<TambahKurang> {
  final TextEditingController angka1Controller = TextEditingController();
  final TextEditingController angka2Controller = TextEditingController();

  double hasil = 0;

  void tambah() {
    if (angka1Controller.text.isEmpty || angka2Controller.text.isEmpty) {
      return;
    }

    double a = double.parse(angka1Controller.text);
    double b = double.parse(angka2Controller.text);

    setState(() {
      hasil = a + b;
    });
  }

  void kurang() {
    if (angka1Controller.text.isEmpty || angka2Controller.text.isEmpty) {
      return;
    }

    double a = double.parse(angka1Controller.text);
    double b = double.parse(angka2Controller.text);

    setState(() {
      hasil = a - b;
    });
  }

  @override
  void dispose() {
    angka1Controller.dispose();
    angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalkulator Tambah & Kurang",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: angka1Controller,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
              ],
              decoration: const InputDecoration(
                labelText: "Angka Pertama",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: angka2Controller,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
              ],
              decoration: const InputDecoration(
                labelText: "Angka Kedua",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: tambah,
                  child: const Text("Tambah (+)"),
                ),

                ElevatedButton(
                  onPressed: kurang,
                  child: const Text("Kurang (-)"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              "Hasil: $hasil",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
