class Author {
  Author({
    required this.id,
    required this.modifiedAt,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  int id;
  DateTime modifiedAt;
  DateTime createdAt;
  String name;
  String avatar;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    modifiedAt: DateTime.parse(json["modified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "modified_at": modifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "name": name,
    "avatar": avatar,
  };
}