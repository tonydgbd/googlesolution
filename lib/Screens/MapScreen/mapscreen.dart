import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final width = Get.width;
    return Scaffold(
      body: SafeArea(
        // child: GoogleMap(
        //       onMapCreated: _onMapCreated,
        //       initialCameraPosition: CameraPosition(
        //         target: _center,
        //         zoom: 11.0,
        //       )
        child: ChipList()
            ),
      );
  }
}
class ProfileHead extends StatelessWidget {
  const ProfileHead({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:const [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Color.fromARGB(255, 100, 181, 246),
                      )
                  ]
                ),
        ),
              const SizedBox(height: 10,),
              const Center(
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 100, 181, 246),
                  radius: 100,
                  child: CircleAvatar(
                    backgroundColor:Colors.black54,
                    radius: 95,
                  ),
                  ),
              )
      ],
    );
  }
}
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: 
        Column(children: [
          ProfileHead()
          ,
          const SizedBox(height: 100,),
          Center(
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(20),
                width: Get.width *0.8,
                decoration:   BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(color: Color.fromARGB(0, 0, 0, 0)
                    ,
                    offset: Offset(2, 5)
                    ,blurRadius: 1,
                    spreadRadius: 5),
            
                  ]
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Row(
                    children: [
                      Icon(Icons.person,color: Colors.grey[600],),
                      const SizedBox(width: 25,),
                      const Text("YOUR NAME",style: TextStyle(fontSize: 20,color: Colors.grey),)
                    ],
                  ),
                  const SizedBox(height:15),
                  Row(
                    children: [
                      Icon(Icons.phone_android,color: Colors.grey[600],),
                      const SizedBox(width: 25,),
                      const Text("+226 70 70 70 70",style: TextStyle(fontSize: 20,color: Colors.grey),)
                    ],
                  ),
                  const SizedBox(height:15),
            
                  Row(
                    children: [
                      Icon(Icons.email_outlined,color: Colors.grey[600],),
                      const SizedBox(width: 25,),
                      const Text("Email@domain.com",style: TextStyle(fontSize: 20,color: Colors.grey),)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                         IconButton(icon: const Icon(Icons.star,color: Colors.amber,),onPressed: ()=>{},),
                         IconButton(icon: const Icon(Icons.star,color: Colors.amber,),onPressed: ()=>{},),
                         IconButton(icon: const Icon(Icons.star,color: Colors.amber,),onPressed: ()=>{},),
                         IconButton(icon: const Icon(Icons.star,color: Colors.amber,),onPressed: ()=>{},),
                         IconButton(icon: const Icon(Icons.star_half,color: Colors.amber,),onPressed: ()=>{},),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Container(
                    width: Get.width,
                    height: 45,
                    decoration: BoxDecoration(color: Colors.blue[300],borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Center(child: Text("Book Now",style: TextStyle(color: Colors.white,fontSize: 20),)),
                  )
                ],)
              ),
            ),
          )
        ],));
  }
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      controller: ScrollController(),
      child: Column(
        children: [
          ProfileHead(),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text("Your Name",style: TextStyle(fontSize: 25,color: Colors.grey),),
                  Row(children: const [
                    Icon(Icons.location_on,size: 15,),
                    SizedBox(width: 10,),
                  Text("Your Location",style: TextStyle(fontSize: 15,color: Colors.grey),),
    
                  ],)
                ],
              )
            ],
          ),
          const SizedBox(height: 50,),
          Container(
            padding:const EdgeInsets.symmetric(vertical: 2,horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                   border: Border.all(color: Colors.blueAccent),
                   borderRadius: const BorderRadius.all(Radius.circular(15))
                  ),
                  child: const TextField(
                    decoration: InputDecoration(prefixIcon: Icon(Icons.person,size: 20,color: Colors.grey),hintText: "Your Name",border: InputBorder.none,),
                  ),
                ),
                  const SizedBox(height: 10,),

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                   border: Border.all(color: Colors.blueAccent),
                   borderRadius: const BorderRadius.all(Radius.circular(15))
                  ),
                  child: const TextField(
                    decoration: InputDecoration(prefixIcon: Icon(Icons.remove_red_eye,size: 20,color: Colors.grey),hintText: "Your Password",border: InputBorder.none,),
                  ),
                ),
                  const SizedBox(height: 10,),

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                   border: Border.all(color: Colors.blueAccent),
                   borderRadius: const BorderRadius.all(Radius.circular(15))
                  ),
                  child: const TextField(
                    decoration: InputDecoration(prefixIcon: Icon(Icons.phone_android,size: 20,color: Colors.grey),hintText: "Your Phone Number",border: InputBorder.none,),
                  ),
                ),
                  const SizedBox(height: 10,),

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                   border: Border.all(color: Colors.blueAccent),
                   borderRadius: const BorderRadius.all(Radius.circular(15))
                  ),
                  child: const TextField(
                    decoration: InputDecoration(prefixIcon: Icon(Icons.email_outlined,size: 20,color: Colors.grey),hintText: "Your Mail",border: InputBorder.none,),
                  ),
                ),
                const SizedBox(height: 15,),
          Align(
            alignment: Alignment.topRight,
            child: Text("Add Your Service",style: TextStyle(color: Colors.blue[300],decoration: TextDecoration.underline),),
          ),
          SizedBox(height: 100,),
          Container(
            width: Get.width,
            height: 50,
            color: Colors.blue[300],
            child: Center(child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 15),)),
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
  const ChipList({ Key? key }) : super(key: key);

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
    bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Column(
        children: [
          ProfileHead(),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text("Your Name",style: TextStyle(fontSize: 25,color: Colors.grey),),
                  Row(children: const [
                    Icon(Icons.location_on,size: 15,),
                    SizedBox(width: 10,),
                  Text("Your Location",style: TextStyle(fontSize: 15,color: Colors.grey),),
    
                  ],)
                ],
              )
            ],
          ),
          const SizedBox(height: 50,),
          Expanded(
            child: Container(
              width: Get.width,
              //color: Color.fromARGB(255, 255, 255, 255),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                children: [
                  ChoiceChip(label: 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text("Mechanic",style: TextStyle(color: Colors.white),)),selected: isSelected,disabledColor: Colors.grey,onSelected: (bool value){
                    setState(() {
                      isSelected = !isSelected;
                    });
                    },
                    selectedColor: Colors.blue[300],
                  ),
                  ChoiceChip(label: 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text("Mechanic",style: TextStyle(color: Colors.white),)),selected: isSelected,disabledColor: Colors.grey,onSelected: (bool value){
                    setState(() {
                      isSelected = !isSelected;
                    });
                    },
                    selectedColor: Colors.blue[300],
                  ),
                  ChoiceChip(label: 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text("Mechanic",style: TextStyle(color: Colors.white),)),selected: isSelected,disabledColor: Colors.grey,onSelected: (bool value){
                    setState(() {
                      isSelected = !isSelected;
                    });
                    },
                    selectedColor: Colors.blue[300],
                  ),
                  ChoiceChip(label: 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text("Mechanic",style: TextStyle(color: Colors.white),)),selected: isSelected,disabledColor: Colors.grey,onSelected: (bool value){
                    setState(() {
                      isSelected = !isSelected;
                    });
                    },
                    selectedColor: Colors.blue[300],
                  ),
                  ChoiceChip(label: 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text("Mechanic",style: TextStyle(color: Colors.white),)),selected: isSelected,disabledColor: Colors.grey,onSelected: (bool value){
                    setState(() {
                      isSelected = !isSelected;
                    });
                    },
                    selectedColor: Colors.blue[300],
                  ),
                  ChoiceChip(label: 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text("Mechanic",style: TextStyle(color: Colors.white),)),selected: isSelected,disabledColor: Colors.grey,onSelected: (bool value){
                    setState(() {
                      isSelected = !isSelected;
                    });
                    },
                    selectedColor: Colors.blue[300],
                  ),
                  ChoiceChip(label: 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text("Mechanic",style: TextStyle(color: Colors.white),)),selected: isSelected,disabledColor: Colors.grey,onSelected: (bool value){
                    setState(() {
                      isSelected = !isSelected;
                    });
                    },
                    selectedColor: Colors.blue[300],
                  ),
                  
        ],
      )
            ,)
       ),
        ],
      )
    );
  }
}