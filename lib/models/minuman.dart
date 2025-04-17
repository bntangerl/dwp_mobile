class Minuman {
  String nama_minuman;
  String gambar_minuman;
  String harga_minuman;


  Minuman({
    required this.nama_minuman,
    required this.gambar_minuman,
    required this.harga_minuman,
  });
}

List <Minuman> daftarMinuman = [
  Minuman(nama_minuman: 'Es Teh', gambar_minuman: 'es_teh.png', harga_minuman: 'Rp 5.000'),
  Minuman(nama_minuman: 'Teh Hangat', gambar_minuman: 'teh_hangat.png', harga_minuman: 'Rp 5.000'),
  Minuman(nama_minuman: 'Es Teh', gambar_minuman: 'es_teh.png', harga_minuman: 'Rp 10.000'),
  Minuman(nama_minuman: 'Es Teh', gambar_minuman: 'es_teh.png', harga_minuman: 'Rp 5.000'),
  Minuman(nama_minuman: 'Es Teh', gambar_minuman: 'es_teh.png', harga_minuman: 'Rp 6.000'),
  Minuman(nama_minuman: 'Es Teh', gambar_minuman: 'es_teh.png', harga_minuman: 'Rp 7.000')
];