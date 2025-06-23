class RumahSakit {
  int? id;
  String nama;
  String alamat;
  String telepon;
  String tipe;
  double latitude;
  double longitude;
  DateTime? createdAt;
  DateTime? updatedAt;

  RumahSakit({
    this.id,
    required this.nama,
    required this.alamat,
    required this.telepon,
    required this.tipe,
    required this.latitude,
    required this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory RumahSakit.fromJson(Map<String, dynamic> json) => RumahSakit(
    id: json["id"],
    nama: json["nama"],
    alamat: json["alamat"],
    telepon: json["telepon"],
    tipe: json["tipe"],
    latitude: (json["latitude"] as num).toDouble(),
    longitude: (json["longitude"] as num).toDouble(),
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : null,
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "alamat": alamat,
    "telepon": telepon,
    "tipe": tipe,
    "latitude": latitude,
    "longitude": longitude,
  };
}
