class PengambilanBarang {
  final int id;  // tambahan id
  final String nik;
  final String nama;
  final String email;
  final String noTelpon;
  final String meja;
  final String barcode;
  final String statusPengambilan;

  PengambilanBarang({
    required this.id,       // wajib diisi
    required this.nik,
    required this.nama,
    required this.email,
    required this.noTelpon,
    required this.meja,
    required this.barcode,
    required this.statusPengambilan,
  });

  factory PengambilanBarang.fromJson(Map<String, dynamic> json) {
    return PengambilanBarang(
      id: json['id'], 
      nik: json['nik'],
      nama: json['nama'],
      email: json['email'],
      noTelpon: json['no_telpon'],
      meja: json['meja'],
      barcode: json['barcode'],
      statusPengambilan: json['status_pengambilan'],
    );
  }
}
