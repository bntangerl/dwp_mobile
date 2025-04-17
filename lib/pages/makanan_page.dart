import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:belajar_flutter/drawer/main_drawer.dart';
import 'package:belajar_flutter/models/makanan.dart';

class MakananPage extends StatefulWidget {
  @override
  MakananPageState createState() => MakananPageState();
}

class MakananPageState extends State<MakananPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        title: Text('Menu Makanan',
          style: TextStyle(color: Colors.white),
          ),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: daftarMakanan.length,
        itemBuilder: (context, index) {
          final makanan = daftarMakanan[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  makanan.gambar_makanan, 
                  width: 60, 
                  height: 60, 
                  fit: BoxFit.cover
                  ),
              ),
              title: Text(
                makanan.nama_makanan, 
                style: TextStyle(
                  fontWeight: 
                  FontWeight.bold)),
              subtitle: Text("${makanan.harga_makanan}"),          
              ),
             );
          },
        )
      );
  }
}