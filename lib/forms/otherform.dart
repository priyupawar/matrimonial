import 'package:flutter/material.dart';
import 'package:matrimonial/widget/buttonform.dart';
import 'package:matrimonial/widget/datepicker.dart';
import 'package:matrimonial/widget/textform.dart';

TextEditingController _native;
TextEditingController _language;
TextEditingController _cname;
TextEditingController _caddress;
TextEditingController _residence;
TextEditingController _mothertounge;
TextEditingController _hobbies;
TextEditingController _height;
TextEditingController _weight;
TextEditingController _complexion;
TextEditingController _expectation;
String residentvalue = 'Own House';
int id = 0;
List resident = ['Own House', 'Flat', 'Rented'];
TextInputType textinput = TextInputType.text;
GlobalKey<FormState> _userKey3 = GlobalKey<FormState>();

Map<String, String> values = {};

class OtherDetails extends StatefulWidget {
  final profile;
  OtherDetails(this.profile);
  @override
  _OtherDetailsState createState() => _OtherDetailsState();
}

class _OtherDetailsState extends State<OtherDetails> {
  @override
  void initState() {
    setState(() {
      if (widget.profile['Resident'] != '') {
        residentvalue = widget.profile['Resident'];
      }
      values = {
        'Email': widget.profile['Email'],
        'Native Place': widget.profile['Native Place'],
        'Church Name': widget.profile['Church Name'],
        'Church Address': widget.profile['Church Address'],
        'Resident': residentvalue,
        'Mother Tounge': widget.profile['Mother Tounge'],
        'Height(in feet)': widget.profile['Height(in feet)'],
        'Weight(in kg)': widget.profile['Weight(in kg)'],
        'Complexion': widget.profile['Complexion'],
        'Expectation': widget.profile['Expectation']
      };
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: Form(
                key: _userKey3,
                child: Column(
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextBox(
                                _height,
                                'Height(in feet)',
                                'text',
                                TextInputType.text,
                                values,
                                1,
                                values['Height(in feet)'])),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextBox(
                                _weight,
                                'Weight(in kg)',
                                'text',
                                TextInputType.text,
                                values,
                                1,
                                values['Weight(in kg)'].toString())),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: TextBox(
                                _complexion,
                                'Complexion',
                                'text',
                                TextInputType.text,
                                values,
                                1,
                                values['Complexion'])),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: TextBox(
                                _mothertounge,
                                'Mother Tounge',
                                'text',
                                TextInputType.text,
                                values,
                                1,
                                values['Mother Tounge'])),
                      ],
                    ),
                    TextBox(_native, 'Native Place', 'text', TextInputType.text,
                        values, 1, values['Native Place']),
                    TextBox(_cname, 'Church Name', 'text', TextInputType.text,
                        values, 1, values['Church Name']),
                    TextBox(
                        _caddress,
                        'Church Address',
                        'text',
                        TextInputType.text,
                        values,
                        2,
                        values['Church Address']),
                    Padding(
                      padding: EdgeInsets.all(0),
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
                            'Resident:',
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
                                Text('Resident'), // Not necessary for Option 1
                            // value: dropText,
                            elevation: 16,
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            items: resident.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String newValue1) {
                              setState(() {
                                residentvalue = newValue1;
                                //updateCombo(widget.textedit, widget.name, comboName);
                                values.update('Resident', (v) {
                                  return residentvalue;
                                });
                                // print(textedit);
                                //getComboData2(reportDetails[0]['CBO_2_QRY'].toString(), name1);
                              });
                            },
                            value: residentvalue,
                          ),
                        ],
                      ),
                    ),
                    TextBox(_expectation, 'Expectation', 'text',
                        TextInputType.text, values, 3, values['Expectation']),
                    ButtonForm('Submit', 'update_home', values, _userKey3)
                  ],
                ))));
  }
}
