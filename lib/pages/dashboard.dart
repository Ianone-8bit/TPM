import 'package:flutter/material.dart';
import 'package:state/pages/datakelompok.dart';
import 'package:state/pages/jumlahangka.dart';
import 'prima.dart';
import 'stopwatch_page.dart';
import 'tambahkurang.dart';
import 'login_page.dart';
import 'pyramid.dart';
import 'weton.dart';
import 'hijriah.dart';
import 'hitungumur.dart';
import 'saka.dart';

class Dashboard extends StatefulWidget {
  final String username;
  const Dashboard({super.key, required this.username});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Haloo, ${widget.username}!',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Menu Dashboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  constraints: const BoxConstraints(maxWidth: 450),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.8,
                    children: [
                      _buildMenuButton(
                        context,
                        "Data Kelompok",
                        Icons.group,
                        const DataKelompok(),
                      ),
                      _buildMenuButton(
                        context,
                        "Penjumlahan",
                        Icons.add_box,
                        const TambahKurang(),
                      ),
                      _buildMenuButton(
                        context,
                        "Cek Bilangan",
                        Icons.calculate,
                        const Prima(),
                      ),
                      _buildMenuButton(
                        context,
                        "Total Angka",
                        Icons.summarize,
                        const TotalAngka(),
                      ),
                      _buildMenuButton(
                        context,
                        "Stopwatch",
                        Icons.timer,
                        const StopwatchPage(),
                      ),
                      _buildMenuButton(
                        context,
                        "Kalkulator Piramida",
                        Icons.change_history,
                        const Pyramid(),
                      ),
                      _buildMenuButton(
                        context,
                        "Weton",
                        Icons.calendar_month,
                        const Weton(),
                      ),
                      _buildMenuButton(
                        context,
                        "Kalender Hijriah",
                        Icons.mosque,
                        const Hijriah(),
                      ),
                      _buildMenuButton(
                        context,
                        "Kalender Saka",
                        Icons.auto_awesome,
                        const Saka(),
                      ),
                      _buildMenuButton(
                        context,
                        "Cek Umur",
                        Icons.cake,
                        const HitungUmurPage(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget dengan susunan Logo Kiri, Teks Kanan
  Widget _buildMenuButton(
    BuildContext context,
    String label,
    IconData icon,
    Widget page,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[50],
        foregroundColor: Colors.blue[900],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.blue.shade100),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
