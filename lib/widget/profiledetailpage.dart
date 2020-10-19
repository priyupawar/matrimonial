import 'package:flutter/material.dart';
import 'package:matrimonial/services/shortist_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter/services.dart';
import 'package:matrimonial/services/auth_service.dart';

bool admin = false;
var number;
final _mobile = TextEditingController();
getAdmin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  admin = prefs.getBool('isAdmin');
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

Widget contact(profile, mobile, context) {
  getAdmin();
  return admin
      ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Contact Information:',
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
                  Center(
                      child: RaisedButton(
                          color: Colors.indigo,
                          textColor: Colors.white,
                          child: Text('Send Contact Details'),
                          onPressed: () {
                            if (mobile == '') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      child: SimpleDialog(
                                    // shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(20)),
                                    title: Text(
                                      'Enter Mobile No.',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              // width: 200,
                                              child: TextField(
                                            controller: _mobile,
                                            decoration: InputDecoration(
                                                hintText: 'Mobile no.'),
                                          )),
                                        ],
                                      ),
                                      // Text(
                                      //     'Enter the OTP sent on your registered mobile number'),
                                      FlatButton(
                                        child: Text(
                                          'Send',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                        onPressed: () {
                                          FlutterOpenWhatsapp.sendSingleMessage(
                                              "91" + _mobile.text,
                                              "Name:" +
                                                  profile['Name'] +
                                                  " Phone No.:" +
                                                  profile['Mobile'].toString() +
                                                  "");
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                                },
                              );
                            } else {
                              FlutterOpenWhatsapp.sendSingleMessage(
                                  "91" + mobile,
                                  "Name:" +
                                      profile['Name'] +
                                      " Phone No.:" +
                                      profile['Mobile'].toString() +
                                      "");
                            }
                          }))
                ],
              ))
            ],
          ))
      : Text('');
}
