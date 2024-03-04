// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) => DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
    bool status;
    Blog blog;

    DetailsModel({
        required this.status,
        required this.blog,
    });

    factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        status: json["status"],
        blog: Blog.fromJson(json["blog"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "blog": blog.toJson(),
    };
}

class Blog {
    int id;
    DateTime createdAt;
    String image;
    String title;
    String content;
    int category;

    Blog({
        required this.id,
        required this.createdAt,
        required this.image,
        required this.title,
        required this.content,
        required this.category,
    });

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        image: json["image"],
        title: json["title"],
        content: json["content"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "image": image,
        "title": title,
        "content": content,
        "category": category,
    };
}
