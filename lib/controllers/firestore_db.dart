import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_solution/Models/Todo_model.dart';
import 'package:google_solution/constants/firebase_auth_conts.dart';
import 'package:google_solution/Models/user.dart' as model;
import 'package:location/location.dart';

class FirestoreDb extends GetxController {
  // Rx<Stream<List<Category>>> categorylist = getCategory().obs;
  static FirestoreDb instance = Get.find();
  // static addProfile(User user) async {
  //   await firebaseFirestore
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('profile')
  //       .add({
  //     'telephone': user.telephone,
  //     'category': user.categories,
  //   });
  // }
  // static AddUserCategory(String label, String uid) async {
  //   await firebaseFirestore
  //       .collection('users').
  //       doc(auth.currentUser!.uid)
  //       .collection('profile')
  //       .
  //         // .where('uid','==',auth.currentUser!.uid)
  //   );
  // }
//  static addCategory(Category cat) async {
//     await firebaseFirestore
//         .collection('users')
//         .doc(auth.currentUser!.uid)
//         .collection('todos')
//         .add({
//       'label': cat.label,
//       'selected': cat.selected,

//     });
//   }
  
  //call this function and git it the model name and the model object to retrieve data list 
  static Stream<List<model.Category>> getCategory() {
    return firebaseFirestore
        .collection('Categories')
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<model.Category> data = [];
      for (var doc in query.docs) {
        final Modelinstace =
            model.Category.fromDocumentSnapshot(documentSnapshot: doc);
        data.add(Modelinstace);
      }
      return data;
    });
  }
  static Future<List<String>>? getUserCategories() {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
          if (value.exists){
           Map<String, dynamic>?  userdoc = value.data();
           return userdoc!['categories'];
          }else{
            return [];
          }
        });
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
  static  dynamic getLocations(){
      List<Map<String,dynamic>> Locationdata = [];

    firebaseFirestore.
    collection("users")
    .get()
    .then((value){
      value.docs.forEach((doc) { 
        Locationdata.add({
          'location':doc['location'],
          'uid':doc['uid']
        });
      });
      return Locationdata;
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>getCategoryStream() {
    return firebaseFirestore
        .collection('Categories')
        .snapshots();
  }

  static updateStatus(bool isDone, documentId) async {
    await firebaseFirestore
        .collection('Categories')
        .doc(documentId)
        .update(
      {
        'selected': isDone,
      },
    );
  }
    static CreateUserProfil(dynamic location) async {
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(
      {'uid':auth.currentUser!.uid,
        'telephone':auth.currentUser!.phoneNumber,
        // 'categories':[],
        'location':location,
      },
      SetOptions(merge: true)
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