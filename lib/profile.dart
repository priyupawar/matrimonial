import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial/forms/infotabs.dart';
import 'package:matrimonial/forms/searchprofile.dart';
import 'package:matrimonial/services/auth_service.dart';
import 'package:matrimonial/widget/notifications.dart';
import 'package:matrimonial/widget/list.dart';
import 'package:matrimonial/widget/sidenav.dart';
import 'package:matrimonial/widget/imageview.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:matrimonial/widget/checkboxform.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:matrimonial/widget/textform.dart';

String image =
    'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b';
String name = '';
String gender;
List profile = [];
List<Widget> menu1 = [];
List<Widget> menu2 = [];
List<Widget> menu = [];
List citylist = [];
List keys = [];
Map<String, String> checkboxvalue = {};
Map<String, String> castevalue = {};
Map<String, String> agevalue = {};
TextEditingController _minage;
TextEditingController _maxage;
String type = '';
int len = 0;
Color iconColor = Colors.white;

class MainPageProfile extends StatefulWidget {
  final email;

  MainPageProfile(this.email);
  @override
  _MainPageProfileState createState() => _MainPageProfileState();
}

class _MainPageProfileState extends State<MainPageProfile> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  @override
  void initState() {
    checkboxvalue = {
      'Mumbai': 'false',
      'Pune': 'false',
      'Nagpur': 'false',
      'Other': 'false'
    };
    castevalue = {'Catholic': '', 'Protestian': '', 'Other': ''};
    agevalue = {'MinAge': '', 'MaxAge': ''};
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        //  print('onMessage ');
        createFile({
          'title': message['notification']['title'],
          'body': message['notification']['body']
        }, widget.email)
            .then((length) {
          setState(() {
            iconColor = Colors.red;
          });

          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertDialog(
          //         content: ListTile(
          //           title: Text(message['notification']['title']),
          //           subtitle: Text(message['notification']['body']),
          //         ),
          //         actions: <Widget>[
          //           FlatButton(
          //             child: Text('Ok'),
          //             onPressed: () => Navigator.of(context).pop(),
          //           )
          //         ],
          //       );
          //     });
        });
        // print('length' + len.toString());
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('page refresh');
    return Scaffold(
        appBar: AppBar(
          title: Text('Christi Jeevan Sathi'),
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  iconColor = Colors.white;
                  Navigator.pushNamed(context, '/notification');
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 10, top: 10),
                    child: Stack(
                      children: <Widget>[
                        Icon(
                          Icons.notifications,
                          size: 35,
                          color: iconColor,
                        ),
                        // Container(
                        //   child: Text(
                        //     len.toString(),
                        //     textAlign: TextAlign.center,
                        //   ),
                        //   constraints: BoxConstraints(
                        //     minWidth: 14,
                        //     minHeight: 14,
                        //   ),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: Colors.red),
                        // )
                      ],
                    ))),
          ],
        ),
        floatingActionButton: AnimatedFloatingActionButton(
            //Fab list
            fabButtons: <Widget>[
              float3(),
              float1(profile),
              float2(profile),
            ],
            colorStartAnimation: Colors.blue,
            colorEndAnimation: Colors.red,
            animatedIconData:
                AnimatedIcons.search_ellipsis //To principal button
            ),
        drawer: Sidenav(widget.email, false),
        body: buildList(widget.email, type, agevalue, citylist));
  }

  Widget float1(profiledata) {
    return Container(
      child: FloatingActionButton(
        heroTag: 'Age',
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Container(
                    child: SimpleDialog(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20)),
                  title: Text(
                    'Filter By Age:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            // width: 200,
                            child: TextBox(
                                _minage,
                                'MinAge',
                                'text',
                                TextInputType.number,
                                agevalue,
                                1,
                                agevalue['MinAge'])),
                        Expanded(
                            //width: 200,
                            child: TextBox(
                                _maxage,
                                'MaxAge',
                                'text',
                                TextInputType.number,
                                agevalue,
                                1,
                                agevalue['MaxAge']))
                      ],
                    ),
                    FlatButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 18, color: Theme.of(context).accentColor),
                      ),
                      onPressed: () {
                        setState(() {
                          type = 'Age';
                        });

                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
              });
        },
        tooltip: 'Filter by age',
        child: Text('Age'),
      ),
    );
  }

  Widget float2(profiledata) {
    return Container(
      child: FloatingActionButton(
        heroTag: 'City',
        onPressed: () {
          {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                      child: SimpleDialog(
                    title: Text(
                      'Filter By City:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      CheckboxForm('Mumbai', false, checkboxvalue),
                      CheckboxForm('Pune', false, checkboxvalue),
                      CheckboxForm('Nagpur', false, checkboxvalue),
                      CheckboxForm('Other', false, checkboxvalue),
                      FlatButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                        onPressed: () {
                          setState(() {
                            type = 'City';
                            citylist = [];
                            keys = checkboxvalue.keys.toList();
                            for (int i = 0; i < checkboxvalue.length; i++) {
                              if (checkboxvalue[keys[i]] == 'true') {
                                citylist.add(keys[i].toLowerCase());
                              }
                            }
                          });
                          // print(citylist);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ));
                });
          }
        },
        tooltip: 'Filter by city',
        child: Text('City'),
      ),
    );
  }

  Widget float3() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'clear',
        onPressed: () {
          {
            setState(() {
              type = '';
            });
          }
        },
        tooltip: 'Clear Filter',
        child: Text('Clear'),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  final email;
  Profile(this.email);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
          actions: <Widget>[
            // Padding(
            //     padding: EdgeInsets.all(10),
            //     child: GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => SearchProfile()));
            //         },
            //         child: Icon(
            //           Icons.search,
            //           size: 30,
            //         )))
            // Padding(
            //     padding: EdgeInsets.all(10),
            //     child: GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => InfoTabs(widget.profile)));
            //         },
            //         child: Icon(
            //           Icons.edit,
            //           size: 30,
            //         )))
          ],
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(widget.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Stack(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: [
                            0.2,
                            0.4,
                            0.6
                          ],
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(.2),
                            Theme.of(context).primaryColor.withOpacity(.4),
                            Theme.of(context).accentColor.withOpacity(.6)
                          ]),
                    ),
                  ),
                  _mainListBuilder(snapshot.data)
                ],
              );
            }
          },
        ));
  }

  Widget _mainListBuilder(profile) {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) return _buildHeader(context, profile);
          if (index == 1)
            return Card(
                elevation: 20,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Email Id:'),
                      subtitle: Text(profile['Email']),
                      leading: Icon(Icons.email),
                    ),
                    ListTile(
                      title: Text('Mobile No.'),
                      subtitle: Text(profile['Mobile'].toString()),
                      leading: Icon(Icons.mobile_screen_share),
                    ),
                    ListTile(
                      title: Text('Address'),
                      subtitle: Text(profile['Address']),
                      leading: Icon(Icons.home),
                    ),
                    ListTile(
                      title: Text('About'),
                      subtitle: Text('shdhhdg'),
                      leading: Icon(Icons.person),
                    ),
                    ListTile(
                      title: Text('More'),
                      onTap: () {
                        Navigator.pushNamed(context, '/infotabs',
                            arguments: profile);
                      },
                    ),
                  ],
                ));

          // if(index==3) return Container(
          //   color: Colors.white,
          //   padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
          //   child: Text("Most liked posts",
          //     style: Theme.of(context).textTheme.title
          //   )
          // );
          return null;
        });
  }

  // Widget _buildListItem() {
  //   return Card(
  //       elevation: 20,
  //       margin: EdgeInsets.all(10),
  //       child: ListTile(
  //         title: Text('View Profiles'),
  //       ));
  // }

  Container _buildHeader(BuildContext context, profile) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    profile['Name'],
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(profile['Bio Headline']),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              // "Age:" + profile['age'],
                              "Age",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(profile['Age'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              // "Age:" + profile['age'],
                              "Profession",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(profile['Profession'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Material(
              //   elevation: 5.0,
              //   shape: CircleBorder(),
              //   child: CircleAvatar(
              //     radius: 70.0,
              //     backgroundImage:
              //         CachedNetworkImageProvider(profile['image1']),
              //   ),
              // ),

              GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ImageView(
                          profile['image1'],
                          profile['image2'],
                          profile['image3']),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                      //  border: Border.all(width: 1),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(profile['image1']),
                          fit: BoxFit.fitHeight),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
