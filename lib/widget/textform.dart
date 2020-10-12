import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final TextEditingController _controller;
  final label;
  final validator;
  final TextInputType keyboardtype;
  final Map<String, String> values;
  final maxline;
  final value;

  TextBox(this._controller, this.label, this.validator, this.keyboardtype,
      this.values, this.maxline, this.value);
  @override
  _TextBoxState createState() => _TextBoxState();
}

textvalidator(value) {
  {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}

class _TextBoxState extends State<TextBox> {
  String name;
  @override
  void initState() {
    //print(widget._controller);
    //widget._controller.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          maxLines: widget.maxline,
          keyboardType: widget.keyboardtype,
          //controller: widget._controller,
          initialValue: widget.value,
          validator: (value) {
            if (widget.validator == 'email') {
              if (!EmailValidator.Validate(value)) {
                return 'Not a proper email id';
              }
            }
            if (widget.validator == 'mobile') {
              if (value.length != 10) {
                return 'Mobile No. should be 10 digits';
              }
            }
            if (widget.validator == 'text') {
              if (value.isEmpty) {
                return 'Field cannot be empty';
              }
            }

            if (widget.validator == 'pass') {
              if (value.length != 8) {
                return 'The password is too short must be at least 8 characters.';
              }
            }
            return null;
          },
          onChanged: (String value) {
            setState(() {
              name = value;

              widget.values.update(widget.label, (v) {
                return name;
              });
            });
          },
          decoration: InputDecoration(
            // border: UnderlineInputBorder(borderSide: BorderSide.none),
            icon: Icon(Icons.person),
            labelText: widget.label.toString(),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
          ),
        ));
  }
}
