import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial/widget/buttonform.dart';
import 'package:matrimonial/widget/datepicker.dart';
import 'package:matrimonial/widget/textform.dart';
import 'package:matrimonial/widget/imageupload.dart';

TextEditingController _name;
TextEditingController _email;
TextEditingController _mobile;
TextEditingController _address;
TextEditingController _city;
TextEditingController _state;
TextEditingController _pincode;
TextEditingController _about;
TextEditingController _bio;
TextEditingController _age;
bool genderpresent = false;
String agevalue;
List status = ['UnMarried', 'Divorce'];
List gender = ['Male', 'Female'];
String martialstatus = 'UnMarried';
String gendervalue = 'Male';
String url1;
String url2;
String url3;
TextInputType textinput = TextInputType.text;
GlobalKey<FormState> _userKey1 = GlobalKey<FormState>();

Map<String, String> values = {};

class UserForm extends StatefulWidget {
  final profile;
  UserForm(this.profile);
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  void initState() {
    setState(() {
      values = {
        'Name': widget.profile['Name'],
        'DOB': widget.profile['DOB'],
        'Email': widget.profile['Email'],
        'Mobile': widget.profile['Mobile'].toString(),
        'Address': widget.profile['Address'],
        'City': widget.profile['City'],
        'State': widget.profile['State'],
        'Pincode': widget.profile['Pincode'].toString(),
        'Status': widget.profile['Status'],
        "image1": widget.profile['image1'],
        "image2": widget.profile['image2'],
        "image3": widget.profile['image3'],
        "About Yourself": widget.profile['About Yourself'],
        "Hobbies": widget.profile['Hobbies'],
        "Bio Headline": widget.profile['Bio Headline'],
        "Age": widget.profile['Age'].toString(),
        "Gender": widget.profile['Gender'],
      };
    });
    if (widget.profile['Status'] != '') {
      martialstatus = widget.profile['Status'];
    }
    if (widget.profile['Gender'] != '') {
      gendervalue = widget.profile['Gender'];
      genderpresent = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: Form(
                key: _userKey1,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextBox(
                            _bio,
                            'Bio Headline',
                            'text',
                            TextInputType.text,
                            values,
                            1,
                            values['Bio Headline'])),
                    TextBox(_name, 'Name', 'text', TextInputType.text, values,
                        1, values['Name']),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.cake),
                              DatePickerForm('DOB', values),
                              // Expanded(
                              //     child: TextBox(_age, 'Age', 'text',
                              //         TextInputType.number, values, 1, agevalue)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.person),
                          SizedBox(
                            width: 10,
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
                                : Text(
                                    gendervalue), // Not necessary for Option 1
                            // value: dropText,
                            elevation: 16,
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
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
                                values.update('Gender', (v) {
                                  return gendervalue;
                                });
                                // print(textedit);
                                //getComboData2(reportDetails[0]['CBO_2_QRY'].toString(), name1);
                              });
                            },
                            value: gendervalue,
                          ),
                        ],
                      ),
                    ),
                    TextBox(_email, 'Email', 'email',
                        TextInputType.emailAddress, values, 1, values['Email']),
                    TextBox(_mobile, 'Mobile', 'mobile', TextInputType.number,
                        values, 1, values['Mobile']),
                    TextBox(_address, 'Address', 'text',
                        TextInputType.multiline, values, 2, values['Address']),
                    Wrap(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextBox(_city, 'City', 'text',
                                TextInputType.text, values, 1, values['City'])),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextBox(
                                _state,
                                'State',
                                'text',
                                TextInputType.text,
                                values,
                                1,
                                values['State'])),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: TextBox(
                                _pincode,
                                'Pincode',
                                'text',
                                TextInputType.number,
                                values,
                                1,
                                values['Pincode'])),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.home),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Marital Status:',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                            //isExpanded: true,
                            // icon: Icon(Icons.ac_unit),
                            //style: Theme.of(context).textTheme.title,
                            hint:
                                Text('Status: '), // Not necessary for Option 1
                            // value: dropText,
                            elevation: 16,
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            items: status.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String newValue1) {
                              setState(() {
                                martialstatus = newValue1;
                                //updateCombo(widget.textedit, widget.name, comboName);
                                values.update('Status', (v) {
                                  return martialstatus;
                                });
                                // print(textedit);
                                //getComboData2(reportDetails[0]['CBO_2_QRY'].toString(), name1);
                              });
                            },
                            value: martialstatus,
                          ),
                        ],
                      ),
                    ),
                    ImageUpload(values),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextBox(
                            _about,
                            'About Yourself',
                            'text',
                            TextInputType.text,
                            values,
                            1,
                            values['About Yourself'])),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextBox(_about, 'Hobbies', '',
                            TextInputType.text, values, 1, values['Hobbies'])),
                    ButtonForm('Submit', 'user_update', values, _userKey1)
                  ],
                ))));
  }
}
