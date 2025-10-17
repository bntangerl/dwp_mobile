class Jurusan {
  final int id;
  final String namaJurusan;

  Jurusan({required this.id, required this.namaJurusan});

  factory Jurusan.fromJson(Map<String, dynamic> json) {
    return Jurusan(
      id: json['id'],
      namaJurusan: json['nama_jurusan'],
    );
  }

  @override
  String toString() => namaJurusan; 
}
