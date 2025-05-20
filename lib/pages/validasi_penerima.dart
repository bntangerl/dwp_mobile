import 'dart:convert';
import 'package:belajar_flutter/drawer/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/models/validasi_penerima.dart';

class ValidasiPenerimaPage extends StatefulWidget {
  @override
  _ValidasiPenerimaPageState createState() => _ValidasiPenerimaPageState();
}

class _ValidasiPenerimaPageState extends State<ValidasiPenerimaPage> {

  List<ValidasiPenerima> validasiPenerimaList = [];
  List<ValidasiPenerima> filteredList = [];

  TextEditingController searchController = TextEditingController();

  bool isLoading = true;



  @override
  void initState() {
    super.initState();
    fetchPenerima();
  }

  Future<void> fetchPenerima() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/validasi-penerimaans'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ValidasiPenerima> dataDariApi = List<ValidasiPenerima>.from(
        data.map((json) => ValidasiPenerima.fromJson(json)),
      );

      setState(() {
        validasiPenerimaList = dataDariApi;
        filteredList = dataDariApi; // <- Ini dia ditempatkan di sini
        isLoading = false;
      });
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  void filterSearchResults(String query) {
  List<ValidasiPenerima> dummySearchList = [];
  dummySearchList.addAll(validasiPenerimaList);

  if (query.isNotEmpty) {
    List<ValidasiPenerima> dummyListData = dummySearchList.where((item) {
      return item.nama.toLowerCase().contains(query.toLowerCase()) ||
             item.nik.toLowerCase().contains(query.toLowerCase()) ||
             item.email.toLowerCase().contains(query.toLowerCase()) ||
             item.noTelpon.toLowerCase().contains(query.toLowerCase()) ||
             item.meja.toLowerCase().contains(query.toLowerCase()) ||
             item.barcode.toLowerCase().contains(query.toLowerCase()) ||
             item.status.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
        filteredList = dummyListData;
      });
    } else {
      setState(() {
        filteredList = validasiPenerimaList;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      drawer: MainDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Validasi Penerima', 
            style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Search & Buat
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: filterSearchResults,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Cari',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.orange),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Text('Buat', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Daftar Penerima
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final validasiPenerima = filteredList[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("NAMA            : ${validasiPenerima.nama}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("NIP/NIK/NIPPK   : ${validasiPenerima.nik}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("EMAIL           : ${validasiPenerima.email}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("NO TELEPON      : ${validasiPenerima.noTelpon}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("MEJA            : ${validasiPenerima.meja}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("BARCODE         : ${validasiPenerima.barcode}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: validasiPenerima.status == 'berhasil_di_validasi' ? const Color.fromARGB(255, 1, 66, 3):
                                          validasiPenerima.status == 'belum_di_validasi' ? const Color.fromARGB(255, 66, 59, 0):
                                          Colors.grey,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    validasiPenerima.status == 'berhasil_di_validasi'
                                        ? 'Berhasil Di Validasi'
                                        : validasiPenerima.status == 'belum_di_validasi'
                                            ? 'Belum Di Validasi'
                                            : 'Status Tidak Diketahui',
                                    style: TextStyle(
                                      color: validasiPenerima.status == 'belum_di_validasi' 
                                      ? const Color.fromARGB(255, 186, 168, 0) 
                                      : const Color.fromARGB(255, 10, 179, 16), 
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],  
                            ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
