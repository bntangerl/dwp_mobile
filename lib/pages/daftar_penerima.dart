import 'dart:convert';
import 'package:belajar_flutter/drawer/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/models/daftar_penerima.dart';

class DaftarPenerimaPage extends StatefulWidget {
  @override
  _DaftarPenerimaPageState createState() => _DaftarPenerimaPageState();
}

class _DaftarPenerimaPageState extends State<DaftarPenerimaPage> {

  List<Penerima> penerimaList = [];
  List<Penerima> filteredList = [];

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
    fetchPenerima();
  }

  Future<void> fetchPenerima() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/penerimas'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Penerima> dataDariApi = List<Penerima>.from(
        data.map((json) => Penerima.fromJson(json)),
      );

      setState(() {
        penerimaList = dataDariApi;
        filteredList = dataDariApi; // <- Ini dia ditempatkan di sini
        isLoading = false;
      });
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<void> deletePenerima(int id) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/penerimas/$id'); // Ganti dengan URL server-mu

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Data berhasil dihapus');
    } else {
      print('Gagal menghapus data: ${response.body}');
    }
  }

  void addFormDialog(BuildContext context) {
  // Clear dulu supaya form kosong untuk tambah data baru
    namaController.clear();
    nikController.clear();
    emailController.clear();
    noTelponController.clear();
    namaJurusanController.clear();
    jabatanController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah Data Penerima', style: TextStyle(fontFamily: 'Poppins', fontSize: 18),),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: namaController, decoration: InputDecoration(labelText: 'Nama', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: nikController, decoration: InputDecoration(labelText: 'NIK', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: noTelponController, decoration: InputDecoration(labelText: 'No Telepon', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: namaJurusanController, decoration: InputDecoration(labelText: 'Nama Jurusan', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: jabatanController, decoration: InputDecoration(labelText: 'Jabatan', labelStyle: TextStyle(fontFamily: 'Poppins'))),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal', style: TextStyle(fontFamily: 'Poppins')),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Tambah data baru ke list, contoh generate id sementara dengan timestamp
                Penerima newPenerima = Penerima(
                  id: DateTime.now().millisecondsSinceEpoch,
                  nik: nikController.text,
                  nama: namaController.text,
                  email: emailController.text,
                  noTelpon: noTelponController.text,
                  jurusanId: 0, // bisa disesuaikan jika ada input jurusanId
                  namaJurusan: namaJurusanController.text,
                  jabatanId: 0, // bisa disesuaikan juga
                  jabatan: jabatanController.text,
                );
                penerimaList.add(newPenerima);
                filteredList.add(newPenerima);
              });
              Navigator.of(context).pop();
            },
            child: Text('Simpan', style: TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }


  void _showEditDialog(Penerima penerima, int index) {
    // Isi controller dengan data saat dialog akan ditampilkan
    namaController.text = penerima.nama;
    nikController.text = penerima.nik;
    emailController.text = penerima.email;
    noTelponController.text = penerima.noTelpon;
    namaJurusanController.text = penerima.namaJurusan;
    jabatanController.text = penerima.jabatan;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Data Penerima',style: TextStyle(fontFamily: 'Poppins'),),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: namaController, decoration: InputDecoration(labelText: 'Nama', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: nikController, decoration: InputDecoration(labelText: 'NIK', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: noTelponController, decoration: InputDecoration(labelText: 'No Telepon', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: namaJurusanController, decoration: InputDecoration(labelText: 'Nama Jurusan', labelStyle: TextStyle(fontFamily: 'Poppins'))),
              TextField(controller: jabatanController, decoration: InputDecoration(labelText: 'Jabatan', labelStyle: TextStyle(fontFamily: 'Poppins'))),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Batal', style: TextStyle(fontFamily: 'Poppins'))),
          ElevatedButton(
            onPressed: () {
              setState(() {
                filteredList[index] = Penerima(
                  id: penerima.id,
                  nik: nikController.text,
                  nama: namaController.text,
                  email: emailController.text,
                  noTelpon: noTelponController.text,
                  jurusanId: penerima.jurusanId,
                  namaJurusan: namaJurusanController.text,
                  jabatanId: penerima.jabatanId,
                  jabatan: jabatanController.text,
                );
                // Update juga di penerimaList asli jika perlu
                int originalIndex = penerimaList.indexWhere((p) => p.id == penerima.id);
                if (originalIndex != -1) {
                  penerimaList[originalIndex] = filteredList[index];
                }
              });
              Navigator.of(context).pop();
            },
            child: Text('Simpan', style: TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
  List<Penerima> dummySearchList = [];
  dummySearchList.addAll(penerimaList);

  if (query.isNotEmpty) {
    List<Penerima> dummyListData = dummySearchList.where((item) {
      return item.nama.toLowerCase().contains(query.toLowerCase()) ||
             item.nik.toLowerCase().contains(query.toLowerCase()) ||
             item.jabatan.toLowerCase().contains(query.toLowerCase()) ||
             item.namaJurusan.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
        filteredList = dummyListData;
      });
    } else {
      setState(() {
        filteredList = penerimaList;
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
            Text('Daftar Penerima', 
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
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.orange),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Buat', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    addFormDialog(context);
                  },
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
                        final penerima = filteredList[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 33, 33, 33),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("NAMA            : ${penerima.nama}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("NIP/NIK/NIPPK   : ${penerima.nik}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("UNIT/JURUSAN    : ${penerima.jabatan}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              Text("JURUSAN         : ${penerima.namaJurusan}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    child: Text('Hapus', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                      onPressed: () async {
                                      final confirm = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Konfirmasi', style: TextStyle(fontFamily: 'Poppins')),
                                          content: Text('Apakah Anda yakin ingin menghapus data ini?', style: TextStyle(fontFamily: 'Poppins')),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(false),
                                              child: Text('Batal', style: TextStyle(fontFamily: 'Poppins')),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(true),
                                              child: Text('Hapus', style: TextStyle(fontFamily: 'Poppins')),
                                            ),
                                          ],
                                        ),
                                      );
                                      if (confirm == true) {
                                        await deletePenerima(penerima.id);
                                        setState(() {
                                          filteredList.removeAt(index);
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data berhasil dihapus')));
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    child: Text('Edit', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                      onPressed: () {
                                      _showEditDialog(penerima, index);
                                    },                                    
                                  ),
                                ],
                              )
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
