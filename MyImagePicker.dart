import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyImagePicker(title: 'Upload image'),
    );
  }
}

class MyImagePicker extends StatefulWidget {
  MyImagePicker({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  PickedFile _imageFile;
  final String uploadUrl = 'http://192.168.8.101:3000/Image';
  final ImagePicker _picker = ImagePicker();

//Constructing a multipart image file
  Future<String> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    //sending file using the multipart POST request using the provided URL
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<void> retriveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      print('Retrieve error ' + response.exception.code);
    }
  }

  //Creating an Image holder on the screen
  // It displays the selected image.
  Widget _previewImage() {
    if (_imageFile != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(File(_imageFile.path)),
            SizedBox(
              height: 20,
            ),
            //upload image to the server on button click
            RaisedButton(
              onPressed: () async {
                var res = await uploadImage(_imageFile.path, uploadUrl);
                print(res);
                print("works");
              },
              child: const Text('Upload'),
            )
          ],
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  //Function to capture an image from the camera
  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.camera);
      //setState called so the image can be displayed on the screen
      setState(() {
        //Image gets saved in _imageFile variable of PickedFile Type
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Image picker error " + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<void>(
            future: retriveLostData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Text('Picked an image');
                case ConnectionState.done:
                  return _previewImage();
                default:
                  return const Text('Picked an image');
              }
            },
          )),
      //opens up the gallery to select a image
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image from gallery',
        child: Icon(Icons.photo_library),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

