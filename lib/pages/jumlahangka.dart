import 'package:flutter/material.dart';

class TotalAngka extends StatefulWidget {
  const TotalAngka({super.key});

  @override
  State<TotalAngka> createState() => _TotalAngkaState();
}

class _TotalAngkaState extends State<TotalAngka> {
  TextEditingController inputController = TextEditingController();
  int hasil = 0;

  void hitungTotal() {
    String input = inputController.text;
    int total = 0;

    for (int i = 0; i < input.length; i++) {
      String char = input[i];

      if (int.tryParse(char) != null) {
        total += int.parse(char);
      }
    }

    setState(() {
      hasil = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jumlah Angka dalam String")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Masukkan teks (angka di dalamnya akan dijumlahkan)",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Contoh: apalah9ajsih19uue8",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: hitungTotal, child: const Text("Hitung")),

            const SizedBox(height: 20),

            Text(
              "Total Angka = $hasil",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
