import 'package:flutter/material.dart';

class Pyramid extends StatefulWidget {
  const Pyramid({super.key});

  @override
  State<Pyramid> createState() => _PyramidState();
}

class _PyramidState extends State<Pyramid> {
  final panjangController = TextEditingController();
  final lebarController = TextEditingController();
  final tinggiController = TextEditingController();
  final tinggiSisiPanjangController = TextEditingController();
  final tinggiSisiLebarController = TextEditingController();

  double volume = 0;
  double luas = 0;

  void hitung() {
    double p = double.parse(panjangController.text);
    double l = double.parse(lebarController.text);
    double t = double.parse(tinggiController.text);
    double tsp = double.parse(tinggiSisiPanjangController.text);
    double tsl = double.parse(tinggiSisiLebarController.text);

    double luasAlas = p * l;

    double sisiPanjang = 2 * (0.5 * p * tsp);
    double sisiLebar = 2 * (0.5 * l * tsl);

    setState(() {
      volume = (1 / 3) * luasAlas * t;
      luas = luasAlas + sisiPanjang + sisiLebar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalkulator Piramida",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const Text(
              "Volume & Luas Permukaan Piramida",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: panjangController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Panjang Alas",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: lebarController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Lebar Alas",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: tinggiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Tinggi Piramida",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: tinggiSisiPanjangController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Tinggi Sisi (depan/belakang)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: tinggiSisiLebarController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Tinggi Sisi (kiri/kanan)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: hitung, child: const Text("Hitung")),

            const SizedBox(height: 20),

            Text("Volume: $volume", style: const TextStyle(fontSize: 18)),

            Text("Luas Permukaan: $luas", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
