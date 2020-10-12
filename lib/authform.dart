import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial/forms/login.dart';
import 'package:matrimonial/forms/register.dart';
import 'package:matrimonial/main.dart';
import 'package:matrimonial/profile.dart';
import 'package:matrimonial/services/auth_service.dart';
import 'package:matrimonial/widget/horizontalline.dart';

Widget body;
bool register = false;
bool login = true;
String display;
String btn;

class Authform extends StatefulWidget {
  @override
  _AuthformState createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  static const routeName = '/';
  @override
  void initState() {
    setCurrentRoute(routeName);
    super.initState();
    setState(() {
      body = LoginForm();
      display = "Dont have an account?";
      btn = " Register Now";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //key: _scaffoldKey1,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Flexible(
              flex: 8,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(350)),
                  image: DecorationImage(
                    image: AssetImage("assets/back1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FormCard() /* add child content here */,
              )),
          // Flexible(flex: 1, child: SizedBox(height: 70)),
          Flexible(
              flex: 1,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(100.0),
                      Text(
                        'Or',
                        style: TextStyle(fontSize: 20),
                      ),
                      horizontalLine(100.0),
                    ],
                  ))),
          Flexible(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text(
                          "Facebook",
                          style: TextStyle(fontSize: 18),
                        ),
                        textColor: Colors.white,
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        onPressed: () {
                          siginwithfacebook(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text(
                          "Google",
                          style: TextStyle(fontSize: 18),
                        ),
                        textColor: Colors.white,
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        onPressed: () {
                          siginwithgoogle(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          display,
                          style: TextStyle(fontSize: 20),
                        ),
                        FlatButton(
                          child: Text(
                            btn,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          textColor: Colors.indigo,
                          onPressed: () {
                            setState(() {
                              switch (body.toString()) {
                                case 'RegisterForm':
                                  body = LoginForm();
                                  display = 'Dont have an account? ';
                                  btn = "Register Now";
                                  break;
                                case 'LoginForm':
                                  body = RegisterForm();
                                  display = 'Have an account?';
                                  btn = "Login";
                              }
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}

class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 5,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 6,
                child: Padding(padding: EdgeInsets.all(15), child: body),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

// Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               horizontalLine(100.0),
//               Text(
//                 'Or',
//                 style: TextStyle(fontSize: 20),
//               ),
//               horizontalLine(100.0),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     switch (body.toString()) {
//                       case 'RegisterForm':
//                         body = LoginForm(_scaffoldKey);
//                         display = 'Register Now';
//                         break;
//                       case 'LoginForm':
//                         body = RegisterForm(_scaffoldKey);
//                         display = 'Login';
//                     }
//                   });
//                 },
//                 child: Text(
//                   display,
//                   style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontFamily: "Poppins-Medium",
//                       fontSize: 30),
//                 ),
//               )
//             ],
//           )
