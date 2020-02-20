import 'package:flutter/material.dart';
import 'package:matrimonial/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final _name = TextEditingController();

final _pass = TextEditingController();

final _retype = TextEditingController();
final GlobalKey<FormState> _loginKey = new GlobalKey<FormState>();
String name;
String password;
String retype;
bool match = false;
SharedPreferences prefs;
bool _obscureText1 = true;
bool _obscureText2 = true;

class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResetPassword();
  }
}

class _ResetPassword extends State<ResetPassword> {
  @override
  void initState() {
    // SharedPreferences.getInstance().then((SharedPreferences prefs) {
    //   _name.text = prefs.getString('email');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Password'),
        ),
        body: Padding(
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
            child: Form(
                key: _loginKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("Reset Password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor)))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: TextFormField(
                                    controller: _name,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      setState(() {
                                        name = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      icon: Icon(Icons.person),
                                      hintText: "Email Id.",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 18.0),
                                    ),
                                  ))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Text("Password",
                          //     style: TextStyle(
                          //         fontFamily: "Poppins-Medium", fontSize: 20)),
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: TextFormField(
                                    controller: _pass,
                                    obscureText: _obscureText1,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        icon: Icon(Icons.security),
                                        suffixIcon: GestureDetector(
                                          child: Icon(_obscureText1
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onTap: () {
                                            setState(() {
                                              _obscureText1 = !_obscureText1;
                                            });
                                          },
                                        ),
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.0)),
                                  ))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Text("Password",
                          //     style: TextStyle(
                          //         fontFamily: "Poppins-Medium", fontSize: 20)),
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: TextFormField(
                                    controller: _retype,
                                    obscureText: _obscureText2,
                                    validator: (value) {
                                      if (_pass.text != _retype.text) {
                                        return 'Password not matched';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      setState(() {
                                        retype = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        icon: Icon(Icons.security),
                                        suffixIcon: GestureDetector(
                                          child: Icon(_obscureText2
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onTap: () {
                                            setState(() {
                                              _obscureText2 = !_obscureText2;
                                            });
                                          },
                                        ),
                                        hintText: "Retype Password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.0)),
                                  ))),
                        ],
                      ),
                      InkWell(
                          child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 10),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).accentColor,
                                    ]),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color(0xFF6078ea).withOpacity(.3),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 8.0)
                                    ]),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      if (_loginKey.currentState.validate()) {
                                        updatepass(_name.text, _retype.text);
                                      }
                                    },
                                    child: Center(
                                      child: Text("Reset",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ))),
                    ]))));
  }
}
