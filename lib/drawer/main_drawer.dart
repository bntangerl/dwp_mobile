import 'package:belajar_flutter/pages/daftar_penerima.dart';
import 'package:belajar_flutter/pages/login_page.dart';
import 'package:belajar_flutter/pages/pengambilan_barang.dart';
import 'package:belajar_flutter/pages/validasi_penerima.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      child: ListView(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: const Color.fromARGB(255, 21, 21, 21),
              image: DecorationImage(
                image: AssetImage('assets/dwp_polije.png'),
                ),
              ),
            ),

            ListTile(
              leading: HeroIcon(
                HeroIcons.identification,
                color: Colors.white,
                ),
                title: Text('Daftar Penerima',
                style: TextStyle(color: Colors.white),
                ),
                onTap: (){
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => DaftarPenerimaPage()));
                },
            ),

            ListTile(
              leading: 
              HeroIcon(
                HeroIcons.checkCircle,
                color: Colors.white),
                title: Text('Validasi Penerima', 
                style: TextStyle(color: Colors.white),
                ),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ValidasiPenerimaPage()));
                }
            ),

            ListTile(
              leading:
              HeroIcon(
                HeroIcons.archiveBox, color: Colors.white),
                title: Text('Pengambilan Barang',
                style: TextStyle(color: Colors.white),
                ),
                onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PengambilanBarangPage()));
                },
            ),

            ListTile(
              leading:
              HeroIcon(
                HeroIcons.arrowLeftEndOnRectangle, color: Colors.white),
                title: Text('Log Out',
                style: TextStyle(color: Colors.white),
                ),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Konfirmasi'),
                      content: Text('Apakah Anda yakin ingin keluar?'),
                      actions: [
                        TextButton(
                          child: Text('Batal'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Ya'),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            // Logika untuk logout
                          },
                        ),
                      ],
                    ),
                  );
                },
            ),
          ],
        ),
    );
  }
}