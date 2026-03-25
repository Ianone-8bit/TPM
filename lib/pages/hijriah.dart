import 'package:flutter/material.dart';

class Hijriah extends StatefulWidget {
  const Hijriah({super.key});

  @override
  State<Hijriah> createState() => _HijriahState();
}

class _HijriahState extends State<Hijriah> {
  DateTime? selectedDate;
  String hasil = "";

  final List<String> namaBulanHijriah = [
    "Muharram",
    "Safar",
    "Rabi'ul Awal",
    "Rabi'ul Akhir",
    "Jumadil Awal",
    "Jumadil Akhir",
    "Rajab",
    "Sya'ban",
    "Ramadhan",
    "Syawal",
    "Dzulqa'dah",
    "Dzulhijjah",
  ];

  // Konversi Masehi ke Hijriah menggunakan algoritma JDN
  Map<String, int> maseh2Hijriah(int y, int m, int d) {
    // Hitung Julian Day Number dari tanggal Masehi
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

    // Konversi JDN ke Hijriah
    int l = jdn - 1948440 + 10632;
    int n = ((l - 1) / 10631).floor();
    l = l - 10631 * n + 354;
    int j =
        ((10985 - l) / 5316).floor() * ((50 * l) / 17719).floor() +
        (l / 5670).floor() * ((43 * l) / 15238).floor();
    l =
        l -
        ((30 - j) / 15).floor() * ((17719 * j) / 50).floor() -
        (j / 16).floor() * ((15238 * j) / 43).floor() +
        29;
    int month = ((24 * l) / 709).floor();
    int day = l - ((709 * month) / 24).floor();
    int year = 30 * n + j - 30;

    return {"day": day, "month": month, "year": year};
  }

  void cekHijriah() {
    if (selectedDate == null) {
      setState(() {
        hasil = "Silakan pilih tanggal terlebih dahulu.";
      });
      return;
    }

    final hijriah = maseh2Hijriah(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
    );

    int hDay = hijriah["day"]!;
    int hMonth = hijriah["month"]!;
    int hYear = hijriah["year"]!;
    String namaBulan = namaBulanHijriah[hMonth - 1];

    String tglMasehi =
        "${selectedDate!.day.toString().padLeft(2, '0')}-"
        "${selectedDate!.month.toString().padLeft(2, '0')}-"
        "${selectedDate!.year}";

    String tglHijriah =
        "${hDay.toString().padLeft(2, '0')} $namaBulan $hYear H";

    setState(() {
      hasil =
          "Masehi  : $tglMasehi\n"
          "Hijriah : $tglHijriah\n\n";
    });
  }

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(622), // Awal kalender Hijriah
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
          "Cek Tanggal Hijriah",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade700,
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
                    ? "Pilih Tanggal Masehi"
                    : "${selectedDate!.day.toString().padLeft(2, '0')}-"
                        "${selectedDate!.month.toString().padLeft(2, '0')}-"
                        "${selectedDate!.year}",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: cekHijriah,
              icon: const Icon(Icons.search),
              label: const Text("Konversi ke Hijriah"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            if (hasil.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.mosque,
                          color: Colors.green.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Hasil Konversi",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      hasil,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        height: 1.8,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
