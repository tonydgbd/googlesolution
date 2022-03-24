import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_solution/Screens/MapScreen/mapscreen.dart';
import 'package:google_solution/controllers/Map_search_Controller.dart';
import 'package:google_solution/controllers/firestore_db.dart';

class HamburgerMenupopup extends StatelessWidget {
  const HamburgerMenupopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(ChipList());
          },
          child: Column(
            children: [
              const Text(
                "ADD YOUR SERVICE",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                width: Get.width,
                height: 1,
                color: Colors.grey[600],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            const Text("ADMIN MODE"),
            Container(
              width: Get.width,
              height: 1,
              color: Colors.grey[600],
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            const Text(
              "NEED HELP",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              width: Get.width,
              height: 1,
              color: Colors.grey[600],
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            const Text(
              "ABOUT US",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              width: Get.width,
              height: 1,
              color: Colors.grey[600],
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            Get.to(ProfileScreen());
          },
          child: Column(
            children: [
              const Text(
                "MY ACCOUNT",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                width: Get.width,
                height: 1,
                color: Colors.grey[600],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FilterPopUp extends StatelessWidget {
  List<String> categories;
  FilterPopUp({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(context: context),
      initState: (_) {},
      builder: (controller){
        return Column(
          children: [
            Column(
                children: categories.map((element) {
              return Row(
                children: [
                  Checkbox(
                      value: MapController.instance.labeltosearch
                          .contains(element),
                      onChanged: (boolean) {
                        MapController.instance
                            .updateLabel(element, boolean as bool);
                      }),
                  Text(element),
                ],
              );
            }).toList()),
            const SizedBox(
              height: 15,
            ),
            
          ],
        );
      },
    );
  }
}
