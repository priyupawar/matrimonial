import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial/localstorage.dart';
import 'package:matrimonial/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String fileName;
String path;
List keys = [];
List values = [];
Color titlecolor = Colors.red;
bool fileread = false;

class NotificationClass extends StatefulWidget {
  @override
  _NotificationClassState createState() => _NotificationClassState();
}

class _NotificationClassState extends State<NotificationClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Text('hello'),
    );
  }
}
// class NotificationClass extends StatefulWidget {
//   @override
//   _NotificationClassState createState() => _NotificationClassState();
// }

// class _NotificationClassState extends State<NotificationClass> {
//   final Firestore _db = Firestore.instance;
//   final FirebaseMessaging _fcm = FirebaseMessaging();
//   StreamSubscription iosSubscription;
//   static const routeName = '/notification';

//   Future getFile() async {
//     await SharedPreferences.getInstance().then((SharedPreferences prefs) {
//       path = prefs.getString('file');
//       //print(path);
//     });
//     getApplicationDocumentsDirectory().then((Directory directory) {
//       dir = directory;
//       jsonFile = new File(path);
//       fileExists = jsonFile.existsSync();
//       if (fileExists) {
//         // print('file exixts');
//         // this.setState(() {
//         fileContent = jsonDecode(jsonFile.readAsStringSync());
//         //print(fileContent);
//         // });
//       }
//     });
//     return fileContent;
//   }

//   @override
//   void initState() {
//     setCurrentRoute(routeName);
//     super.initState();
//     if (Platform.isIOS) {
//       iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
//         // save the token  OR subscribe to a topic here
//       });

//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Notifications'),
//         ),
//         body: FutureBuilder(
//           future: getFile(),
//           builder: (BuildContext context, snapshot) {
//             if (snapshot.connectionState != ConnectionState.done) {
//               return Center(child: CircularProgressIndicator());
//             } else {
//               if (snapshot.hasData) {
//                 keys = [];
//                 values = [];
//                 for (int i = 0; i < fileContent['message'].length; i++) {
//                   keys.add(fileContent['message'][i].keys.toList()[0]);
//                 }
//                 for (int j = 0; j < keys.length; j++) {
//                   values.add(fileContent['message'][j][keys[j]]);
//                 }
//                 // print(keys);
//                 return Container(
//                   child: ListView.builder(
//                     itemCount: keys.length,
//                     itemBuilder: (BuildContext context, index) {
//                       // print(fileContent['message'][index]);

//                       return ListTile(
//                         title: Text(keys[index].toString().toUpperCase()),
//                         // style: TextStyle(
//                         //     // color: fileContent['Colors'] == 'red'
//                         //     //     ? Colors.red
//                         //     //     : Colors.blue,
//                         //     )),
//                         subtitle: Text(values[index],
//                             style: TextStyle(
//                               color: Theme.of(context).primaryColor,
//                             )),
//                         onTap: () {
//                           setState(() {
//                             fileread = true;
//                             showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: Text(
//                                         keys[index].toString().toUpperCase()),
//                                     content: Text(values[index]),
//                                     actions: <Widget>[
//                                       FlatButton(
//                                         child: Text('Ok'),
//                                         onPressed: () =>
//                                             Navigator.of(context).pop(),
//                                       )
//                                     ],
//                                   );
//                                 });
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Text('No new messages.'),
//                 );
//               }
//             }
//           },
//         ));
//   }
// }
