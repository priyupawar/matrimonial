import 'package:flutter/material.dart';
import 'package:matrimonial/widget/list.dart';
import 'package:matrimonial/widget/sidenav.dart';

class AdminForm extends StatefulWidget {
  final email;
  AdminForm(this.email);
  @override
  _AdminFormState createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profiles'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.search),
            ),
          )
        ],
      ),
      drawer: Sidenav(widget.email, true),
      body: buildList('', 'all', '', ''),
    );
  }
}
