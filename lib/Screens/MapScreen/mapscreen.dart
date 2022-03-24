import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_solution/Models/user.dart';
import 'package:google_solution/components/popups.dart';
import 'package:google_solution/components/rounded_input_field.dart';
import 'package:google_solution/constants.dart';
import 'package:google_solution/constants/firebase_auth_conts.dart';
import 'package:google_solution/controllers/Map_search_Controller.dart';
import 'package:google_solution/controllers/firestore_db.dart';
import 'package:google_solution/components/modal_trigger.dart';

class MapView extends StatelessWidget {
  late GoogleMapController mapController;
  MapView({Key? key}) : super(key: key);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // const LatLng _center = const LatLng(45.521563, -122.677433);
    return Scaffold(
      body: SafeArea(
          child: auth.currentUser!.displayName == null ||
                  auth.currentUser!.phoneNumber == null
              ? ProfileScreen()
              : CustomMap()),
    );
  }
}

// ProfileScreen
// DetailsScreen
class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  // List<Map<String, dynamic>> markers = MapController.instance.markers;

  // List<String> labeltosearch = RxList([]);
              TextEditingController txtcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //         FutureBuilder(
          // future: getMarker(),
          // builder: (context, snapshot) {
          //   if(snapshot.hasData){
          //   markers = snapshot.data as List<Map<String, dynamic>>;
          // Set<Marker> Markers =  markers.map((e){
          //                           return Marker(
          //                             zIndex: 5,
          //                             markerId: MarkerId(e['uid']),
          //                       position: LatLng(e['location']['latitude'],e['location']['longitude']),
          //                       onTap: (){
          //                         _showModalBottomSheet(context,e['uid']);
          //                       }
          //                       );
          //                     }).toSet();
          // return
          GetBuilder<MapController>(
            init: MapController(context: context),
            initState: (_) {},
            builder: (controller) {
              return GoogleMap(
                markers: controller.marks
                ,
                onMapCreated: ((controller) => {}),
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: const CameraPosition(
                    target: const LatLng(12.4048557, -1.5778195), zoom: 9),
              );
            },
          ),
          // }
          // else{
          //   return const CircularProgressIndicator();
          // }
          // },),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              width: Get.width * 0.9,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.all(0),
                        color: Colors.white,
                        child: Center(
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "",
                                    content: const HamburgerMenupopup());
                              },
                              icon: Icon(
                                Icons.menu_rounded,
                                size: 20,
                              )),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 100, 181, 246),
                        radius: 25,
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "${auth.currentUser!.photoURL == null ? null : auth.currentUser!.photoURL}"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // margin: EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        width: Get.width * 0.7,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: txtcontroller,
                          // onEditingComplete: ,
                          onEditingComplete: () async{
                                  String val =txtcontroller.text;
                                         FirestoreDb.getLocationsfiltersearch(val)
                                            .then((value){
                                              print("###############################################Filter request result ${value}");
                                          MapController.instance.updateMarker(value);
                                          Get.forceAppUpdate();
                                          Get.snackbar("Work Force filter", "The work force List has been filtered");
                                        });
                                      },
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            hintText: "Find work easly",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          width: 35,
                          height: 30,
                          padding: EdgeInsets.all(0),
                          color: Colors.white,
                          child: Center(
                            child: IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () async {
                                  List<String> categories = [];
                                  await FirestoreDb.getCategory().then((value) {
                                    value.forEach((element) {
                                      categories.add(element['label']);
                                    });
                                  });

                                  Get.defaultDialog(
                                  
                                    title: "",
                                      content: FilterPopUp(
                                    categories: categories,
                                  )
                                  ,
                                  confirm: GestureDetector(
              onTap: () async{
                await FirestoreDb.getLocationsfilter(
                        MapController.instance.labeltosearch)
                    .then((value){
                      print("###############################################Filter request result ${value}");
                  MapController.instance.updateMarker(value);
                  Get.forceAppUpdate();
                  Get.snackbar("Work Force filter", "The work force List has been filtered");
                  Navigator.pop(context);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: const BorderRadius.all(Radius.circular(25))
                ),
                width: Get.width,
                height: 50,
                child: const Center(child: Text("Search")),
              ),
            ));
                                },
                                icon: Icon(
                                  Icons.filter_list,
                                  size: 20,
                                  color: Colors.blue[300],
                                )),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getMarker() async {
    List<Map<String, dynamic>> Markers = [];
    print("ger marker function vgfykhvghc");
    FirestoreDb.getLocations().then((value) {
      value!.forEach((element) {
        Markers.add(element);
      });
    });
    print(Markers);
    return Markers;
  }
}

