class ValidasiPenerima {
  final int id;
  final String nik;
  final String nama;
  final String email;
  final String noTelpon;
  final String meja;
  final String barcode;
  final String status;

  ValidasiPenerima({
    required this.id,
    required this.nik,
    required this.nama,
    required this.email,
    required this.noTelpon,
    required this.meja,
    required this.barcode,
    required this.status,
  });

  factory ValidasiPenerima.fromJson(Map<String, dynamic> json) {
    return ValidasiPenerima(
      id: json['id'],
      nik: json['nik'],
      nama: json['nama'],
      email: json['email'],
      noTelpon: json['no_telpon'],
      meja: json['meja'],
      barcode: json['barcode'],
      status: json['status'],
    );
  }
}
