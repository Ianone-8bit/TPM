import 'dart:math';
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

  double volume = 0;
  double luas = 0;
  bool sudahHitung = false;

  void hitung() {
    if (panjangController.text.isEmpty ||
        lebarController.text.isEmpty ||
        tinggiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi semua kolom terlebih dahulu.")),
      );
      return;
    }

    double p = double.tryParse(panjangController.text) ?? 0;
    double l = double.tryParse(lebarController.text) ?? 0;
    double t = double.tryParse(tinggiController.text) ?? 0;

    if (p <= 0 || l <= 0 || t <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nilai harus lebih dari 0.")),
      );
      return;
    }

    // Tinggi sisi miring (apothem) dihitung otomatis
    // tsp = tinggi sisi segitiga depan/belakang (tegak lurus ke sisi panjang)
    // tsl = tinggi sisi segitiga kiri/kanan (tegak lurus ke sisi lebar)
    double tsp = sqrt(t * t + (l / 2) * (l / 2));
    double tsl = sqrt(t * t + (p / 2) * (p / 2));

    double luasAlas = p * l;
    double luasSisiPanjang = 2 * (0.5 * p * tsp); // 2 segitiga depan & belakang
    double luasSisiLebar = 2 * (0.5 * l * tsl); // 2 segitiga kiri & kanan

    setState(() {
      volume = (1 / 3) * luasAlas * t;
      luas = luasAlas + luasSisiPanjang + luasSisiLebar;
      sudahHitung = true;
    });
  }

  void reset() {
    panjangController.clear();
    lebarController.clear();
    tinggiController.clear();
    setState(() {
      volume = 0;
      luas = 0;
      sudahHitung = false;
    });
  }

  @override
  void dispose() {
    panjangController.dispose();
    lebarController.dispose();
    tinggiController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixText: "cm",
      ),
    );
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Volume & Luas Permukaan\nPiramida Persegi Panjang",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "Tinggi sisi miring dihitung otomatis dari dimensi yang dimasukkan.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              _buildTextField(
                controller: panjangController,
                label: "Panjang Alas (p)",
                hint: "contoh: 10",
              ),

              const SizedBox(height: 12),

              _buildTextField(
                controller: lebarController,
                label: "Lebar Alas (l)",
                hint: "contoh: 8",
              ),

              const SizedBox(height: 12),

              _buildTextField(
                controller: tinggiController,
                label: "Tinggi Piramida (t)",
                hint: "contoh: 6",
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: hitung,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Hitung",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: reset,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              if (sudahHitung) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Hasil Perhitungan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Volume:", style: TextStyle(fontSize: 16)),
                          Text(
                            "${volume.toStringAsFixed(2)} cm³",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Luas Permukaan:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${luas.toStringAsFixed(2)} cm²",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Rumus referensi
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Rumus yang digunakan:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "V = ⅓ × p × l × t",
                        style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
                      ),
                      Text(
                        "L = (p×l) + 2×(½×p×tsp) + 2×(½×l×tsl)",
                        style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
                      ),
                      Text(
                        "tsp = √(t² + (l/2)²)",
                        style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
                      ),
                      Text(
                        "tsl = √(t² + (p/2)²)",
                        style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
