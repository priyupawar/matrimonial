import 'package:matrimonial/forms/resetpass.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matrimonial/services/auth_service.dart';

final _loginKey = GlobalKey<FormState>();
final _name = TextEditingController();
final _pass = TextEditingController();
final _email = TextEditingController();
String name;
String pass;
bool remember = false;
String type;
String fileName;
String filepath;
String verificationId;
List<String> people = [];
List res;

class LoginForm extends StatefulWidget {
  // final scaffoldkey;
  // LoginForm(this.scaffoldkey);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        remember = prefs.getBool('remember');
        type = prefs.getString('type');
        if (remember == true && type == 'normal') {
          remember = true;
          name = prefs.getString('email');

          pass = prefs.getString('password');
        } else {
          prefs.setBool('remember', false);
          remember = false;
          name = '';
          pass = '';
        }
        _name.text = name;
        _pass.text = pass;
      });
    });
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
            key: _loginKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Poppins-Medium",
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor)))),
                          // Text("Username",
                          //     style: TextStyle(
                          //         fontFamily: "Poppins-Medium", fontSize: 20)),
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
                                      hintText: "Username",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 18.0),
                                    ),
                                  ))),
                        ],
                      )),
                  Flexible(
                      flex: 2,
                      child: Column(
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
                                    obscureText: _obscureText,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
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
                                            color: Colors.grey,
                                            fontSize: 18.0)),
                                  ))),
                        ],
                      )),
                  Flexible(
                    flex: 1,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                      flex: 1,
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
                                      if (_loginKey.currentState.validate()) {
                                        // firbaseLogin();
                                        login(
                                            _name.text,
                                            _pass.text,
                                            // widget.scaffoldkey,
                                            remember,
                                            context);
                                        //print(_userKey.currentContext);
                                        //login(_name.text, _pass.text);
                                      }
                                    },
                                    child: Center(
                                      child: Text("SIGNIN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              )))),
                  Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  // final snackBar = SnackBar(
                                  //   content:
                                  //       Text('Please contact System Administrator'),
                                  // );
                                  // widget.scaffoldkey.currentState
                                  //     .showSnackBar(snackBar);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => ResetPassword(),
                                  //     ));
                                  // Fluttertoast.showToast(
                                  //     msg: 'Please contact System Administrator',
                                  //     toastLength: Toast.LENGTH_LONG);
                                  //getConfig();
                                  // sendOtp('9004278382', context);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                            child: SimpleDialog(
                                          // shape: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(20)),
                                          title: Text(
                                            'Enter Your Registered Email Id.',
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
                                                  controller: _email,
                                                  decoration: InputDecoration(
                                                      hintText: 'Email Id.'),
                                                )),
                                              ],
                                            ),
                                            // Text(
                                            //     'Enter the OTP sent on your registered mobile number'),
                                            FlatButton(
                                              child: Text(
                                                'Get OTP',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                              onPressed: () {
                                                checkEmail(
                                                    _email.text, context);
                                                // Navigator.pop(context);
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           ResetPassword(),
                                                //     ));
                                              },
                                            )
                                          ],
                                        ));
                                      });
                                  //_sendSMS('Test Message', ['9004278382']);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: "Poppins-Medium",
                                      fontSize: 20),
                                ),
                              ))
                        ],
                      )),
                ])));
    //);
  }
}
