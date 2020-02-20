import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial/forms/resetpass.dart';
import 'package:matrimonial/forms/shortlist.dart';
import 'package:matrimonial/homepage.dart';
import 'package:matrimonial/forms/payments.dart';
import 'package:matrimonial/profile.dart';
import 'package:matrimonial/widget/horizontalline.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

String name = '';

void logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.getBool('remember')) {
    prefs.remove('username');
    prefs.remove('password');
    prefs.setBool('isLoggedIn', false);
    FirebaseAuth.instance.signOut();
  }

  //print(prefs.getString('file'));
  //LocalStorage().deleteFile(File(prefs.getString('file')));
}

class Sidenav extends StatefulWidget {
  final email;
  final admin;
  Sidenav(this.email, this.admin);
  @override
  _SidenavState createState() => _SidenavState();
}

class _SidenavState extends State<Sidenav> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      name = prefs.getString('username');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Column(
        children: <Widget>[
          UserProfile(widget.email),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('My Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/myprofile',
                  arguments: widget.email);
            },
          ),
          horizontalLine(MediaQuery.of(context).size.width),
          // ListTile(
          //   leading: Icon(Icons.edit),
          //   title: Text('Edit Profile'),
          // ),
          // horizontalLine(MediaQuery.of(context).size.width),

          widget.admin
              ? ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Add Profile'),
                  onTap: () {
                    Navigator.pushNamed(context, '/addprofile');
                  },
                )
              : ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('ShortList'),
                  onTap: () {
                    Navigator.pushNamed(context, '/shortlist');
                  },
                ),
          horizontalLine(MediaQuery.of(context).size.width),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Payments'),
            onTap: () {
              Navigator.pushNamed(context, '/payments');
            },
          ),
          horizontalLine(MediaQuery.of(context).size.width),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Reset Password'),
            onTap: () {
              Navigator.pushNamed(context, '/resetpass');
            },
          ),
          horizontalLine(MediaQuery.of(context).size.width),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Logout'),
            onTap: () {
              logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          horizontalLine(MediaQuery.of(context).size.width),
        ],
      ),
    ));
  }
}

class UserProfile extends StatelessWidget {
  final email;

  UserProfile(this.email);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            Firestore.instance.collection('users').document(email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10),
                    // child: CircleAvatar(
                    //   radius: 60.0,
                    //   backgroundImage:
                    //       CachedNetworkImageProvider(snapshot.data['image1']),
                    //   // child: Icon(
                    //   //   Icons.add_a_photo,
                    //   //   size: 50,
                    //   // ),
                    // )
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                        // border: Border.all(width: 1),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                snapshot.data['image1']),
                            fit: BoxFit.fitHeight),
                      ),
                    )),
                // Container(
                //           height: 100,
                //           width: 100,
                //           decoration: BoxDecoration(
                //               image: DecorationImage(
                //                   image: _uploadedeFile1 != null
                //                       ? CachedNetworkImageProvider(_uploadedeFile1)
                //                       : Image.asset(default_img))))

                Text(snapshot.data['Name'], style: TextStyle(fontSize: 20)),
              ],
            );
          }
        });
  }
}
