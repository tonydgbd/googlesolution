import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_solution/Models/Todo_model.dart';
import 'package:google_solution/constants/firebase_auth_conts.dart';
import 'package:google_solution/Models/user.dart' as model;
import 'package:location/location.dart';

class FirestoreDb extends GetxController {
  static RxList<dynamic> categorylist =[].obs;
  static FirestoreDb instance = Get.find();
  //call this function and git it the model name and the model object to retrieve data list 
  static Future<List<Map<String,dynamic>>> getCategory() {
        List<Map<String,dynamic>> data = [];
    return firebaseFirestore
        .collection('Categories')
        .get()
        .then((query){
        for (var doc in query.docs) {
          final Modelinstace = doc.data();
          data.add(Modelinstace);
      }
      return data;
        });
  }
  static Future<List<dynamic>> getUserCategories() async{
    List<dynamic> data = [] ;
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value){
           Map<String,dynamic>?  userdoc = value.data();
           data = userdoc!['categories'];
           print("user data : ${userdoc['categories']}");

        });
        print("final user categories data ${data}");
        return data;
  }
   static Future<Map<String,dynamic>?> getUserProfile(String userUi) async{
    Map<String,dynamic>? data = {} ;
    await firebaseFirestore
        .collection('users')
        .doc(userUi)
        .get()
        .then((value){
          //  Map<String,dynamic>?  userdoc = value.data();
           data = value.data();
        });
        print("final user categories data ${data}");
        return data;
  }
   static Future<List<dynamic>>? getUserLocation() {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
          if (value.exists){
           Map<String, dynamic>?  userdoc = value.data();
           return userdoc!['location'];
          }else{
            return null;
          }
        });
  }
  static  Future<List<Map<String,dynamic>>?>  getLocations() async{
      List<Map<String,dynamic>> Locationdata = [];

   await firebaseFirestore.
    collection("users")
    .get()
    .then((value){
      value.docs.forEach((doc) { 
        Locationdata.add({
          'location':doc['location'],
          'uid':doc['uid']
        });
      });
    });
    print("see bellow the location from base function");
      print(Locationdata);

      return Locationdata;
  }
    static  Future<List<Map<String,dynamic>>?> getLocationsfilter(List<String> labels) async{
      List<Map<String,dynamic>> Locationdata = [];
   await firebaseFirestore.
    collection("users")
    .get()
    .then((value){
      value.docs.forEach((doc){
        // print("###################################3Categories to filter ${doc['categories']}");
        labels.forEach((element) {
           if(doc['categories'].contains(element)){
          print("Ca passsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
          Locationdata.add({
          'location':doc['location'],
          'uid':doc['uid']
        });
        }
        });
       
      });
    });
    print("see bellow the location from base function");
      print(Locationdata);

      return Locationdata;
  }
  static  Future<List<Map<String,dynamic>>?> getLocationsfiltersearch(String labels) async{
      List<Map<String,dynamic>> Locationdata = [];
   await firebaseFirestore.
    collection("users")
    .get()
    .then((value){
      value.docs.forEach((doc){
     
          if(doc['categories'].contains(labels)||doc['name'].contains(labels)){
          print("Ca passsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
          Locationdata.add({
          'location':doc['location'],
          'uid':doc['uid']
        });
          }
        });
       
      });
        print("REsearch data ${Locationdata}");
      return Locationdata;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>getCategoryStream() {
    return firebaseFirestore
        .collection('Categories')
        .snapshots();
  }

  static addUSerCategorie(String label) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(
    {
    "categories": FieldValue.arrayUnion([label])
}
    ).then((value){
      print("#########################sucesss###########################3");
    }).asStream() ;
  }
  static DeleteUSerCategorie(String label) async {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(
    {
    "categories": FieldValue.arrayRemove([label])
}
    ).then((value){
      print("#########################sucesss###########################3");
    }).asStream();
  }
    static CreateUserProfil(dynamic location) async {
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(
      {'uid':auth.currentUser!.uid,
        'telephone':auth.currentUser!.phoneNumber,
        'categories':FieldValue.arrayUnion([]),
        'location':location,
      },
      SetOptions(merge: true)
    );
  }
    static UpdateUserProfil(String tel,name) async {
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(
      {
        'telephone':tel,
        'name':name
      },
    );
  }
  static deleteTodo(String documentId) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .delete();
  }
}