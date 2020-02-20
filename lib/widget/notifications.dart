import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String fileName;
String path;
List keys = [];
Color titlecolor = Colors.red;
bool fileread = false;

class NotificationClass extends StatefulWidget {
  @override
  _NotificationClassState createState() => _NotificationClassState();
}

class _NotificationClassState extends State<NotificationClass> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future getFile() async {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      path = prefs.getString('file');
    });
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(path);
      fileExists = jsonFile.existsSync();
      if (fileExists) {
        print('file exixts');
        // this.setState(() {
        fileContent = jsonDecode(jsonFile.readAsStringSync());
        print(fileContent);
        // });
      }
    });
    return fileContent;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: FutureBuilder(
          future: getFile(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return Container(
                  child: ListView.builder(
                    itemCount: fileContent.length,
                    itemBuilder: (BuildContext context, index) {
                      keys = fileContent.keys.toList();

                      return ListTile(
                        title: Text(keys[index].toString().toUpperCase(),
                            style: TextStyle(
                              color: fileContent['Colors'] == 'red'
                                  ? Colors.red
                                  : Colors.blue,
                            )),
                        subtitle: Text(fileContent[keys[index]],
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            )),
                        onTap: () {
                          setState(() {
                            fileread = true;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        keys[index].toString().toUpperCase()),
                                    content: Text(fileContent[keys[index]]),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    ],
                                  );
                                });
                          });
                        },
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text('No new messages.'),
                );
              }
            }
          },
        ));
  }
}
