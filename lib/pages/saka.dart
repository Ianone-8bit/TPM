import 'package:flutter/material.dart';

class Saka extends StatefulWidget {
  const Saka({super.key});

  @override
  State<Saka> createState() => _SakaState();
}

class _SakaState extends State<Saka> {
  DateTime? selectedDate;
  String hasil = "";

  final List<String> saptawara = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  final List<String> pancawara = ['Legi', 'Paing', 'Pon', 'Wage', 'Kliwon'];

  final List<String> bulanSaka = [
    "Kasa",
    "Karo",
    "Katiga",
    "Kapat",
    "Kalima",
    "Kanem",
    "Kapitu",
    "Kawalu",
    "Kasanga",
    "Kadasa",
    "Jiyestha",
    "Sadha",
  ];

  String getPancawara(DateTime date) {
    final DateTime referensi = DateTime(1970, 1, 1);
    final int selisihHari = date.difference(referensi).inDays;

    int index = (selisihHari + 3) % 5;
    if (index < 0) index += 5;

    return pancawara[index];
  }

  bool cekKabisat(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  void hitungSaka() {
    if (selectedDate == null) {
      setState(() {
        hasil = "Silakan pilih tanggal terlebih dahulu.";
      });
      return;
    }

    DateTime tgl = selectedDate!;
    int thnMasehi = tgl.year;
    bool isLeap = cekKabisat(thnMasehi);

    DateTime awalSaka = DateTime(thnMasehi, 3, isLeap ? 21 : 22);
    int thnSaka = thnMasehi - 78;

    if (tgl.isBefore(awalSaka)) {
      thnSaka -= 1;
      bool isPrevLeap = cekKabisat(thnMasehi - 1);
      awalSaka = DateTime(thnMasehi - 1, 3, isPrevLeap ? 21 : 22);
      isLeap = isPrevLeap;
    }

    int selisihHari = tgl.difference(awalSaka).inDays;

    List<int> hariBulan = [
      isLeap ? 31 : 30,
      31,
      31,
      31,
      31,
      31,
      30,
      30,
      30,
      30,
      30,
      30,
    ];

    int bulanIdx = 0;
    while (bulanIdx < 12 && selisihHari >= hariBulan[bulanIdx]) {
      selisihHari -= hariBulan[bulanIdx];
      bulanIdx++;
    }

    String hariMasehi = saptawara[tgl.weekday - 1];
    String hariPasaran = getPancawara(tgl);
    int tglSaka = selisihHari + 1;

    setState(() {
      hasil =
          "Hari      : $hariMasehi $hariPasaran\n"
          "Masehi    : ${tgl.day.toString().padLeft(2, '0')}-${tgl.month.toString().padLeft(2, '0')}-${tgl.year}\n"
          "Saka      : $tglSaka ${bulanSaka[bulanIdx]} $thnSaka";
    });
  }

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2100, 12, 31),
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
          "Konverter Kalender Saka",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: pilihTanggal,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                selectedDate == null
                    ? "Ketuk untuk pilih tanggal"
                    : "${saptawara[selectedDate!.weekday - 1]}, ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: hitungSaka,
              icon: const Icon(Icons.search),
              label: const Text("Konversi Ke Saka "),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),

            const SizedBox(height: 30),

            if (hasil.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "HASIL PERHITUNGAN:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Divider(),
                    Text(
                      hasil,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 2.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
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
