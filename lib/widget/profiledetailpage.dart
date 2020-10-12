import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter/services.dart';
import 'package:matrimonial/services/auth_service.dart';

bool admin = false;
var number;
getAdmin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  admin = prefs.getBool('isAdmin');
}

getPhone(email) {
  print(getPhoneno(email));
}

Widget personal(profile) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Personal Information:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Card(
              child: Column(
            children: <Widget>[
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: ListTile(
                      title: Text('Name'),
                      subtitle: Text(profile['Name']),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      title: Text('Status'),
                      subtitle: Text(profile['Status']),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: ListTile(
                      title: Text('Age'),
                      subtitle: Text(profile['Age'].toString()),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      title: Text('DOB'),
                      subtitle: Text(profile['DOB']),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      title: Text('Gender'),
                      subtitle: Text(profile['Gender']),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: ListTile(
                      title: Text('Height(feet)'),
                      subtitle: Text(profile['Height'].toString()),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ListTile(
                      title: Text('Weight(kg)'),
                      subtitle: Text(profile['Weight'].toString()),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      title: Text('Complexion'),
                      subtitle: Text(profile['Complexion'].toString()),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: ListTile(
                      title: Text('Address'),
                      subtitle: Text(profile['Address'] +
                          ',' +
                          profile['City'] +
                          ',' +
                          profile['State'].toUpperCase() +
                          ',' +
                          profile['Pincode'].toString()),
                    ),
                  ),
                ],
              ),
            ],
          ))
        ],
      ));
}

Widget education(profile) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Other Information:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Card(
              child: Column(
            children: <Widget>[
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: ListTile(
                      title: Text('Education'),
                      subtitle: Text(profile['Education']),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: ListTile(
                      title: Text('Profession'),
                      subtitle: Text(profile['Profession'].toString()),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      title: Text('Jobtype'),
                      subtitle: Text(profile['Jobtype'].toString()),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      title: Text('Salary(per annum)'),
                      subtitle: Text(profile['Salary'].toString()),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      title: Text('Hobbies'),
                      subtitle: Text(profile['Hobbies'].toString()),
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     Flexible(
              //       flex: 3,
              //       child: ListTile(
              //         title: Text('Church Name & Address'),
              //         subtitle: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Text(profile['Church Name']),
              //             Text(profile['Church Address'])
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      title: Text('Expectations'),
                      subtitle: Text(profile['Expectations'].toString()),
                    ),
                  ),
                ],
              ),
            ],
          ))
        ],
      ));
}

Widget contact(profile) {
  getAdmin();
  getPhone(profile['Email']);
  return admin
      ? FutureBuilder(
          future: getPhoneno(profile['Email']),
          builder: (context, snapshot) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Contact Information:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Card(
                        child: Column(
                      children: <Widget>[
                        Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 3,
                                child: ListTile(
                                  title: Text('Mobile No.'),
                                  subtitle: Text(profile['Mobile'].toString()),
                                ),
                              ),
                            ]),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: ListTile(
                                title: Text('Email'),
                                subtitle: Text(profile['Email'].toString()),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 3,
                              child: ListTile(
                                title: Text('Church Name & Address'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(profile['Church Name']),
                                    Text(profile['Church Address'])
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Center(
                                child: RaisedButton(
                              child: Text('Send Contact Details'),
                              onPressed: () {
                                FlutterOpenWhatsapp.sendSingleMessage(
                                    "123", "Hello");
                              },
                            ))
                          ],
                        )
                      ],
                    ))
                  ],
                ));
          },
        )
      : Text('');
}

// var keys3 = ['Education', 'Profession', 'Jobtype', 'Status'];
// var keys4 = [
//   'Church Name',
//   'Church Address',
//   'Native',
//   'Mother Tounge',
//   'Exectations',
//   'Hobbies'
// ];
// List<Widget> list1 = [];

// class Profiles extends StatefulWidget {
//   @override
//   _ProfilesState createState() => _ProfilesState();
// }

// class _ProfilesState extends State<Profiles> {
//   final TextStyle dropdownMenuItem =
//       TextStyle(color: Colors.black, fontSize: 18);

//   final primary = Color(0xff696b9e);
//   final secondary = Color(0xfff29a94);
//   Widget body;
//   bool list = true;
//   bool page = false;

