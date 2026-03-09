import 'package:flutter/material.dart';

class TotalAngka extends StatefulWidget {
  const TotalAngka({super.key});

  @override
  State<TotalAngka> createState() => _TotalAngkaState();
}

class _TotalAngkaState extends State<TotalAngka> {

  TextEditingController angkaController = TextEditingController();
  int hasil = 0;

  void hitungTotal(){

    List<String> angkaList = angkaController.text.split(" ");
    int total = 0;

    for (var angka in angkaList){
      total += int.tryParse(angka) ?? 0;
    }

    setState(() {
      hasil = total;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jumlah Total Angka"),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Masukkan angka dipisah spasi",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: angkaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: " apa yaa???",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: hitungTotal,
              child: const Text("Hitung"),
            ),

            const SizedBox(height: 20),

            Text(
              "Total = $hasil",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}