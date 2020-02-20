import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:matrimonial/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matrimonial/services/auth_service.dart';

GlobalKey<FormState> _userKey4 = GlobalKey<FormState>();
final _name = TextEditingController();
final _pass = TextEditingController();
final _email = TextEditingController();
final _mobile = TextEditingController();
String name;
String pass;
String fileName;
String filepath;
bool remember = false;

Map<String, dynamic> user = {
  "name": '',
  "email": '',
  "pass": '',
  "mobile": 0,
  "dob": '',
  "address": '',
  "city": '',
  "state": '',
  "pincode": 0,
  "status": '',
  "education": '',
  "jobtype": '',
  "job": '',
  "salary": 0,
  "height": '',
  "weight": 0,
  "complexion": '',
  "native": '',
  "churchname": '',
  "churchaddress": '',
  "resident": '',
  "expectation": '',
  "mother tounge": ''
};

class RegisterForm extends StatefulWidget {
  // final scaffoldkey;
  // RegisterForm(this.scaffoldkey);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Card(
    //     elevation: 30,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(15.0),
    //     ),
    //     child:
    return Padding(
        padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
        child: Form(
            key: _userKey4,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor)),
                      )),
                  Flexible(
                      flex: 2,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              controller: _name,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Field cannot be empty';
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
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18.0)),
                            ),
                          ))),
                  Flexible(
                    flex: 2,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              controller: _pass,
                              obscureText: _obscureText,
                              validator: (value) {
                                if (value.length != 8) {
                                  return 'Password must be at least 8 characters.';
                                }

                                return null;
                              },
                              onChanged: (String value) {
                                setState(() {
                                  pass = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  icon: Icon(Icons.security),
                                  suffixIcon: GestureDetector(
                                    child: Icon(_obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18.0)),
                            ))),
                  ),
                  Flexible(
                    flex: 2,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              controller: _email,
                              validator: (value) =>
                                  !EmailValidator.Validate(value, true)
                                      ? 'Not a valid Email'
                                      : null,
                              onChanged: (String value) {
                                setState(() {
                                  pass = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  icon: Icon(Icons.email),
                                  hintText: "Email Id",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18.0)),
                            ))),
                  ),
                  Flexible(
                    flex: 2,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _mobile,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Field cannot be empty';
                                }
                                return null;
                              },
                              onChanged: (String value) {
                                setState(() {
                                  pass = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  icon: Icon(Icons.mobile_screen_share),
                                  hintText: "Mobile No.",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18.0)),
                            ))),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 12.0,
                              ),
                              Checkbox(
                                value: remember,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    remember = newValue;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text("Remember me",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Poppins-Medium"))
                            ],
                          ),
                        ]),
                  ),
                  Flexible(
                      flex: 2,
                      child: InkWell(
                          child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Container(
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
                                      if (_userKey4.currentState.validate()) {
                                        getUser(
                                          user = {
                                            "Name": _name.text,
                                            "Email": _email.text,
                                            "Pass": _pass.text,
                                            "Mobile": int.parse(_mobile.text),
                                            "DOB": '',
                                            "Address": '',
                                            "City": '',
                                            "State": '',
                                            "Pincode": 0,
                                            "Status": '',
                                            "Education": '',
                                            "Jobtype": '',
                                            "Job": '',
                                            "Salary": 0,
                                            "Height": '',
                                            "Weight": 0,
                                            "Complexion": '',
                                            "Native": '',
                                            "Church Name": '',
                                            "Church Address": '',
                                            "Resident": '',
                                            "Expectation": '',
                                            "Mother Tounge": '',
                                            "image1":
                                                'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
                                            "image2":
                                                'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
                                            "image3":
                                                'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
                                            "Bio Headline": '',
                                            "Age": '',
                                            "Gender": ''
                                          },
                                          context,
                                          remember,
                                        );

                                        //print(_userKey.currentContext);
                                        //login(_name.text, _pass.text);
                                        //}
                                      }
                                    },
                                    child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text("Register",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins-Bold",
                                                  fontSize: 20,
                                                  letterSpacing: 1.0))),
                                    ),
                                  ),
                                ),
                              )))),
                ])));
    //);
  }
}
