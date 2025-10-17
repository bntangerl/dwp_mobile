class User {
  final int? id;
  final String email;
  final String? name;
  final String? token;

  User({
    this.id,
    required this.email,
    this.name,
    this.token,
  });

  // Factory method untuk membuat User dari JSON (map)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      token: json['token'],
    );
  }

  // Method untuk mengubah User jadi JSON (map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
    };
  }
}
