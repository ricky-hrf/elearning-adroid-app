class User {
  final int id;
  final String email;
  final String? nama;
  final String? role;

  const User({required this.id, required this.email, this.nama, this.role});

  factory User.fromJson(Map<String, dynamic> j) => User(
    id: (j['id'] as num).toInt(),
    email: j['email'] as String,
    nama: j['nama'] as String?,
    role: j['role'] as String?,
  );
}