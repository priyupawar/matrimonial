import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
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
Map<String, dynamic> user = {};
bool genderpresent = false;
List gender = ['Male', 'Female'];
String gendervalue = 'Male';

class FillForm extends StatefulWidget {
  @override
  _FillFormState createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    _pass.text = _name.text.split(' ')[0].toLowerCase() + '@123';
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
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
                                  keyboardType: TextInputType.text,
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
                                    if (value.length < 8) {
                                      print(value.length);
                                      return 'Password must be at least 8 characters.';
                                    }

                                    return null;
                                  },
                                  onChanged: (String value) {
                                    setState(() {
                                      print(value.length);
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
                                  keyboardType: TextInputType.emailAddress,
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
                      Text(
                        'Gender:',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        //isExpanded: true,
                        // icon: Icon(Icons.ac_unit),
                        //style: Theme.of(context).textTheme.title,
                        hint: gendervalue == null
                            ? Text('Gender')
                            : Text(gendervalue), // Not necessary for Option 1
                        // value: dropText,
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).accentColor),
                        items: !genderpresent
                            ? gender.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(value),
                                );
                              }).toList()
                            : null,
                        onChanged: (String newValue1) {
                          setState(() {
                            gendervalue = newValue1;
                            //updateCombo(widget.textedit, widget.name, comboName);
                            // values.update('Gender', (v) {
                            //   return gendervalue;
                            // });
                            // print(textedit);
                            //getComboData2(reportDetails[0]['CBO_2_QRY'].toString(), name1);
                          });
                        },
                        value: gendervalue,
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
                          child: Center(
                              child: RaisedButton(
                                  child: Text('Check Mobile No.'),
                                  onPressed: () {
                                    FlutterOpenWhatsapp.sendSingleMessage(
                                        '91' + _mobile.text, 'hii');
                                  }))),
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
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF6078ea)
                                                  .withOpacity(.3),
                                              offset: Offset(0.0, 8.0),
                                              blurRadius: 8.0)
                                        ]),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          if (_userKey4.currentState
                                              .validate()) {
                                            // print(user);
                                            getUser(
                                              user = {
                                                "Form_Type": 'not filled',
                                                "Name": _name.text,
                                                "Email": _email.text,
                                                "Pass": _pass.text,
                                                "Mobile":
                                                    int.parse(_mobile.text),
                                                "DOB": '',
                                                "Address": '',
                                                "City": '',
                                                "State": '',
                                                "Pincode": '',
                                                "Status": '',
                                                "Education": '',
                                                "Jobtype": '',
                                                "Job": '',
                                                "Salary(per annum)": '',
                                                "Height(in feet)": '',
                                                "Weight(in kg)": '',
                                                "Complexion": '',
                                                "Native": '',
                                                "Church Name": '',
                                                "Church Address": '',
                                                "Resident": '',
                                                "Expectation": '',
                                                "Mother Tounge": '',
                                                "Profession": '',
                                                "image1":
                                                    'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
                                                "image2":
                                                    'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
                                                "image3":
                                                    'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
                                                "Bio Headline": '',
                                                "About Yourself": '',
                                                "Age": '',
                                                "Gender": gendervalue
                                              },
                                              context,
                                              remember,
                                            );

                                            // //print(_userKey.currentContext);
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
                                                      fontFamily:
                                                          "Poppins-Bold",
                                                      fontSize: 20,
                                                      letterSpacing: 1.0))),
                                        ),
                                      ),
                                    ),
                                  )))),
                      Center(
                          child: RaisedButton(
                        child: Text('Clear'),
                        onPressed: () {
                          _pass.text = '@123';
                          _name.text = '';
                          _email.text = '';
                          _mobile.text = '';
                        },
                      ))
                    ]))));
    //);
  }
}
