import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  late GoogleMapController mapController;
   MapView({ Key? key}) : super(key: key);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
  final LatLng _center = const LatLng(45.521563, -122.677433);
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
      ),
    );
  }
}