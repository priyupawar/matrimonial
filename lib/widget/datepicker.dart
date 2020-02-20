import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime selecteddate = new DateTime.now();
String _date1;
String error = '';

class DatePickerForm extends StatefulWidget {
  final name;
  final textedit;
  DatePickerForm(this.name, this.textedit);
  @override
  _DatePickerFormState createState() => _DatePickerFormState();
}

updateDate(name, value, textedit, year) {
  textedit.update(name, (v) {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(value.toString()));
  });
  textedit.update('Age', (v) {
    return (DateTime.now().year - year).toString();
  });
  return DateTime.now().year - year;
}

class _DatePickerFormState extends State<DatePickerForm> {
  Future selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selecteddate,
      firstDate: new DateTime(1600, 1, 1),
      lastDate: new DateTime(DateTime.now().year, 12, 31),
    );
    if (picked != null) {
      setState(() {
        // textedit.update(widget.name, (v) {
        //   return DateFormat("dd-MMM-yy")
        //       .format(DateTime.parse(picked.toString()));
        // });
        updateDate(widget.name, picked, widget.textedit, picked.year);

        selecteddate = picked;
        _date1 =
            DateFormat("dd/MM/yyyy").format(DateTime.parse(picked.toString()));
      });
    }
  }

  @override
  void initState() {
    setState(() {
      if (widget.textedit['DOB'] != '') {
        _date1 = widget.textedit['DOB'];
        var date = _date1.split('/');
        selecteddate = new DateTime(
            int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));
        print(selecteddate);
      } else {
        selecteddate = DateTime.now();
        updateDate(
            widget.name, selecteddate, widget.textedit, selecteddate.year);
        _date1 = DateFormat("dd/MM/yyyy")
            .format(DateTime.parse(DateTime.now().toString()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return datePicker();
  }

  Widget datePicker() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      // child: RaisedButton(
      //   shape:
      //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      //   elevation: 6.0,
      //   onPressed: () {
      //     selectDate1(context);
      //   },
      child: Container(
        alignment: Alignment.center,
        height: 80.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            selectDate1(context);
                          },
                          child: Text(
                            " $_date1",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          )),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
      //   color: Colors.white,
      // )
    );
  }
}
