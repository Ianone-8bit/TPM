import 'package:flutter/material.dart';

class Prima extends StatefulWidget {
  const Prima({super.key});

  @override
  State <Prima> createState() => _Prima();
}

class _Prima extends State<Prima>{
TextEditingController angkaController = TextEditingController();
  String hasil = "";

  bool isPrima(int n) {
    if (n <= 1) return false;

    for (int i = 2; i < n; i++) {
      if (n % i == 0) {
        return false;
      }
    }

    return true;
  }

  void cekBilangan() {
    int angka = int.parse(angkaController.text);

    String jenis = "";
    String prima = "";

    if (angka % 2 == 0) {
      jenis = "Genap";
    } else {
      jenis = "Ganjil";
    }

    if (isPrima(angka)) {
      prima = "Bilangan Prima";
    } else {
      prima = "Bukan Bilangan Prima";
    }

    setState(() {
      hasil = "Bilangan $angka adalah $jenis dan $prima";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cek Bilangan"),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: angkaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan angka",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: cekBilangan,
              child: const Text("Cek Bilangan"),
            ),

            const SizedBox(height: 20),

            Text(
              hasil,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )

          ],
        ),
      ),
    );
  }
}
