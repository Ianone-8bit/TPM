import 'package:flutter/material.dart';

class Weton extends StatefulWidget {
  const Weton({super.key});

  @override
  State<Weton> createState() => _WetonState();
}

class _WetonState extends State<Weton> {
  DateTime? selectedDate;

  String namaHari = "";
  String namaPasaran = "";
  String hasilWeton = "";
  String pesanError = "";

  final List<String> hariList = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];

  final List<String> pasaranList = ["Legi", "Pahing", "Pon", "Wage", "Kliwon"];

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        pesanError = "";
        namaHari = "";
        namaPasaran = "";
        hasilWeton = "";
      });
    }
  }

  String _formatTanggal(DateTime date) {
    const namaBulan = [
      "",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];
    return "${date.day} ${namaBulan[date.month]} ${date.year}";
  }

  void _cekWeton() {
    if (selectedDate == null) {
      setState(() {
        pesanError = "Silakan pilih tanggal terlebih dahulu";
        namaHari = "";
        namaPasaran = "";
        hasilWeton = "";
      });
      return;
    }

    final date = selectedDate!;
    final hari = hariList[date.weekday - 1];

    final DateTime tanggalAcuan = DateTime(1945, 8, 17);
    final int selisihHari = date.difference(tanggalAcuan).inDays;

    int indexPasaran = selisihHari % 5;
    if (indexPasaran < 0) indexPasaran += 5;

    final pasaran = pasaranList[indexPasaran];

    setState(() {
      namaHari = hari;
      namaPasaran = pasaran;
      hasilWeton = "$hari $pasaran";
      pesanError = "";
    });
  }

  void _reset() {
    setState(() {
      selectedDate = null;
      namaHari = "";
      namaPasaran = "";
      hasilWeton = "";
      pesanError = "";
    });
  }

  String _labelTombol() {
    if (selectedDate == null) return "Pilih Tanggal";
    final namaHari = hariList[selectedDate!.weekday - 1];
    return "$namaHari, ${_formatTanggal(selectedDate!)}";
  }

  Widget _halfInfoCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fullInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
        ],
      ),
    );
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Temukan hari, pasaran, dan weton Jawa berdasarkan tanggal pilihanmu.",
              style: TextStyle(fontSize: 14, color: Colors.blue.shade700),
            ),
            const SizedBox(height: 16),

            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.event, color: Colors.blue),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _labelTombol(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _cekWeton,
                icon: const Icon(Icons.search),
                label: const Text("Cek Hari dan Weton"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Reset"),
              ),
            ),

            const SizedBox(height: 8),

            if (pesanError.isNotEmpty)
              Text(pesanError, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 16),

            if (hasilWeton.isNotEmpty) ...[
              Row(
                children: [
                  _halfInfoCard("Hari", namaHari),
                  const SizedBox(width: 16),
                  _halfInfoCard("Pasaran", namaPasaran),
                ],
              ),
              const SizedBox(height: 16),
              _fullInfoCard("Weton", hasilWeton),
            ],
          ],
        ),
      ),
    );
  }
}
