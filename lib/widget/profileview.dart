import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial/forms/shortlist.dart';
import 'package:matrimonial/services/shortist_service.dart';
import 'package:matrimonial/widget/swipepage.dart';
import 'package:matrimonial/widget/imageview.dart';

var keys1 = [
  'Name',
  'Gender',
  'Age',
  'DOB',
  'Height',
  'Weight',
  'Complexion',
];

class ProfileView extends StatelessWidget {
  final profiles;
  ProfileView(this.profiles);
  @override
  Widget build(BuildContext context) {
    var profile = profiles.profile;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(profile['Name'].toString()),
          actions: <Widget>[
            profiles.admin
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/infotabs',
                            arguments: profile);
                      },
                      child: Icon(Icons.edit),
                    ),
                  )
                : Text(''),
            profiles.admin
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content:
                                    Text('Do you want to delete this profile?'),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancle'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      fire
                                          .collection('users')
                                          .document(profile['Email'])
                                          .delete();
                                      Fluttertoast.showToast(
                                          msg: 'Profile Deleted',
                                          toastLength: Toast.LENGTH_LONG);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok'),
                                  )
                                ],
                              );
                            });
                        // Navigator.pushNamed(context, '/infotabs',
                        //     arguments: profile);
                      },
                      child: Icon(Icons.delete),
                    ),
                  )
                : Text('')
          ],
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                          width: 200,
                          height: 200,
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                            //  border: Border.all(width: 1),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    profile['image1']),
                                fit: BoxFit.fitHeight),
                          ),
                        )
                        // child: CircleAvatar(
                        //   radius: 100.0,
                        //   backgroundImage:
                        //       CachedNetworkImageProvider(profile['image1']),
                        // ),
                        ),
                    FlatButton(
                      child: Text(
                        'Add to Shortlist',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onPressed: () {
                        addToShortlist([profile['Email']]);
                        // getShortlist();
                      },
                    )
                  ],
                );
              }
              if (index == 1) {
                return Column(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        child: SwiperPage(profile)),
                    Text('Swipe to see more')
                  ],
                );
              }
              // if (keys[index] == 'logoText') {
              //   return null;
              // }
              return ListTile(
                title: Text(keys1[index].toString().toUpperCase()),
                subtitle: Text(profile[keys1[index]].toString()),
              );
            }));
  }
}
