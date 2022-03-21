import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
// part 'Todo.g.dart';

@JsonSerializable()
class User {
  String? documentId;
    late String? uid;
    late String telephone;
    List<dynamic>? categories;
    Map<String, double> ? Location;
    User({
        this.uid,
        required this.telephone,
        this.categories,
    });
  //   factory User.fromJson(String str) => User.fromMap(json.decode(str));

  //   String toJson() => json.encode(toMap());

  //   factory User.fromMap(Map<String, dynamic> json) => User(
  //       uid: json["uid"],
  //       telephone: json["telephone"],
  //       categories: List<dynamic>.from(json["categories"].map((x) => x)),
  //   );

  //   Map<String, dynamic> toMap() => {
  //       "uid": uid,
  //       "telephone": telephone,
  //       "categories": List<dynamic>.from(categories!.map((x) => x)),
  //   };
  //   User.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
  //   uid = documentSnapshot["uid"];
  //   documentId = documentSnapshot.id;
  //   telephone = documentSnapshot["telephone"];
  //   categories = documentSnapshot["categories"];
  // }
}
// @Collection<User>('users')
// final usersRef = UserCollectionReference();