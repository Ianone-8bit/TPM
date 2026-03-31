import 'package:flutter/material.dart';
import 'package:hijri_calendar/hijri_calendar.dart';

class Hijriah extends StatefulWidget {
  const Hijriah({super.key});

  @override
  State<Hijriah> createState() => _HijriahState();
}

class _HijriahState extends State<Hijriah> {
  DateTime? selectedDate;
  String hasil = "";
  bool _isMuhammadiyah = true; // true = Muhammadiyah, false = NU

  static final DateTime _minDate = DateTime(1937, 1, 1);
  static final DateTime _maxDate = DateTime(2076, 12, 31);

  final List<String> _namaBulanHijriahId = [
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

  final List<String> _namaHariId = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  String _getNamaHari(int weekday) => _namaHariId[weekday - 1];

  void cekHijriah() {
    if (selectedDate == null) {
      setState(() {
        hasil = "Silakan pilih tanggal terlebih dahulu.";
      });
      return;
    }

    try {
      HijriCalendarConfig.language = 'en';

      // opsi untuk muhammadiyah
      final tanggalDihitung =
          _isMuhammadiyah
              ? selectedDate!
              : selectedDate!.subtract(const Duration(days: 1));

      final hijriah = HijriCalendarConfig.fromGregorian(tanggalDihitung);

      int hDay = hijriah.hDay;
      int hMonth = hijriah.hMonth;
      int hYear = hijriah.hYear;
      String namaBulan = _namaBulanHijriahId[hMonth - 1];
      String namaHari = _getNamaHari(selectedDate!.weekday);
      String metode = _isMuhammadiyah ? "Hisab (Muhammadiyah)" : "Rukyat (NU)";

      String tglMasehi =
          "${selectedDate!.day.toString().padLeft(2, '0')}-"
          "${selectedDate!.month.toString().padLeft(2, '0')}-"
          "${selectedDate!.year}";

      String tglHijriah =
          "${hDay.toString().padLeft(2, '0')} $namaBulan $hYear H";

      setState(() {
        hasil =
            "Metode  : $metode\n"
            "Hari    : $namaHari\n"
            "Masehi  : $tglMasehi\n"
            "Hijriah : $tglHijriah";
      });
    } catch (_) {
      setState(() {
        hasil = "Gagal mengonversi tanggal, silakan coba lagi.";
      });
    }
  }

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: _minDate,
      lastDate: _maxDate,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        hasil = "";
      });
    }
  }

  String _labelTombol() {
    if (selectedDate == null) return "Pilih Tanggal Masehi";
    String namaHari = _getNamaHari(selectedDate!.weekday);
    String tgl =
        "${selectedDate!.day.toString().padLeft(2, '0')}-"
        "${selectedDate!.month.toString().padLeft(2, '0')}-"
        "${selectedDate!.year}";
    return "$namaHari, $tgl";
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
            // Toggle Muhammadiyah / NU
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          () => setState(() {
                            _isMuhammadiyah = true;
                            hasil = "";
                          }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              _isMuhammadiyah
                                  ? Colors.green.shade700
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Muhammadiyah",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color:
                                    _isMuhammadiyah
                                        ? Colors.white
                                        : Colors.green.shade700,
                              ),
                            ),
                            Text(
                              "Hisab",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color:
                                    _isMuhammadiyah
                                        ? Colors.white70
                                        : Colors.green.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          () => setState(() {
                            _isMuhammadiyah = false;
                            hasil = "";
                          }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              !_isMuhammadiyah
                                  ? Colors.green.shade700
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "NU",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color:
                                    !_isMuhammadiyah
                                        ? Colors.white
                                        : Colors.green.shade700,
                              ),
                            ),
                            Text(
                              "Rukyat",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color:
                                    !_isMuhammadiyah
                                        ? Colors.white70
                                        : Colors.green.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: pilihTanggal,
              icon: const Icon(Icons.calendar_today),
              label: Text(_labelTombol()),
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
