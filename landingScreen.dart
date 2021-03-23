import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  PickedFile imageFile;
  Dio dio=new Dio();


  _openCamera(BuildContext context) async{
    //holds the image taken by the camera
    var picture =await ImagePicker().getImage(source: ImageSource.camera);
    if(picture !=null) {
      this.setState(() {
        imageFile = picture;
      });
    }
    try{
      //Extracting the file name from the file
      String filename=imageFile.path.split('/').last;
    FormData formData=new FormData.fromMap({
      "image":
    await MultipartFile.fromFile(imageFile.path,filename:filename,contentType: new MediaType('image','png')),
    "type":"image/png"
    });
    //sending to the server
      Response response = await dio.post("path",data:formData,options: Options(
        headers: {
          "accept" :"*/*",
    "Authorization" : "Bearer accesstoken",
    "Content-Type":"multipart/form-data"
    }
    ));
    }
    catch(e){
      print(e);
    }

  }
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