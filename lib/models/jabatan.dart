class Jabatan {
  final int id;
  final String jabatan;

  Jabatan({required this.id, required this.jabatan});

  factory Jabatan.fromJson(Map<String, dynamic> json) {
    return Jabatan(
      id: json['id'],
      jabatan: json['jabatan'],
    );
  }

  @override
  String toString() => jabatan;
}
