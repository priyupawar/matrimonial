import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

File _image1;
String _uploadedeFile1;
File _image2;
String _uploadedeFile2;
File _image3;
String _uploadedeFile3;
String default_img;
bool uploading = false;

class ImageUpload extends StatefulWidget {
  final values;
  ImageUpload(this.values);
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  Future uploadFile(_image, imagename) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_picture/${Path.basename(_image.path)}');
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);
    await storageUploadTask.onComplete;
    setState(() {
      uploading = false;
    });
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        if (imagename == 'image1') {
          _uploadedeFile1 = fileURL;
          widget.values.update('image1', (v) {
            return _uploadedeFile1;
          });
        }
        if (imagename == 'image2') {
          _uploadedeFile2 = fileURL;
          widget.values.update('image2', (v) {
            return _uploadedeFile2;
          });
        }
        if (imagename == 'image3') {
          _uploadedeFile3 = fileURL;
          widget.values.update('image3', (v) {
            return _uploadedeFile3;
          });
        }
      });
    });
    Fluttertoast.showToast(
      msg: 'File Uploaded',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future choosefile1() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        if (image != null) {
          if (_image1 != null) {
            print('image not null');

            if (image.path == _image1.path) {
              print('old image');
              Fluttertoast.showToast(
                msg: 'File Already Present',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            } else {
              print('new image');
              uploading = true;
              _image1 = image;
              uploadFile(image, 'image1');
            }
          } else {
            print(' image null');
            uploading = true;
            _image1 = image;
            uploadFile(image, 'image1');
          }
        }
      });
    });
  }

  Future choosefile2() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        if (image != null) {
          if (_image2 != null) {
            if (_image2 != image) {
              _image2 = image;
              uploading = true;
              uploadFile(image, 'image2');
            } else {
              Fluttertoast.showToast(
                msg: 'File Already Present',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }
          } else {
            _image2 = image;
            uploading = true;
            uploadFile(image, 'image2');
          }
        }
      });
    });
  }

  Future choosefile3() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        if (image != null) {
          if (_image3 != null) {
            if (_image3 != image) {
              _image3 = image;
              uploading = true;
              uploadFile(image, 'image3');
            } else {
              Fluttertoast.showToast(
                msg: 'File Already Present',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }
          } else {
            _image3 = image;
            uploading = true;
            uploadFile(image, 'image3');
          }
        }
      });
    });
  }

  @override
  void initState() {
    default_img = 'assets/default.png';
    _uploadedeFile1 = widget.values['image1'];
    _uploadedeFile2 = widget.values['image2'];
    _uploadedeFile3 = widget.values['image3'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 5,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: _uploadedeFile1 != null
                                  ? CachedNetworkImageProvider(_uploadedeFile1)
                                  : Image.asset(default_img)))
                      // child: _image1 != null
                      //     ? Image.asset(
                      //         _image1.path,
                      //         //height: 150,
                      //       )
                      //     : Image.asset(default_img)
                      //color: Colors.red,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: Image.asset(
                      //             _image != null ? _image.path : default_img))),
                      ),
                  GestureDetector(
                      onTap: () {
                        choosefile1();
                      },
                      child: Icon(Icons.add_a_photo))
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: _uploadedeFile2 != null
                                  ? CachedNetworkImageProvider(_uploadedeFile2)
                                  : Image.asset(default_img)))
                      // child: _image2 != null
                      //     ? Image.asset(
                      //         _image2.path,
                      //         //height: 150,
                      //       )
                      //     : Image.asset(default_img)
                      //color: Colors.red,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: Image.asset(
                      //             _image != null ? _image.path : default_img))),
                      ),
                  GestureDetector(
                      onTap: () {
                        choosefile2();
                      },
                      child: Icon(Icons.add_a_photo))
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: _uploadedeFile3 != null
                                  ? CachedNetworkImageProvider(_uploadedeFile3)
                                  : Image.asset(default_img)))
                      //color: Colors.red,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: Image.asset(
                      //             _image != null ? _image.path : default_img))),
                      ),
                  GestureDetector(
                      onTap: () {
                        choosefile3();
                      },
                      child: Icon(Icons.add_a_photo))
                ],
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[uploading ? Text('Uploading....') : Text('')]),
        ],
      ),
    );
  }
}
