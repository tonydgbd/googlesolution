import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? documentId;
  late String content;
  late Timestamp createdOn;
  late bool isDone;

  TodoModel({
    required this.content,
    required this.isDone,
//     required this.createdOn,
  });

  TodoModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    content = documentSnapshot["content"];
    createdOn = documentSnapshot["createdOn"];
    isDone = documentSnapshot["isDone"];
  }
}
class Utilisateur {
  String ? Documentid;
  String ?uid;
  late String firstName;
  late String lastName;
  late String telephone;
  late List location;
  Utilisateur({required this.firstName,required this.lastName,required this.telephone,this.location:const [12.00,0.22]});
  Utilisateur.fromDocumentSnapshot({required DocumentSnapshot doc}){
    Documentid =doc.id;
    uid = doc['uid'];
    firstName = doc['nom'];
    lastName =doc['prenom'];
  }
}