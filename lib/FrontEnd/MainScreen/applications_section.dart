import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:circle_list/circle_list.dart';

import 'package:generation_official/FrontEnd/Preview/images_preview_screen.dart';
import 'package:image_picker/image_picker.dart';

class ApplicationList extends StatefulWidget {
  @override
  _ApplicationListState createState() => _ApplicationListState();
}

class _ApplicationListState extends State<ApplicationList> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(34, 48, 60, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircleList(
            initialAngle: 55,
            outerRadius: MediaQuery.of(context).size.width / 2.2,
            innerRadius: MediaQuery.of(context).size.width / 5,
            showInitialAnimation: true,
            innerCircleColor: Color.fromRGBO(34, 48, 60, 1),
            outerCircleColor: Color.fromRGBO(0, 0, 0, 0.1),
            origin: Offset(0, 0),
            rotateMode: RotateMode.allRotate,
            centerWidget: Center(
              child: Text(
                "G",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 65.0,
                  fontFamily: 'Lora',
                ),
              ),
            ),
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    )),
                child: GestureDetector(
                  onLongPress: () async {
                    print("Take Image");

                    final PickedFile pickedFile =
                        await picker.getImage(source: ImageSource.gallery);

                    print(pickedFile.path);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviewImageScreen(
                          imageFile: File(pickedFile.path),
                          allConnectionUserName: [],
                        ),
                      ),
                    );
                  },
                  onTap: () async {
                    final PickedFile pickedFile =
                        await picker.getImage(source: ImageSource.camera);

                    print(pickedFile.path);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviewImageScreen(
                          imageFile: File(pickedFile.path),
                          allConnectionUserName: [],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        size: 40,
                        color: Colors.green,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    )),
                child: GestureDetector(
                  // onLongPress: () async {
                  //   final PickedFile pickedFile =
                  //       await picker.getVideo(source: ImageSource.gallery);
                  //
                  //   print(pickedFile.path);
                  // },
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              elevation: 5.0,
                              backgroundColor:
                                  const Color.fromRGBO(34, 48, 60, 0.6),
                              title: Text(
                                "Video Player in Development Mode",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                  fontFamily: 'Lora',
                                  letterSpacing: 1.0,
                                ),
                              ),
                              content: Text(
                                "Due to Some Problem, We can't introduce it for now...\nBut We will introduce this feature soon",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontFamily: 'Lora',
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ));
                    // final PickedFile pickedFile =
                    //     await picker.getVideo(source: ImageSource.camera);
                    //
                    // print(pickedFile.path);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.video_call_sharp,
                        size: 40,
                        color: Colors.green,
                      ),
                      Text(
                        'Video',
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    )),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Color.fromRGBO(0, 0, 0, 0.0),
                    onPrimary: Colors.white70,
                    shape: CircleBorder(),
                  ),
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.call,
                        size: 40,
                        color: Colors.green,
                      ),
                      Text(
                        'Call',
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    )),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Color.fromRGBO(0, 0, 0, 0.0),
                    onPrimary: Colors.white70,
                    shape: CircleBorder(),
                  ),
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 40,
                        color: Colors.green,
                      ),
                      Text(
                        'Location',
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
