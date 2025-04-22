import 'package:flutter/material.dart';
import 'package:belajar_flutter/drawer/main_drawer.dart';

class DaftarPenerima extends StatefulWidget {
  _DaftarPenerimaState createState() => _DaftarPenerimaState();
}

class _DaftarPenerimaState extends State<DaftarPenerima> {
  // Data untuk tabel
  final List<Map<String, String>> dataPenerima = [
    {
      'nip': '25317236112',
      'nama': 'Rifky Tahir',
      'jurusan': 'Manajemen Informatika',
      'jabatan': 'Dosen',
    },
    {
      'nip': '25317126123',
      'nama': 'Zaidan Setyawan',
      'jurusan': 'Manajemen Informatika',
      'jabatan': 'Dosen',
    },
    {
      'nip': '25314246112',
      'nama': 'Anas Wijaya',
      'jurusan': 'Bisnis Digital',
      'jabatan': 'Dosen',
    },
    {
      'nip': '25464746112',
      'nama': 'Andi Bogard',
      'jurusan': 'Kesehatan',
      'jabatan': 'Dosen',
    },
    {
      'nip': '62362832212',
      'nama': 'Srikaya Sriwijaya',
      'jurusan': 'Teknik Informatika',
      'jabatan': 'Dosen',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        title: Text('Daftar Penerima', style: TextStyle(color: Colors.white)),
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 174, 0),
                        minimumSize: Size(100, 20),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final TextEditingController namaController =
                                TextEditingController();
                            final TextEditingController jurusanController =
                                TextEditingController();

                            return AlertDialog(
                              backgroundColor: Color.fromARGB(255, 30, 30, 30),
                              title: Text(
                                'Form Penerima',
                                style: TextStyle(color: Colors.white),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: namaController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Nama',
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: jurusanController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Jurusan',
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Batal'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    print("Nama: ${namaController.text}");
                                    print("Jurusan: ${jurusanController.text}");
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Simpan'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Tambah',
                        style: TextStyle(
                          fontSize: 14, 
                          color: Colors.white
                          ),
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header tabel
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text(
                                        'NIP/NIK/PPPK',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text(
                                        'Nama',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text(
                                        'Jurusan',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        'Jabatan',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Baris-baris data
                          for (int i = 0; i < dataPenerima.length; i++)
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    i % 2 == 0
                                        ? Color.fromARGB(255, 40, 40, 40)
                                        : Color.fromARGB(255, 35, 35, 35),
                                // Membuat sudut melengkung pada baris terakhir
                                borderRadius:
                                    i == dataPenerima.length - 1
                                        ? BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                        )
                                        : null,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          dataPenerima[i]['nip'] ?? '',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          dataPenerima[i]['nama'] ?? '',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          dataPenerima[i]['jurusan'] ?? '',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          dataPenerima[i]['jabatan'] ?? '',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
