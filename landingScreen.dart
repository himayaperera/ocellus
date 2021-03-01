import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  PickedFile imageFile;
  // _openGallery(BuildContext context) async{
  //   var picture =await ImagePicker().getImage(source: ImageSource.gallery);
  //   this.setState(() {
  //     imageFile= picture;
  //   });
  //   Navigator.of(context).pop();
  // }
  _openCamera(BuildContext context) async{
    var picture =await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile= picture;
    });
    // Navigator.of(context).pop();
  }
  // Future<void>_showChoiceDialog(BuildContext context){
  //   return showDialog(context:context,builder:(BuildContext context){
  //     return AlertDialog(
  //       title: Text("Make a Choice"),
  //       content: SingleChildScrollView(
  //         child:ListBody(
  //           children: <Widget>[
  //             // GestureDetector(
  //             //   child: Text("Gallery"),
  //             //   onTap: (){
  //             //     _openGallery(context);
  //             //   },
  //             // ),
  //             GestureDetector(
  //               child: Text("Camera"),
  //               onTap: (){
  //                 _openCamera(context);
  //               },
  //             )
  //           ],
  //         ) ,
  //       ),
  //     );
  //   });
  // }
  Widget _decideImageView(){
    if(imageFile==null){
      return Text("No selected Image");
    }else{
      return Image.file(File(imageFile.path), width: 500, height: 400);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo[900],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              SizedBox(
                height: 300,
                width: 420,
              child: RaisedButton.icon(onPressed: (){
                _openCamera(context);
                // _showChoiceDialog(context);
              },label: Text('OPEN CAMERA',
                style: TextStyle(color: Colors.white,fontSize: 20),),
                icon: Icon(Icons.camera_alt_outlined, color:Colors.white,size: 200,),
                color: Colors.deepOrange,

              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}