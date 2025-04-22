import 'package:belajar_flutter/pages/daftar_penerima.dart';
import 'package:belajar_flutter/pages/minuman_page.dart';
import 'package:belajar_flutter/pages/makanan_page.dart';
import 'package:belajar_flutter/pages/halaman_3_page.dart';
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
                    context, MaterialPageRoute(builder: (context) => DaftarPenerima()));
                },
            ),

            ListTile(
              leading: 
              HeroIcon(
                HeroIcons.documentText,
                color: Colors.white),
                title: Text('Verifikasi Pembayaran',
                style: TextStyle(color: Colors.white),
                ),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MakananPage()));
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MinumanPage()));
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Halaman3Page()));
                },
            ),

            ListTile(
              leading: 
              HeroIcon(HeroIcons.academicCap, color: Colors.white),
              title: Text('Unit/Jurusan',
              style: TextStyle(color: Colors.white),
              ),
            ),

            ListTile(
              leading: 
              HeroIcon(HeroIcons.briefcase, color: Colors.white),
              title: Text('Jabatan',
              style: TextStyle(color: Colors.white),
              ),
            ),

            ListTile(
              leading: 
              HeroIcon(HeroIcons.shieldCheck, color: Colors.white),
              title: Text('Peran', 
              style: TextStyle(color: Colors.white), 
              ),
            ),

            ListTile(
              leading: HeroIcon(
                HeroIcons.userCircle, color: Colors.white),
              title: Text('Akun', 
              style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
    );
  }
}