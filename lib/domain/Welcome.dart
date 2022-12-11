import 'Author.dart';
import 'Category.dart';

class Welcome {
  List<Welcome> welcomes = [];

  Welcome({
    required this.id,
    required this.author,
    required this.category,
    required this.tags,
    required this.modifiedAt,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.content,
    required this.image,
    required this.viewsCount,
    required this.isFeatured,
  });

  int id;
  Author author;
  Category category;
  List<String> tags;
  DateTime modifiedAt;
  DateTime createdAt;
  String title;
  String description;
  String content;
  String image;
  int viewsCount;
  bool isFeatured;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["id"],
    author: Author.fromJson(json["author"]),
    category: Category.fromJson(json["category"]),
    tags: List<String>.from(json["tags"].map((x) => x)),
    modifiedAt: DateTime.parse(json["modified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    title: json["title"],
    description: json["description"],
    content: json["content"],
    image: json["image"],
    viewsCount: json["views_count"],
    isFeatured: json["is_featured"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author.toJson(),
    "category": category.toJson(),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "modified_at": modifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "title": title,
    "description": description,
    "content": content,
    "image": image,
    "views_count": viewsCount,
    "is_featured": isFeatured,
  };
}

class Welcomes {
  List<Welcome> welcomes = [];

  Welcomes({required this.welcomes});

  Welcomes.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      welcomes = <Welcome>[];
      json['results'].forEach((v) {
        welcomes.add(Welcome.fromJson(v));
      });
    }
  }
}