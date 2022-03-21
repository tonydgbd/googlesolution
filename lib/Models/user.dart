import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
part 'user.g.dart';
@JsonSerializable()
class Category {
  String? documentId;
  late String label;
  late bool selected;

  Category({
    required this.label,
    required this.selected,
//     required this.createdOn,
  });

  Category.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    label = documentSnapshot["label"];
    selected = documentSnapshot["selected"];
  }

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        label: json["label"],
        selected: json["selected"],
    );

    Map<String, dynamic> toMap() => {
        "label": label,
        "selected": selected,
    };
}
@Collection<Category>('categories')
final CategoriesRef = CategoryCollectionReference();
@JsonSerializable()
class User {
  String? documentId;
    late String? uid;
    late String? telephone;
    List<dynamic>? categories;
    Map<String, double?> ? Location;
    User({
        this.uid,
        this.telephone,
        this.categories,
        this.Location,
    });
    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        uid: json["uid"],
        telephone: json["telephone"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "telephone": telephone,
        "categories": List<dynamic>.from(categories!.map((x) => x)),
    };
    User.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot["uid"];
    documentId = documentSnapshot.id;
    telephone = documentSnapshot["telephone"];
    categories = documentSnapshot["categories"];
  }
}
@Collection<User>('users')
final usersRef = UserCollectionReference();