//   final List<Map> schoolLists = [
//     {
//       "name": "Edgewick Scchol",
//       "location": "572 Statan NY, 12483",
//       "type": "Higher Secondary School",
//       "logoText":
//           "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png",
//       "xyz": "Haward Play",
//       "haha": "572 Statan NY, 12483",
//       "akjs": "Play Group School",
//       "ahjsh":
//           "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png",
//       "amnxm": "Haward Play",
//       "kwekj": "572 Statan NY, 12483",
//       "bnxb": "Play Group School",
//       "ashhsj":
//           "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
//     },
//     {
//       "name": "Xaviers International",
//       "location": "234 Road Kathmandu, Nepal",
//       "type": "Higher Secondary School",
//       "logoText":
//           "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
//     },
//     {
//       "name": "Kinder Garden",
//       "location": "572 Statan NY, 12483",
//       "type": "Play Group School",
//       "logoText":
//           "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
//     },
//     {
//       "name": "WilingTon Cambridge",
//       "location": "Kasai Pantan NY, 12483",
//       "type": "Lower Secondary School",
//       "logoText":
//           "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
//     },
//     {
//       "name": "Fredik Panlon",
//       "location": "572 Statan NY, 12483",
//       "type": "Higher Secondary School",
//       "logoText":
//           "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
//     },
//     {
//       "name": "Whitehouse International",
//       "location": "234 Road Kathmandu, Nepal",
//       "type": "Higher Secondary School",
//       "logoText":
//           "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
//     },
//     {
//       "name": "Haward Play",
//       "location": "572 Statan NY, 12483",
//       "type": "Play Group School",
//       "logoText":
//           "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
//     },
//     {
//       "name": "Campare Handeson",
//       "location": "Kasai Pantan NY, 12483",
//       "type": "Lower Secondary School",
//       "logoText":
//           "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
//     },
//   ];

//   @override
//   void initState() {
//     body = buildList(schoolLists);
//     list = true;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         child: SingleChildScrollView(
//             child: Stack(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.only(top: 145),
//               height: MediaQuery.of(context).size.height,
//               width: double.infinity,
//               child: body,
//             ),
//             _customAppBar(),
//             Container(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     height: 110,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Material(
//                       elevation: 5.0,
//                       borderRadius: BorderRadius.all(Radius.circular(30)),
//                       child: TextField(
//                         // controller: TextEditingController(text: locations[0]),
//                         cursorColor: Theme.of(context).primaryColor,
//                         style: dropdownMenuItem,
//                         decoration: InputDecoration(
//                             hintText: "Search By Name",
//                             hintStyle:
//                                 TextStyle(color: Colors.black38, fontSize: 16),
//                             prefixIcon: Material(
//                               elevation: 0.0,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(30)),
//                               child: Icon(Icons.search),
//                             ),
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 25, vertical: 13)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         )),
//       ),
//     );
//   }

//   Widget _customAppBar() {
//     return PreferredSize(
//         preferredSize: Size(null, 100),
//         child: Container(
//           height: 140,
//           width: double.infinity,
//           decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30))),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     // Navigator.pushReplacement(context,
//                     //     MaterialPageRoute(builder: (context) => Sidenav()));
//                   },
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   "Profiles",
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       if (list) {
//                         body = pageView(schoolLists);
//                         page = true;
//                         list = false;
//                       } else {
//                         body = buildList(schoolLists);
//                         page = false;
//                         list = true;
//                       }
//                     });
//                   },
//                   icon: Icon(
//                     list ? Icons.apps : Icons.list,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

// Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: <Widget>[
//                                 CircleAvatar(
//                                   radius: 100.0,
//                                   backgroundImage: CachedNetworkImageProvider(
//                                       profile['logoText']),
//                                 ),
//                                 Text(
//                                   'Name: ' + profile['name'],
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Address: ' + profile['location'],
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Education: ' + profile['type'],
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Current Profession: ' + profile['type'],
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Salary: 2000Rs',
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   "Height: 5'20 ",
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Weight: ',
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Complexion: ',
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Resident: ' + profile['type'],
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Hobbies: ',
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Expectation: ' + profile['type'],
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                               ],
//                             )
