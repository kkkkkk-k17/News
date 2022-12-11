class Category {
  Category({
    required this.id,
    required this.modifiedAt,
    required this.createdAt,
    required this.title,
  });

  int id;
  DateTime modifiedAt;
  DateTime createdAt;
  String title;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    modifiedAt: DateTime.parse(json["modified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "modified_at": modifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "title": title,
  };
}
