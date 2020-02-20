import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial/services/shortist_service.dart';
import 'package:matrimonial/widget/profiledetailpage.dart';

final primary = Color(0xff696b9e);
final secondary = Color(0xfff29a94);
List profiles = [];
List shortlist = [];

class SwipeList extends StatefulWidget {
  final scaffoldkey;
  SwipeList(this.scaffoldkey);
  @override
  _SwipeListState createState() => _SwipeListState();
}

class _SwipeListState extends State<SwipeList> {
  @override
  Widget build(BuildContext context) {
    return swipeList();
  }

  Widget swipeList() {
    return FutureBuilder(
        future: getShortlist(),
        builder: (context, snapshot) {
          // print(snapshot.connectionState);
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            print('1');
            print(snapshot.data.data);
            if (snapshot.data.data != null &&
                snapshot.data.data['shortlist_id'].length > 0) {
              shortlist = snapshot.data.data['shortlist_id'].toList();
              return FutureBuilder(
                  future: getProfile(shortlist),
                  builder: (context, snapshot) {
                    // print(snapshot.connectionState);
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      //  print(snapshot.data.documents);

                      profiles = snapshot.data.documents;

                      return ListView.builder(
                          itemCount: profiles.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String item = profiles[index].toString();
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/profileview',
                                      arguments: profiles[index]);
                                  // showDialog()
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                  ),
                                  width: double.infinity,
                                  height: 110,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          // border: Border.all(width: 3, color: secondary),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  profiles[index]['image1']),
                                              fit: BoxFit.fitHeight),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                Icon(
                                                  Icons.location_on,
                                                  color: secondary,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    profiles[index]['Age']
                                                        .toString(),
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
                                                Icon(
                                                  Icons.school,
                                                  color: secondary,
                                                  size: 20,
                                                ),
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
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            removeProfile(
                                                [profiles[index]['Email']]);
                                          });
                                          // showDialog()
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: primary,
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          });
                    }
                  });
            } else {
              return Center(
                child: Text('Your list is empty'),
              );
            }
          }
        });
  }
}
