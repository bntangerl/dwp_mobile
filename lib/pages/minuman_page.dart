import 'package:flutter/material.dart';
import 'package:belajar_flutter/drawer/main_drawer.dart';

class MinumanPage extends StatefulWidget {
  _MinumanPageState createState() => _MinumanPageState();
}

class _MinumanPageState extends State<MinumanPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        title: Text('Halaman 2', 
        style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white),
          child: Text('Tekan Saya'),
          onPressed: (){
            print('Button Berhasil Ditekan hehehehe');
          },
          ),
        ),
    );
  }
}