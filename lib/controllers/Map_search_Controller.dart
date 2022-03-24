import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_solution/controllers/firestore_db.dart';

class MapController extends GetxController{
   BuildContext? context;
  MapController({ BuildContext? context});
  static MapController instance = Get.find();
 List<Map<String, dynamic>> markers= RxList([]);
    List <String> labeltosearch = RxList([]);
    Set<Marker> marks =RxSet({});
    void onReady() async{
    super.onReady();
   getMarker().then((value) {
    updateMarker(value);
  });

  marks= markers.map((e){
                              return Marker(
                                zIndex: 5,
                                markerId: MarkerId(e['uid']),
                          position: LatLng(e['location']['latitude'],e['location']['longitude']),
                          onTap: (){
                            Get.bottomSheet(
                              Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        height: 350,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: FutureBuilder(
            future: FirestoreDb.getUserProfile(e['uid']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data as Map<String, dynamic>;
                return Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          width: Get.width,
                          child: Image.asset(
                            'assets/images/work.jpg',
                            height: 150,
                          ),
                        ),
                        const Positioned(
                          top: 5,
                          right: 5,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 28.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        "${data['categories'].join(" ")}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star_half,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                      ],
                    ),
                    Container(
                      height: 60.0,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified_user_rounded,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                  Text(
                                    "${data['name']}",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                  Text(
                                    "+226 ${data['telephone']}",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Book",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Profile",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ],
                    ))
                  ],
                );
              } else {
                return const CircularProgressIndicator(
                  value: 50,
                  color: Colors.red,
                );
              }
            }),
      )
                            );
                          }
                          );
                        }).toSet();
  }
  Future<List<Map<String, dynamic>>> getMarker() async {
    // List<Map<String, dynamic>>  Markers =[];
    await FirestoreDb.getLocations().then((value) {
      value!.forEach((element) {
        // print("########################################3element ${element}");
        markers.add(element);
    });
      });
      // print("MArker after fetch ${markers}");
      return markers;

  }
  updateLabel(String label,bool value){
    value ? labeltosearch.add(label):labeltosearch.remove(label);
    update();
  }
  updateMarker(markerList){
    markers = markerList;
    updateMarks(markers);
    print("#################################################################function  marker info has been call");

    print(" marker info ${markers}");
    update();
  }
  updateMarks(markersList){
    print("#################################################################function  marker builder has been call");

     marks.clear();
    marks= markers.map((e){
                              return Marker(
                                zIndex: 5,
                                markerId: MarkerId(e['uid']),
                          position: LatLng(e['location']['latitude'],e['location']['longitude']),
                          onTap: (){
                            Get.bottomSheet(Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        height: 350,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: FutureBuilder(
            future: FirestoreDb.getUserProfile(e['uid']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data as Map<String, dynamic>;
                return Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          width: Get.width,
                          child: Image.asset(
                            'assets/images/work.jpg',
                            height: 150,
                          ),
                        ),
                        const Positioned(
                          top: 5,
                          right: 5,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 28.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        "${data['categories'].join(" ")}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star_half,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                      ],
                    ),
                    Container(
                      height: 60.0,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified_user_rounded,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                  Text(
                                    "${data['name']}",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                  Text(
                                    "+226 ${data['telephone']}",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Book",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Profile",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ],
                    ))
                  ],
                );
              } else {
                return const CircularProgressIndicator(
                  value: 50,
                  color: Colors.red,
                );
              }
            }),
      ));
                          }
                          );
                        }).toSet();
    update();
  }

_showModalBottomSheet(context, String uid){
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      double width = Get.width;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        height: 350,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: FutureBuilder(
            future: FirestoreDb.getUserProfile(uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data as Map<String, dynamic>;
                return Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          width: width,
                          child: Image.asset(
                            'assets/images/work.jpg',
                            height: 150,
                          ),
                        ),
                        const Positioned(
                          top: 5,
                          right: 5,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 28.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        "${data['categories'].join(" ")}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        Icon(
                          Icons.star_half,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                      ],
                    ),
                    Container(
                      height: 60.0,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified_user_rounded,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                  Text(
                                    "${data['name']}",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                  Text(
                                    "+226 ${data['telephone']}",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Book",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Profile",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ],
                    ))
                  ],
                );
              } else {
                return const CircularProgressIndicator(
                  value: 50,
                  color: Colors.red,
                );
              }
            }),
      );
    },
  );
}
}