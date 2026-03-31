import 'dart:async';
import 'package:flutter/material.dart';

class HitungUmurPage extends StatefulWidget {
  const HitungUmurPage({super.key});

  @override
  State<HitungUmurPage> createState() => _HitungUmurPageState();
}

class _HitungUmurPageState extends State<HitungUmurPage> {
  DateTime? _tanggalLahir;
  TimeOfDay? _jamLahir;
  String _pesanError = '';
  bool _sudahDihitung = false;
  Timer? _timerRealtime;

  int _umurTahun = 0;
  int _umurBulan = 0;
  int _umurHari = 0;
  int _umurJam = 0;
  int _umurMenit = 0;
  int _umurDetik = 0;

  void _stopRealtimeUpdate() {
    _timerRealtime?.cancel();
    _timerRealtime = null;
  }

  void _startRealtimeUpdate() {
    _stopRealtimeUpdate();
    _timerRealtime = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || !_sudahDihitung || _tanggalLahir == null) return;
      _hitungUmur(startRealtime: false);
    });
  }

  void _resetHasil() {
    _stopRealtimeUpdate();
    _umurTahun = 0;
    _umurBulan = 0;
    _umurHari = 0;
    _umurJam = 0;
    _umurMenit = 0;
    _umurDetik = 0;
    _sudahDihitung = false;
  }

  Future<void> _pickTanggalLahir() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (!mounted) return;
    if (picked != null) {
      _stopRealtimeUpdate();
      setState(() {
        _tanggalLahir = picked;
        _pesanError = '';
        _sudahDihitung = false;
      });
    }
  }

  Future<void> _pickJamLahir() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _jamLahir ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (!mounted) return;
    if (picked != null) {
      _stopRealtimeUpdate();
      setState(() {
        _jamLahir = picked;
        _pesanError = '';
        _sudahDihitung = false;
      });
    }
  }

  String _formatTanggal(DateTime date) {
    const namaBulan = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${namaBulan[date.month]} ${date.year}';
  }

  String _tanggalPilihanText() {
    if (_tanggalLahir == null) return 'Pilih tanggal lahir';
    return _formatTanggal(_tanggalLahir!);
  }

  String _jamPilihanText() {
    if (_jamLahir == null) return 'Pilih jam lahir (opsional)';
    final h = _jamLahir!.hour.toString().padLeft(2, '0');
    final m = _jamLahir!.minute.toString().padLeft(2, '0');
    return '$h:$m WIB';
  }

  int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  void _hitungUmur({bool startRealtime = true}) {
    if (_tanggalLahir == null) {
      setState(() {
        _pesanError = 'Silakan pilih tanggal lahir terlebih dahulu';
        _resetHasil();
      });
      return;
    }

    try {
      final now = DateTime.now();

      // Gabungkan tanggal + jam lahir
      final lahir = DateTime(
        _tanggalLahir!.year,
        _tanggalLahir!.month,
        _tanggalLahir!.day,
        _jamLahir?.hour ?? 0,
        _jamLahir?.minute ?? 0,
        0,
      );

      if (lahir.isAfter(now)) {
        setState(() {
          _pesanError = 'Tanggal/jam lahir tidak boleh lebih dari sekarang';
          _resetHasil();
        });
        return;
      }

      int years = now.year - lahir.year;
      int months = now.month - lahir.month;
      int days = now.day - lahir.day;
      int hours = now.hour - lahir.hour;
      int minutes = now.minute - lahir.minute;
      int seconds = now.second - lahir.second;

      if (seconds < 0) {
        seconds += 60;
        minutes -= 1;
      }

      if (minutes < 0) {
        minutes += 60;
        hours -= 1;
      }

      if (hours < 0) {
        hours += 24;
        days -= 1;
      }

      if (days < 0) {
        final prevYear = now.month == 1 ? now.year - 1 : now.year;
        final prevMonth = now.month == 1 ? 12 : now.month - 1;
        days += _daysInMonth(prevYear, prevMonth);
        months -= 1;
      }

      if (months < 0) {
        months += 12;
        years -= 1;
      }

      if (years < 0) {
        setState(() {
          _pesanError = 'Tanggal lahir tidak valid';
          _resetHasil();
        });
        return;
      }

      setState(() {
        _pesanError = '';
        _sudahDihitung = true;
        _umurTahun = years;
        _umurBulan = months;
        _umurHari = days;
        _umurJam = hours;
        _umurMenit = minutes;
        _umurDetik = seconds;
      });

      if (startRealtime) _startRealtimeUpdate();
    } catch (_) {
      setState(() {
        _pesanError = 'Terjadi kesalahan, silakan coba lagi';
        _resetHasil();
      });
    }
  }

  void _resetInputDanHasil() {
    setState(() {
      _tanggalLahir = null;
      _jamLahir = null;
      _pesanError = '';
      _resetHasil();
    });
  }

  @override
  void dispose() {
    _stopRealtimeUpdate();
    super.dispose();
  }

  Widget _halfInfoCard(String title, String value, ColorScheme colorScheme) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fullInfoCard(String title, String value, ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pickerRow(
    IconData icon,
    String label,
    VoidCallback onTap,
    ColorScheme colorScheme,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorScheme.surfaceContainerLowest,
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Umur'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hitung umur berdasarkan tanggal lahir dalam tahun, bulan, hari, jam, menit, dan detik.',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            _pickerRow(
              Icons.cake_rounded,
              _tanggalPilihanText(),
              _pickTanggalLahir,
              colorScheme,
            ),
            const SizedBox(height: 12),
            _pickerRow(
              Icons.access_time_rounded,
              _jamPilihanText(),
              _pickJamLahir,
              colorScheme,
            ),
            const SizedBox(height: 16),

            FilledButton(
              onPressed: _hitungUmur,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Hitung Umur'),
            ),
            const SizedBox(height: 8),

            OutlinedButton(
              onPressed: _resetInputDanHasil,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Reset'),
            ),
            const SizedBox(height: 8),

            if (_pesanError.isNotEmpty)
              Text(_pesanError, style: TextStyle(color: colorScheme.error)),

            const SizedBox(height: 16),

            if (_sudahDihitung && _pesanError.isEmpty) ...[
              _fullInfoCard(
                'Hasil Lengkap',
                '$_umurTahun tahun $_umurBulan bulan $_umurHari hari\n$_umurJam jam $_umurMenit menit $_umurDetik detik',
                colorScheme,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _halfInfoCard('Tahun', _umurTahun.toString(), colorScheme),
                  const SizedBox(width: 16),
                  _halfInfoCard('Bulan', _umurBulan.toString(), colorScheme),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _halfInfoCard('Hari', _umurHari.toString(), colorScheme),
                  const SizedBox(width: 16),
                  _halfInfoCard('Jam', _umurJam.toString(), colorScheme),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _halfInfoCard('Menit', _umurMenit.toString(), colorScheme),
                  const SizedBox(width: 16),
                  _halfInfoCard('Detik', _umurDetik.toString(), colorScheme),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
