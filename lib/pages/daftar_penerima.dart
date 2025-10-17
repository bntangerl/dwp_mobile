import 'dart:convert';
import 'package:belajar_flutter/drawer/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/models/daftar_penerima.dart';
import 'package:belajar_flutter/models/jurusan.dart';
import 'package:belajar_flutter/models/jabatan.dart';
import 'package:email_validator/email_validator.dart';


class DaftarPenerimaPage extends StatefulWidget {
  @override
  _DaftarPenerimaPageState createState() => _DaftarPenerimaPageState();
}

class _DaftarPenerimaPageState extends State<DaftarPenerimaPage> {

  final _formKey = GlobalKey<FormState>();

  List<Penerima> penerimaList = [];
  List<Penerima> filteredList = [];

  List<Jurusan> daftarJurusan = [];
  List<Jabatan> daftarJabatan = [];
  
  Jurusan? selectedJurusanAdd;
  Jabatan? selectedJabatanAdd;

  Jurusan? selectedJurusanEdit;
  Jabatan? selectedJabatanEdit;

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
    fetchJurusan();
    fetchJabatan();
  }

  Future<void> fetchPenerima() async {
    final response = await http.get(Uri.parse('https://bazardwp-polije.my.id/api/penerimas'));

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

  Future<void> fetchJurusan() async {
    final response = await http.get(Uri.parse('https://bazardwp-polije.my.id/api/jurusan'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        daftarJurusan = data.map((json) => Jurusan.fromJson(json)).toList();
      });

    } else {
      throw Exception('Gagal memuat jurusan');
    }
  }


  Future<void> fetchJabatan() async {
    final response = await http.get(Uri.parse('https://bazardwp-polije.my.id/api/jabatan'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      
      setState(() {
        daftarJabatan = jsonData.map((e) => Jabatan.fromJson(e)).toList();
      });

    } else {
      throw Exception('Gagal memuat data jabatan');
    }
  }

  Future<void> deletePenerima(int id) async {
    final url = Uri.parse('https://bazardwp-polije.my.id/api/penerimas/$id'); // Ganti dengan URL server-mu

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Data berhasil dihapus');
    } else {
      print('Gagal menghapus data: ${response.body}');
    }
  }

  void addFormDialog(BuildContext context) async {
  // Clear dulu supaya form kosong untuk tambah data baru
    namaController.clear();
    nikController.clear();
    emailController.clear();
    noTelponController.clear();
    namaJurusanController.clear();
    selectedJurusanAdd = null;
    selectedJabatanAdd = null;

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah Data Penerima', style: TextStyle(fontFamily: 'Poppins', fontSize: 18)),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    } else if (!RegExp(r'^[a-zA-Z.,\s]+$').hasMatch(value)) {
                      return 'Nama tidak boleh mengandung angka';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nikController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'NIK', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  validator: (value) => value == null || value.isEmpty ? 'NIK tidak boleh kosong' : null,
                ),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Format email tidak valid';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: noTelponController,
                  decoration: InputDecoration(labelText: 'No Telepon', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No Telepon tidak boleh kosong';
                    }
                    final phoneRegex = RegExp(r'^[0-9]+$');
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Nomor telepon harus berupa angka';
                    }
                  },
                ),
                DropdownButtonFormField<Jurusan>(
                  decoration: InputDecoration(labelText: 'Nama Jurusan', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  value: selectedJurusanAdd,
                  onChanged: (value) {
                    setState(() {
                      selectedJurusanAdd = value;
                    });
                  },
                  validator: (value) => value == null ? 'Pilih jurusan terlebih dahulu' : null,
                  items: daftarJurusan.map((jurusan) {
                    return DropdownMenuItem(
                      value: jurusan,
                      child: Text(jurusan.namaJurusan),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField<Jabatan>(
                  decoration: InputDecoration(labelText: 'Jabatan', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  value: selectedJabatanAdd,
                  onChanged: (value) {
                    setState(() {
                      selectedJabatanAdd = value;
                    });
                  },
                  validator: (value) => value == null ? 'Pilih jabatan terlebih dahulu' : null,
                  items: daftarJabatan.map((jabatan) {
                    return DropdownMenuItem<Jabatan>(
                      value: jabatan,
                      child: Text(jabatan.jabatan),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal', style: TextStyle(fontFamily: 'Poppins')),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Penerima newPenerima = Penerima(
                  id: 0,
                  nik: nikController.text,
                  nama: namaController.text,
                  email: emailController.text,
                  noTelpon: noTelponController.text,
                  jurusanId: selectedJurusanAdd?.id ?? 0,
                  namaJurusan: selectedJurusanAdd?.namaJurusan ?? '',
                  jabatanId: selectedJabatanAdd?.id ?? 0,
                  jabatan: selectedJabatanAdd?.jabatan ?? '',
                );

                final response = await http.post(
                  Uri.parse('https://bazardwp-polije.my.id/api/penerimas'),
                  headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                  },
                  body: jsonEncode({
                    'nik': newPenerima.nik,
                    'nama': newPenerima.nama,
                    'email': newPenerima.email,
                    'no_telpon': newPenerima.noTelpon,
                    'jurusan_id': newPenerima.jurusanId,
                    'jabatan_id': newPenerima.jabatanId,
                  }),
                );

                if (response.statusCode == 201 || response.statusCode == 200) {
                  await fetchPenerima();
                  if (context.mounted) {
                    Navigator.of(context).pop(); // Tutup dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data berhasil ditambahkan'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } else if (response.statusCode == 422) {
                  final body = jsonDecode(response.body);
                  if (context.mounted) {
                    String errorMsg = '';
                    if (body['errors'] != null) {
                      body['errors'].forEach((key, value) {
                        errorMsg += '$key: ${value[0]}\n';
                      });
                    } else {
                      errorMsg = body['message'] ?? 'Terjadi kesalahan validasi.';
                    }

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Validasi Gagal'),
                        content: Text(errorMsg.trim()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal menambahkan data (${response.statusCode})'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              }
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
    
    Jurusan? selectedJurusanEdit = daftarJurusan.firstWhere(
      (j) => j.namaJurusan == penerima.namaJurusan,
      orElse: () => daftarJurusan.isNotEmpty ? daftarJurusan.first : Jurusan(id: 0, namaJurusan: 'Tidak ada'),
    );

    Jabatan? selectedJabatanEdit = daftarJabatan.firstWhere(
      (j) => j.jabatan == penerima.jabatan,
      orElse: () => daftarJabatan.isNotEmpty ? daftarJabatan.first : Jabatan(id: 0, jabatan: 'Tidak ada'),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Data Penerima', style: TextStyle(fontFamily: 'Poppins')),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    } else if (!RegExp(r'^[a-zA-Z.,\s]+$').hasMatch(value)) {
                      return 'Nama tidak boleh mengandung angka';
                    }
                    return null;
                  },
                ),
                TextFormField(

                  // ADD DIALOG MEMILIKI VALIDATOR YANG SAMA DENGAN EDIT DIALOG
                  controller: nikController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'NIK', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  validator: (value) => value == null || value.isEmpty ? 'NIK tidak boleh kosong' : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) return 'Format email tidak valid';
                    return null;
                  },
                ),
                TextFormField(
                  controller: noTelponController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'No Telepon', labelStyle: TextStyle(fontFamily: 'Poppins')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No Telepon tidak boleh kosong';
                    }
                    final phoneRegex = RegExp(r'^[0-9]+$');
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Nomor telepon harus berupa angka';
                    }
                  },
                ),
                DropdownButtonFormField<Jurusan>(
                  value: selectedJurusanEdit,
                  items: daftarJurusan.map((jurusan) {
                    return DropdownMenuItem(
                      value: jurusan,
                      child: Text(jurusan.namaJurusan),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedJurusanEdit = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Jurusan'),
                  validator: (value) => value == null ? 'Pilih jurusan terlebih dahulu' : null,
                ),
                DropdownButtonFormField<Jabatan>(
                  value: selectedJabatanEdit,
                  items: daftarJabatan.map((jabatan) {
                    return DropdownMenuItem(
                      value: jabatan,
                      child: Text(jabatan.jabatan),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedJabatanEdit = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Jabatan'),
                  validator: (value) => value == null ? 'Pilih jabatan terlebih dahulu' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal', style: TextStyle(fontFamily: 'Poppins')),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Validasi berhasil
                Penerima newPenerima = Penerima(
                  id: penerima.id,
                  nik: nikController.text,
                  nama: namaController.text,
                  email: emailController.text,
                  noTelpon: noTelponController.text,
                  jurusanId: selectedJurusanEdit?.id ?? 0,
                  namaJurusan: selectedJurusanEdit?.namaJurusan ?? '',
                  jabatanId: selectedJabatanEdit?.id ?? 0,
                  jabatan: selectedJabatanEdit?.jabatan ?? '',
                );

                final response = await http.put(
                  Uri.parse('https://bazardwp-polije.my.id/api/penerimas/${newPenerima.id}'),
                  headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                  },
                  body: jsonEncode({
                    'nik': newPenerima.nik,
                    'nama': newPenerima.nama,
                    'email': newPenerima.email,
                    'no_telpon': newPenerima.noTelpon,
                    'jurusan_id': newPenerima.jurusanId,
                    'jabatan_id': newPenerima.jabatanId,
                  }),
                );

                if (response.statusCode == 200) {
                  await fetchPenerima();

                  if (context.mounted) {
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data berhasil diperbarui'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal mengupdate data'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              } else {
                // Validasi gagal, tidak kirim request
              }
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
                        hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
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
                    fetchJurusan();
                    fetchJabatan();
                    addFormDialog(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            // Daftar Penerima
              Expanded(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : filteredList.isEmpty
                          ? Center(
                              child: Text(
                                'Tidak ada data penerima',
                                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                              ),
                            )
                          : Container(
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
                                      Text("JABATAN    : ${penerima.jabatan}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                                      Text("UNIT/JURUSAN         : ${penerima.namaJurusan}", style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
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
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data berhasil dihapus'), backgroundColor: Colors.red));
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
                      ),
                  ],
                ),
              ),
            );
          }
        }
