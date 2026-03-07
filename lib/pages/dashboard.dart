import 'package:flutter/material.dart';
import 'prima.dart';
import 'stopwatch_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard Cuyyy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Menu Dashboard',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {},
                child: const Text("Data Kelompok"),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {},
                child: const Text("Penjumlahan & Pengurangan"),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Prima()),
                  );
                },
                child: const Text("Cek Bilangan (Ganjil / Genap / Prima)"),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {},
                child: const Text("Jumlah Total Angka"),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StopwatchPage(),
                    ),
                  );
                },
                child: const Text("Stopwatch"),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {},
                child: const Text("Luas & Volume Piramid"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
