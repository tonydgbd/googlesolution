import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_solution/controllers/Map_search_Controller.dart';
class Map extends StatelessWidget {
  const Map({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      initState: (_) {},
      builder: (_) {
        return GoogleMap(
              markers:MapController.instance.marks,
            onMapCreated: ((controller) => {
    
            }),
                myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: const LatLng(12.4048557,-1.5778195),zoom: 9),
                      );
       } );
  }
}