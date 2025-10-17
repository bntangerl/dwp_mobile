class Penerima {
  final int id;
  final String nik;
  final String nama;
  final String email;
  final String noTelpon;
  final int jurusanId;
  final String namaJurusan;
  final int jabatanId;
  final String jabatan;

  Penerima({
    required this.id,
    required this.nik,
    required this.nama,
    required this.email,
    required this.noTelpon,
    required this.jurusanId,
    required this.namaJurusan,
    required this.jabatanId,
    required this.jabatan,
  });

  factory Penerima.fromJson(Map<String, dynamic> json) {
    return Penerima(
      id: json['id'],
      nik: json['nik'],
      nama: json['nama'],
      email: json['email'],
      noTelpon: json['no_telpon'],
      jurusanId: json['jurusan_id'],
      namaJurusan: json['nama_jurusan'],
      jabatanId: json['jabatan_id'],
      jabatan: json['jabatan'],
    );
  }
}