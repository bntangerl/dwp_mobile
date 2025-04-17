import 'dart:ffi';

class Makanan {
  String gambar_makanan;
  String nama_makanan;
  String harga_makanan;

  Makanan({
    required this.gambar_makanan,
    required this.nama_makanan,
    required this.harga_makanan,
  });
}

List<Makanan> daftarMakanan = [
    Makanan(gambar_makanan: 'assets/makanan/nasi_ayam.png', nama_makanan: 'Nasi Ayam', harga_makanan: 'Rp 10.000'),
    Makanan(gambar_makanan: 'assets/makanan/nasi_padang.png', nama_makanan: 'Nasi Padang', harga_makanan: 'Rp 12.000'),
    Makanan(gambar_makanan: 'assets/makanan/nasi_rawon.png', nama_makanan: 'Nasi Rawon', harga_makanan: 'Rp 15.000'),
    Makanan(gambar_makanan: 'assets/makanan/sate_ayam.png', nama_makanan: 'Sate Ayam', harga_makanan: 'Rp. 10.000'),
    Makanan(gambar_makanan: 'assets/makanan/seafood.png', nama_makanan: 'Seafood', harga_makanan: 'Rp. 50.000'),
    Makanan(gambar_makanan: 'assets/makanan/soto_ayam.png', nama_makanan: 'Soto Ayam', harga_makanan: 'Rp. 17.000'),
  ];

