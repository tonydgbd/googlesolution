import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_solution/Models/user.dart';
import 'package:google_solution/constants/firebase_auth_conts.dart';
import 'package:google_solution/controllers/firestore_db.dart';

class MapView extends StatelessWidget {
  late GoogleMapController mapController;
  MapView({Key? key}) : super(key: key);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    const LatLng _center = const LatLng(45.521563, -122.677433);
    return Scaffold(
      body: SafeArea(
          child: CustomMap()),
    );
  }
}

// ProfileScreen
// DetailsScreen
class CustomMap extends StatelessWidget {
  const CustomMap({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
            return Stack(
              children:[
                GoogleMap(
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: const CameraPosition(target: const LatLng(12.4048557,-1.5778195)),
                  markers:{
                    Marker(markerId: MarkerId("fdjfh"),
                  position: LatLng(12.45255,-1.5545)
                  ),
                  },
                ),
              ],
            );
  }
  dynamic  getMarker() async {
    Set<Marker>  Markers ={};
    FirestoreDb.getLocations().then( (value) {
      if(value.length>0){
         value.forEach((element) {
        Markers.add(Marker(markerId: MarkerId(element['uid']),
        position: LatLng(element['location'][0],element['location'][1])
        ));
      });
      return Markers;
      }
    });
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
        const Center(
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 100, 181, 246),
            radius: 100,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 95,
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
    return SingleChildScrollView(
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
                        const Text(
                          "YOUR NAME",
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
    ));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  const Text(
                    "Your Name",
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
                        "Your Location",
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
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.person, size: 20, color: Colors.grey),
                      hintText: "Your Name",
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
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.remove_red_eye,
                          size: 20, color: Colors.grey),
                      hintText: "Your Password",
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
                  child: const TextField(
                    decoration: InputDecoration(
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
                  child: const TextField(
                    decoration: InputDecoration(
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
                  child: Text(
                    "Add Your Service",
                    style: TextStyle(
                        color: Colors.blue[300],
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: Get.width,
                  height: 50,
                  color: Colors.blue[300],
                  child: Center(
                      child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
                )
              ],
            ),
          ),
        ],
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
    return Container(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
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
                    child: Image(image: NetworkImage(
                      "  ${auth.currentUser!.photoURL}"
                      ),
                    ),
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
                        const Text(
                          "Your Name",
                          style: TextStyle(fontSize: 30, color: Colors.grey),
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
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
              height: 50,
            ),
            Container(
              width: Get.width,
              height: Get.height * 0.6,
              //color: Color.fromARGB(255, 255, 255, 255),
              child: StreamBuilder<List<Category>>(
                  stream: FirestoreDb.getCategory(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List? catgorylist = snapshot.data;
                      return GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        children: catgorylist!.map(
                          (e) {
                            // print(e);
                            return ChoiceChip(
                              label: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    e.label,
                                    style: TextStyle(color: Colors.white),
                                  )),
                              selected: e.selected,
                              disabledColor: Colors.grey,
                              onSelected: (bool value) async{
                                print("tgdg");
                                print(e.documentId);
                                FirestoreDb.updateStatus(value,e.documentId);
                              },
                              selectedColor: Colors.blue[300],
                            );
                          },
                        ).toList(),
                      );
                    }
                    return Container(
                      width: Get.width,
              height: Get.height * 0.6,
                      child: Center(child: CircularProgressIndicator(value: 50,)));
                  }),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              width: Get.width,
              child: InkWell(
                onTap: (() {
                  
                }),
                child: Container(
                    color: Colors.blue[300],
                    height: Get.height * 0.10,
                    width: Get.width,
                    child: Center(
                        child: const Text(
                      "REGISTER",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))),
              ),
            ))
          ],
        ));
  }
}
