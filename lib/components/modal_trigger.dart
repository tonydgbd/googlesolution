import 'package:flutter/material.dart';

class ModalTrigger {
  static void _showModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
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
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 28.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                ],
              ),
              Container(
                child: Text(
                  'Mechanic',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                              "Username",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
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
                              "+226 55 19 39 60",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

              ),
              Container(
                 child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
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
                          child: Text(
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
                    )
              )
            ],
            
          ),
          
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return RawMaterialButton(
  //     onPressed: () {
  //       _showModalBottomSheet(context);
  //     },
  //     fillColor: Colors.black,
  //     constraints: BoxConstraints(minHeight: 50),
  //     elevation: 0,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  //     textStyle: TextStyle(
  //       fontSize: 16,
  //       fontFamily: 'OpenSans',
  //       color: Colors.white,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     child: Text('Tap to open!'),
  //   );
  // }
// }
}