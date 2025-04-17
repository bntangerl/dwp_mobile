import 'package:flutter/material.dart';
import 'package:belajar_flutter/drawer/main_drawer.dart';

class Halaman3Page extends StatefulWidget{
  _Halaman3PageState createState() => _Halaman3PageState();
}

class _Halaman3PageState extends State<Halaman3Page>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        title: Text('Halaman 3',
        style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}