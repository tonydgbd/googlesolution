import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_solution/Screens/Welcome/welcome_screen.dart';
import 'package:google_solution/constants/firebase_auth_conts.dart';
import 'package:google_solution/controllers/Map_search_Controller.dart';
import 'package:google_solution/controllers/auth_controler.dart';
import 'package:google_solution/controllers/firestore_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
    Get.put(FirestoreDb());
    Get.put(MapController());

  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body:  SafeArea(
          child: Center(
        child: CircularProgressIndicator(),
      ))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WelcomeScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
