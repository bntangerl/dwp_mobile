import 'package:flutter/material.dart';
import 'package:belajar_flutter/drawer/main_drawer.dart';

class DashboardPage extends StatefulWidget {
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Daftar data karyawan
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[900],
        ),
      ),
    ),
    );
  }
}
