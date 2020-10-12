import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial/services/auth_service.dart';

onSubmit(value, navigator, context, formkey) {
  print(value);
  if (navigator == 'update_home') {
    if (formkey.currentState.validate()) {
      updateUser(value['Email'], value, context);
      Fluttertoast.showToast(
          msg: 'Profile Updated', toastLength: Toast.LENGTH_LONG);
      Navigator.pushNamed(context, '/profile', arguments: value['Email']);
    }
  }
  if (navigator == 'user_update') {
    if (formkey.currentState.validate()) {
      if (int.parse(value['Age']) < 18) {
        Fluttertoast.showToast(
            msg: 'Age Cannot be less than 18', toastLength: Toast.LENGTH_LONG);
      } else {
        updateUser(value['Email'], value, context);
        Fluttertoast.showToast(
            msg: 'Profile Updated', toastLength: Toast.LENGTH_LONG);
        //Navigator.pushNamed(context, '/profile', arguments: value['Email']);
      }
    }
  } else {
    if (formkey.currentState.validate()) {
      updateUser(value['Email'], value, context);
      Fluttertoast.showToast(
          msg: 'Profile Updated', toastLength: Toast.LENGTH_LONG);
    }
  }
}

class ButtonForm extends StatefulWidget {
  final name;
  final navigator;
  final values;
  final userkey;
  ButtonForm(this.name, this.navigator, this.values, this.userkey);
  @override
  _ButtonFormState createState() => _ButtonFormState();
}

class _ButtonFormState extends State<ButtonForm> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ]),
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.3),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 8.0)
                  ]),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    onSubmit(widget.values, widget.navigator, context,
                        widget.userkey);
                  },
                  child: Center(
                    child: Text(widget.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins-Bold",
                            fontSize: 18,
                            letterSpacing: 1.0)),
                  ),
                ),
              ),
            )));
  }
}
