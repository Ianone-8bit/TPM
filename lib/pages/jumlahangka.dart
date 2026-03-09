import 'package:flutter/material.dart';

class TotalAngka extends StatefulWidget {
  const TotalAngka({super.key});

  @override
  State<TotalAngka> createState() => _TotalAngkaState();
}

class _TotalAngkaState extends State<TotalAngka> {
  TextEditingController inputController = TextEditingController();

  int hasil = 0;
  List<int> daftarAngka = [];

  void hitungTotal() {
    String input = inputController.text;

    int total = 0;
    List<int> angkaDitemukan = [];

    for (int i = 0; i < input.length; i++) {
      String char = input[i];

      if (int.tryParse(char) != null) {
        int angka = int.parse(char);
        total += angka;
        angkaDitemukan.add(angka);
      }
    }

    setState(() {
      hasil = total;
      daftarAngka = angkaDitemukan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Jumlah Angka dalam String",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),

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
                hintText: "Contoh: ya9ini10gipa0tolong1saya9",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: hitungTotal, child: const Text("Hitung")),

            const SizedBox(height: 20),

            Text(
              "Total Angka = $hasil",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Jumlah Digit Angka = ${daftarAngka.length}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Angka yang ditemukan: ${daftarAngka.join(", ")}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
