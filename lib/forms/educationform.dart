import 'package:flutter/material.dart';
import 'package:matrimonial/widget/buttonform.dart';
import 'package:matrimonial/widget/textform.dart';

TextEditingController _education;
TextEditingController _profesion;
TextEditingController _salary;
int _groupValue = -1;
List jobtype = ['Gov.', 'Non Gov.', 'Business'];
String jobvalue;
GlobalKey<FormState> _userKey2 = GlobalKey<FormState>();
TextInputType textinput = TextInputType.text;

Map<String, String> values = {};

class EducationForm extends StatefulWidget {
  final profile;
  EducationForm(this.profile);
  @override
  _EducationFormState createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  @override
  void initState() {
    setState(() {
      values = {
        'Email': widget.profile['Email'],
        'Education': widget.profile['Education'],
        'Profession': widget.profile['Profession'],
        'Jobtype': widget.profile['Jobtype'],
        'Salary': widget.profile['Salary'].toString(),
      };
    });
    if (widget.profile['Jobtype'] != '') {
      jobvalue = widget.profile['Jobtype'];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: Form(
                key: _userKey2,
                child: Column(
                  children: <Widget>[
                    TextBox(_education, 'Education', 'text', TextInputType.text,
                        values, 1, values['Education']),
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
                            'Job Type:',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                            //isExpanded: true,
                            // icon: Icon(Icons.ac_unit),
                            //style: Theme.of(context).textTheme.title,
                            hint: Text('type'), // Not necessary for Option 1
                            // value: dropText,
                            elevation: 16,
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            items: jobtype.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String newValue1) {
                              setState(() {
                                jobvalue = newValue1;
                                //updateCombo(widget.textedit, widget.name, comboName);
                                values.update('Jobtype', (v) {
                                  return jobvalue;
                                });
                                // print(textedit);
                                //getComboData2(reportDetails[0]['CBO_2_QRY'].toString(), name1);
                              });
                            },
                            value: jobvalue,
                          ),
                        ],
                      ),
                    ),
                    TextBox(_profesion, 'Profession', 'text',
                        TextInputType.text, values, 1, values['Profession']),
                    TextBox(_salary, 'Salary', 'text', TextInputType.number,
                        values, 1, values['Salary'].toString()),
                    ButtonForm('Submit', '', values, _userKey2)
                  ],
                ))));
  }
}
