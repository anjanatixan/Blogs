// To parse this JSON data, do
//
//     final newsBlogsModel = newsBlogsModelFromJson(jsonString);

import 'dart:convert';

NewsBlogsModel newsBlogsModelFromJson(String str) => NewsBlogsModel.fromJson(json.decode(str));

String newsBlogsModelToJson(NewsBlogsModel data) => json.encode(data.toJson());

class NewsBlogsModel {
    bool status;
    List<BlogsCategory> blogsCategory;

    NewsBlogsModel({
        required this.status,
        required this.blogsCategory,
    });

    factory NewsBlogsModel.fromJson(Map<String, dynamic> json) => NewsBlogsModel(
        status: json["status"],
        blogsCategory: List<BlogsCategory>.from(json["blogs_category"].map((x) => BlogsCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "blogs_category": List<dynamic>.from(blogsCategory.map((x) => x.toJson())),
    };
}

class BlogsCategory {
    int id;
    String name;

    BlogsCategory({
        required this.id,
        required this.name,
    });

    factory BlogsCategory.fromJson(Map<String, dynamic> json) => BlogsCategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