class ProfileHead extends StatelessWidget {
  ProfileHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Color.fromARGB(255, 100, 181, 246),
                )
              ]),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 100, 181, 246),
            radius: 100,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 95,
              backgroundImage: auth.currentUser!.photoURL != null
                  ? NetworkImage("${auth.currentUser!.photoURL}")
                  : null,
            ),
          ),
        )
      ],
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          ProfileHead(),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Card(
              elevation: 5,
              child: Container(
                  padding: EdgeInsets.all(20),
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(0, 0, 0, 0),
                            offset: Offset(2, 5),
                            blurRadius: 1,
                            spreadRadius: 5),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            "${auth.currentUser!.displayName}",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_android,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          const Text(
                            "+226 70 70 70 70",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          const Text(
                            "Email@domain.com",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onPressed: () => {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onPressed: () => {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onPressed: () => {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onPressed: () => {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.star_half,
                              color: Colors.amber,
                            ),
                            onPressed: () => {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: Get.width,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "Book Now",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                      )
                    ],
                  )),
            ),
          )
        ],
      )),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(
        text: auth.currentUser!.displayName != null
            ? auth.currentUser!.displayName
            : null);
    TextEditingController phoneController = TextEditingController(
        text: auth.currentUser!.phoneNumber != null
            ? auth.currentUser!.phoneNumber
            : null);
    TextEditingController emailController = TextEditingController(
        text: auth.currentUser!.email != null ? auth.currentUser!.email : "");

    Map<String, dynamic>? userprofile = {};
    FirestoreDb.getUserProfile(auth.currentUser!.uid).then((value) {
      userprofile = value;
      print("user profile data ${userprofile}");
      nameController.text = userprofile!['name'];
      phoneController.text = userprofile!['telephone'];
    });

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        controller: ScrollController(),
        child: Column(
          children: [
            ProfileHead(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "${auth.currentUser!.displayName}",
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.location_on,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Location",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.person, size: 20, color: Colors.grey),
                        hintText: "Your name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone_android,
                            size: 20, color: Colors.grey),
                        hintText: "Your Phone Number",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,
                            size: 20, color: Colors.grey),
                        hintText: "Your Mail",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(ChipList());
                      },
                      child: Text(
                        "Add Your Service",
                        style: TextStyle(
                            color: Colors.blue[300],
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      print(phoneController.value.text);
                      FirestoreDb.UpdateUserProfil(
                          phoneController.value.text, nameController.text);
                      // auth.currentUser!.linkWithPopup()
                      Get.snackbar(
                        "Profile Updated",
                        "Your profil informations updated",
                        icon: Icon(Icons.person, color: Colors.white),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color.fromARGB(255, 73, 170, 214),
                        borderRadius: 20,
                        margin: EdgeInsets.all(15),
                        colorText: Colors.white,
                        duration: Duration(seconds: 4),
                        isDismissible: true,
                        forwardAnimationCurve: Curves.easeOutBack,
                      );
                      Get.to(CustomMap());
                    },
                    child: Container(
                      width: Get.width,
                      height: 50,
                      color: Colors.blue[300],
                      child: Center(
                          child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChipList extends StatefulWidget {
  const ChipList({Key? key}) : super(key: key);

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  // bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 100, 181, 246),
                      radius: 35,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        backgroundImage: auth.currentUser!.photoURL != null
                            ? NetworkImage("${auth.currentUser!.photoURL}")
                            : null,
                        radius: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${auth.currentUser!.displayName == null ? "NoUserName " : auth.currentUser!.displayName}",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.grey),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Your Location",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.6,
                  //color: Color.fromARGB(255, 255, 255, 255),
                  child: FutureBuilder(
                      future: getUserCategorie(),
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        if (snapshot.hasData) {
                          List<Map<String, dynamic>> Categories =
                              snapshot.data as List<Map<String, dynamic>>;
                          // print(Categories);
                          return GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            children: Categories.map(
                              (e) {
                                // print(e);
                                return ChoiceChip(
                                  label: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Text(
                                        e['label'],
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  selected: e['selected'],
                                  disabledColor: Colors.grey,
                                  onSelected: (bool value) async {
                                    await update(value, e['label']);
                                  },
                                  selectedColor: Colors.blue[300],
                                );
                              },
                            ).toList(),
                          );
                        }
                        print(snapshot.error);
                        return Container(
                            width: Get.width,
                            height: Get.height * 0.6,
                            child: const Center(
                                child: CircularProgressIndicator(
                              value: 60,
                              color: Colors.redAccent,
                            )));
                      }),
                ),
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                  width: Get.width,
                  child: InkWell(
                    onTap: (() {}),
                    child: Container(
                        color: Colors.blue[300],
                        height: Get.height * 0.10,
                        width: Get.width,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(CustomMap());
                          },
                          child: const Center(
                              child: Text(
                            "REGISTER",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          )),
                        )),
                  ),
                ))
              ],
            )));
  }

  Future update(bool value, String label) async {
    if (value) {
      FirestoreDb.addUSerCategorie(label);
    } else {
      FirestoreDb.DeleteUSerCategorie(label);
    }
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> getUserCategorie() async {
    List<Map<String, dynamic>> generalcategories = [];
    await FirestoreDb.getCategory().then((value) {
      generalcategories = value;
    });
    print("after retrieve catgory list ${generalcategories}");
    await FirestoreDb.getUserCategories().then((value) {
      print(
          "###################################start filtering #################################");
      generalcategories.forEach((e) {
        print(
            "###################################start MApping#################################");
        print(" category element ${e}");
        if (value.contains(e['label'])) {
          e['selected'] = true;
        } else {
          e['selected'] = false;
        }
      });
    });
    // print("general catgeorie ${generalcategories}");
    return generalcategories;
  }
}

