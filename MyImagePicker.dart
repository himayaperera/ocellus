import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:ocellus_ui/camera.dart';

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
  //PickedFile _imageFile;
  String _imageFilePath;

  final String uploadUrl = 'http://192.168.1.5:3000/Image';
  final ImagePicker _picker = ImagePicker();

  bool _isCameraActivated = false;
  Camera _camera = Camera();

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
        //## _imageFile = response.file;
        _imageFilePath = response.file.path;
      });
    } else {
      print('Retrieve error ' + response.exception.code);
    }
  }

  //opens camera and captures images periodically
  _captureImagesFromCamera() async {
    while (_isCameraActivated) {
      try {
        await Future.delayed(Duration(seconds: 1));
        var picture = await _camera.takePicture();
        setState(() {
          _imageFilePath = picture.path;
        });
        print("Uploading...");
        print(_imageFilePath);
        var res = await uploadImage(_imageFilePath, uploadUrl);
        print(res);
        print("Upload complete.\n");
      } catch (e) {
        print(e.toString());
      }
    }
  }

  //Creating an Image holder on the screen
  // It displays the selected image.
  Widget _previewImage() {
    //## if (_imageFile != null) {
    if (_imageFilePath != null && _imageFilePath.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //## Image.file(File(_imageFile.path)),
            Image.file(File(_imageFilePath)),
            SizedBox(
              height: 20,
            ),
            //upload image to the server on button click
          ],
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 18)
      );
    }
  }

  //Function to pick an image from the Gallery
  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.camera);
      //setState called so the image can be displayed on the screen
      setState(() {
        //Image gets saved in _imageFile variable of PickedFile Type
        //## _imageFile = pickedFile;
        _imageFilePath = pickedFile.path;
      });
    } catch (e) {
      print("Image picker error " + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<void>(
          future: retriveLostData(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Text('Picked an image');
              case ConnectionState.done:
                return const Text('Done');
              default:
                return const Text('Picked an image');
            }
          },
        ),
      ),
      backgroundColor: Colors.indigo[900],
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: _previewImage(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(left: 10, bottom: 80),
                color: Colors.purple[200],
                height: 250,
                width: 250,
                child: _camera,
              ),
            ),
          ],
        ),
      ),
      //opens up the gallery to select a image
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      _isCameraActivated = !_isCameraActivated;
                    });

                    _captureImagesFromCamera();
                  },
                  child: _isCameraActivated ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
                  backgroundColor: _isCameraActivated ? Colors.red : Colors.green,
                  heroTag: 'auto_camera',
                ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: _pickImage,
              tooltip: 'Pick Image from gallery',
              child: Icon(Icons.photo_library),
              heroTag: 'manual_gallery',
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}