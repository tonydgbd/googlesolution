import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_solution/Screens/Login/login_screen.dart';
import 'package:google_solution/Screens/MapScreen/mapscreen.dart';
import 'package:google_solution/Screens/Signup/signup_screen.dart';
import 'package:google_solution/Screens/Welcome/welcome_screen.dart';
import 'package:google_solution/constants/firebase_auth_conts.dart';
import 'package:google_solution/Models/user.dart' as model ;
import 'package:google_solution/controllers/firestore_db.dart';
import 'package:location/location.dart';
class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance. 
    // Since we have to use that many times I just made a constant file and declared there
    
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() =>  WelcomeScreen());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => MapView());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() =>  WelcomeScreen());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => MapView());
    }
  }

  void signInWithGoogle() async {
    try {
      print("debut");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("erreur niveau 1");
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      print("erreur niveau 2");

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print(credential);
              print("erreur niveau 3");
        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print("erreur ici "+onErr));
      print("erreur niveau 4");
       createProfile(auth)   ;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
}
// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);

//   // Once signed in, return the UserCredential
//   return await auth
//             .signInWithCredential(facebookAuthCredential)
//             .catchError((onErr) => print("erreur ici "+onErr));
// }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);   
          createProfile(auth)   ;
    } catch (firebaseAuthException) {
      Get.snackbar(
        "Error trying to register",
        firebaseAuthException.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException )  {
      Get.snackbar(
        "Error trying to connect",
        firebaseAuthException.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    await auth.signOut();
  }
  void createProfile(FirebaseAuth auth){
  Location().getLocation().then((LocationData) {
  FirestoreDb.CreateUserProfil({
        "latitude":LocationData.latitude,
        "longitude":LocationData.longitude,
        "name":auth.currentUser!.displayName,
        "categories":FieldValue.arrayUnion([]),
  });
});
  }
  }

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  model.UserCollectionReference profile = model.usersRef;
  // List<String> userProfil = model.usersRef.whereUid(auth.currentUser!.uid).get().then((value) {
  //   return value.docs;
  // })
}