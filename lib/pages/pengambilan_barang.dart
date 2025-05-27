import 'package:flutter/material.dart';
import 'package:belajar_flutter/drawer/main_drawer.dart';
import 'package:belajar_flutter/models/pengambilan_barang.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengambilanBarangPage extends StatefulWidget{
  _PengambilanBarangPageState createState() => _PengambilanBarangPageState();
}

class _PengambilanBarangPageState extends State<PengambilanBarangPage>{
  List<PengambilanBarang> pengambilanList = [];
  List<PengambilanBarang> filteredPengambilanList = [];

  TextEditingController searchController = TextEditingController();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noTelponController = TextEditingController();
  final TextEditingController namaJurusanController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();

  bool isLoading = true;



  @override
  void initState() {
    super.initState();
    fetchPengambilanBarang();
  }

  Future<void> fetchPengambilanBarang() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/pengambilan-barang'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<PengambilanBarang> dataDariApi = List<PengambilanBarang>.from(
        data.map((json) => PengambilanBarang.fromJson(json)),
      );

      setState(() {
        pengambilanList = dataDariApi;
        filteredPengambilanList = dataDariApi; // <- Ini dia ditempatkan di sini
        isLoading = false;
      });
    } else {
      throw Exception('Gagal memuat data');
    }
  }
  
  void filterSearchResults(String query) {
    List<PengambilanBarang> dummySearchList = [];
    dummySearchList.addAll(pengambilanList);

    if (query.isNotEmpty) {
      List<PengambilanBarang> dummyListData = dummySearchList.where((item) {
        return item.nik.toLowerCase().contains(query.toLowerCase()) ||
              item.nama.toLowerCase().contains(query.toLowerCase()) ||
              item.email.toLowerCase().contains(query.toLowerCase()) ||
              item.noTelpon.toLowerCase().contains(query.toLowerCase()) ||
              item.meja.toLowerCase().contains(query.toLowerCase()) ||
              item.barcode.toLowerCase().contains(query.toLowerCase()) ||
              item.statusPengambilan.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredPengambilanList = dummyListData;
      });
    } else {
      setState(() {
        filteredPengambilanList = pengambilanList;
      });
    }
  }

  Future<void> konfirmasiPengambilan(int id) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/pengambilan-barang/konfirmasi/$id');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        // Sukses konfirmasi
        print('Konfirmasi berhasil');
      } else {
        // Gagal konfirmasi
        print('Gagal konfirmasi: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
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
            Text('Pengambilan Barang', 
            style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
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
                        hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.orange),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Daftar Penerima
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredPengambilanList.length,
                      itemBuilder: (context, index) {
                        final pengambilan = filteredPengambilanList[index];
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
                              Text("NIP/NIK/NIPK   : ${pengambilan.nik}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("NAMA           : ${pengambilan.nik}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("EMAIL          : ${pengambilan.email}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("NO. TELEPON    : ${pengambilan.noTelpon}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("MEJA           : ${pengambilan.meja}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("BARCODE        : ${pengambilan.barcode}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              SizedBox(height: 12),
                              Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: pengambilan.statusPengambilan == 'sudah_diambil' ? const Color.fromARGB(255, 1, 66, 3):
                                          pengambilan.statusPengambilan == 'belum_diambil' ? const Color.fromARGB(255, 66, 59, 0):
                                          Colors.grey,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    pengambilan.statusPengambilan == 'sudah_diambil'
                                        ? 'Sudah Diambil'
                                        : pengambilan.statusPengambilan == 'belum_diambil'
                                            ? 'Belum Diambil'
                                            : 'Status Tidak Diketahui',
                                    style: TextStyle(
                                      color: pengambilan.statusPengambilan == 'belum_diambil' 
                                      ? const Color.fromARGB(255, 186, 168, 0) 
                                      : const Color.fromARGB(255, 10, 179, 16), 
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 160),

                                if (pengambilan.statusPengambilan == 'belum_diambil')
                                ElevatedButton(
                                  onPressed: () async {
                                    final shouldConfirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Konfirmasi'),
                                        content: Text('Apakah Anda yakin ingin mengkonfirmasi penerima ini?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: Text('Ya'),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (shouldConfirm == true) {
                                      await konfirmasiPengambilan(pengambilan.id); // Panggil fungsi konfirmasi
                                      await fetchPengambilanBarang(); // Fungsi ini seharusnya meng-refresh daftar validasi
                                      setState(() {}); // Perbarui UI
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Penerima berhasil dikonfirmasi'), backgroundColor: Colors.green),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                                  ),
                                  child: Text(
                                    'Konfirmasi',
                                    style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 12),
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
