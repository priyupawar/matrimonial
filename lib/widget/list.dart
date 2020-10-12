import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial/route_generator.dart';
import 'package:matrimonial/services/auth_service.dart';
import 'package:matrimonial/widget/profiledetailpage.dart';
import 'package:matrimonial/widget/profileview.dart';

final primary = Color(0xff696b9e);
final secondary = Color(0xfff29a94);
List profiles = [];
List search = [];
String gender;
Widget buildList(email, type, agevalue, cityvalue, searchby) {
  if (type == '') {
    return FutureBuilder(
        future: filterGender(email),
        builder: (context, snapshot) {
          //print(snapshot.connectionState);
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            profiles = snapshot.data;
            gender = profiles[0]['Gender'];
            profiles = profiles
                .where((value) => value[searchby]
                    .toLowerCase()
                    .contains(agevalue.toString().toLowerCase()))
                .toList();
            return ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (BuildContext context, int index) {
                  if (profiles.length <= 0) {
                    return Center(child: Text('No Data found'));
                  } else {
                    return GestureDetector(
                        onTap: () {
                          if (email == 'admin@gmail.com') {
                            Navigator.pushNamed(context, '/adminview',
                                arguments: ({
                                  "profile": profiles[index].data,
                                  "admin": true
                                }));
                            // ScreenArguments(profiles[index].data, false));
                          } else {
                            //print(profiles[index].data);
                            Navigator.pushNamed(context, '/profileview',
                                arguments: {
                                  "profile": profiles[index].data,
                                  "admin": false
                                });
                            //      ScreenArguments(profiles[index].data, false));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: 120,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // border: Border.all(width: 3, color: secondary),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          profiles[index]['image1']),
                                      fit: BoxFit.fitHeight),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      profiles[index]['Name'],
                                      style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        // Icon(
                                        //   Icons.person,
                                        //   color: secondary,
                                        //   size: 20,
                                        // ),
                                        Text('DOB:',
                                            style: TextStyle(
                                                color: primary,
                                                fontSize: 13,
                                                letterSpacing: .3)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(profiles[index]['DOB'],
                                            style: TextStyle(
                                                color: primary,
                                                fontSize: 13,
                                                letterSpacing: .3)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Age:',
                                            style: TextStyle(
                                                color: primary,
                                                fontSize: 13,
                                                letterSpacing: .3)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(profiles[index]['Age'],
                                            style: TextStyle(
                                                color: primary,
                                                fontSize: 13,
                                                letterSpacing: .3)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        // Icon(
                                        //   Icons.home,
                                        //   color: secondary,
                                        //   size: 20,
                                        // ),
                                        Text('City:',
                                            style: TextStyle(
                                                color: primary,
                                                fontSize: 13,
                                                letterSpacing: .3)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(profiles[index]['City'],
                                            style: TextStyle(
                                                color: primary,
                                                fontSize: 13,
                                                letterSpacing: .3)),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
                  }
                });
          }
        });
  }
  if (type == 'all') {
    return StreamBuilder(
        stream: fire.collection('users').snapshots(),
        builder: (context, snapshot) {
          //print(snapshot.connectionState);
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            //  print(snapshot.data.documents);
            profiles = snapshot.data.documents;

            return ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profileview',
                            arguments: ({
                              "profile": profiles[index].data,
                              "admin": false
                            }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        height: 120,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                // border: Border.all(width: 3, color: secondary),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        profiles[index]['image1']),
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    profiles[index]['Name'],
                                    style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      // Icon(
                                      //   Icons.person,
                                      //   color: secondary,
                                      //   size: 20,
                                      // ),
                                      Text('DOB:',
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(profiles[index]['DOB'],
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Age:',
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(profiles[index]['Age'],
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      // Icon(
                                      //   Icons.home,
                                      //   color: secondary,
                                      //   size: 20,
                                      // ),
                                      Text('City:',
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(profiles[index]['City'],
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                });
          }
        });
  }
  if (type == 'search') {
    search = profiles
        .where((value) =>
            value[searchby].toLowerCase().contains(agevalue.toLowerCase()))
        .toList();
    print(search);
    if (search.length == 0) {
      return Center(child: Text('No User Found'));
    } else {
      return ListView.builder(
          itemCount: search.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profileview',
                      arguments: ScreenArguments(search[index].data, false));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  height: 120,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // border: Border.all(width: 3, color: secondary),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  search[index]['image1']),
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              search[index]['Name'],
                              style: TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: <Widget>[
                                // Icon(
                                //   Icons.person,
                                //   color: secondary,
                                //   size: 20,
                                // ),
                                Text('Age:',
                                    style: TextStyle(
                                        color: primary,
                                        fontSize: 13,
                                        letterSpacing: .3)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(search[index]['Age'],
                                    style: TextStyle(
                                        color: primary,
                                        fontSize: 13,
                                        letterSpacing: .3)),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: <Widget>[
                                // Icon(
                                //   Icons.home,
                                //   color: secondary,
                                //   size: 20,
                                // ),
                                Text('City:',
                                    style: TextStyle(
                                        color: primary,
                                        fontSize: 13,
                                        letterSpacing: .3)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(search[index]['City'],
                                    style: TextStyle(
                                        color: primary,
                                        fontSize: 13,
                                        letterSpacing: .3)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          });
    }
  } else {
    return FutureBuilder(
        future: filterData(agevalue, cityvalue, type, gender),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            //return Text('');
            profiles = snapshot.data;
            return ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profileview',
                            arguments:
                                ScreenArguments(profiles[index].data, false));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        height: 120,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                // border: Border.all(width: 3, color: secondary),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        profiles[index]['image1']),
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    profiles[index]['Name'],
                                    style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      // Icon(
                                      //   Icons.person,
                                      //   color: secondary,
                                      //   size: 20,
                                      // ),
                                      Text('Age:',
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(profiles[index]['Age'],
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      // Icon(
                                      //   Icons.home,
                                      //   color: secondary,
                                      //   size: 20,
                                      // ),
                                      Text('City:',
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(profiles[index]['City'],
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                });
          }
        });
  }
}
