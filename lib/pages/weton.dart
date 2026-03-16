import 'package:flutter/material.dart';

class Weton extends StatefulWidget {
  const Weton({super.key});

  @override
  State<Weton> createState() => _WetonState();
}

class _WetonState extends State<Weton> {
  DateTime? selectedDate;
  String hasil = "";

  final List<String> hari = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];

  final List<String> pasaran = ["Legi", "Pahing", "Pon", "Wage", "Kliwon"];

  int hitungJDN(int y, int m, int d) {
    int a = ((14 - m) / 12).floor();
    int y1 = y + 4800 - a;
    int m1 = m + 12 * a - 3;

    int jdn =
        d +
        ((153 * m1 + 2) / 5).floor() +
        365 * y1 +
        (y1 / 4).floor() -
        (y1 / 100).floor() +
        (y1 / 400).floor() -
        32045;

    return jdn;
  }

  String getPasaran(DateTime date) {
    int jdn = hitungJDN(date.year, date.month, date.day);
    return pasaran[jdn % 5]; // offset 0, referensi: 10 Okt 2005 = Kliwon ✅
  }

  String getHari(DateTime date) {
    return hari[date.weekday - 1]; // Flutter weekday: 1=Senin ... 7=Minggu
  }

  void cekWeton() {
    if (selectedDate == null) {
      setState(() {
        hasil = "Silakan pilih tanggal terlebih dahulu.";
      });
      return;
    }

    String namaHari = getHari(selectedDate!);
    String namaPasaran = getPasaran(selectedDate!);

    String tgl =
        "${selectedDate!.day.toString().padLeft(2, '0')}-"
        "${selectedDate!.month.toString().padLeft(2, '0')}-"
        "${selectedDate!.year}";

    setState(() {
      hasil =
          "Tanggal : $tgl\n"
          "Hari    : $namaHari\n"
          "Pasaran : $namaPasaran\n"
          "Weton   : $namaHari $namaPasaran";
    });
  }

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        hasil = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Weton",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: pilihTanggal,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                selectedDate == null
                    ? "Pilih Tanggal"
                    : "${selectedDate!.day.toString().padLeft(2, '0')}-"
                        "${selectedDate!.month.toString().padLeft(2, '0')}-"
                        "${selectedDate!.year}",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: cekWeton,
              icon: const Icon(Icons.search),
              label: const Text("Cek Weton"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            if (hasil.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  hasil,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.8,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
