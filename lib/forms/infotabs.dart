import 'package:flutter/material.dart';
import 'package:matrimonial/forms/educationform.dart';
import 'package:matrimonial/forms/otherform.dart';
import 'package:matrimonial/forms/userform.dart';
import 'package:matrimonial/main.dart';

class InfoTabs extends StatefulWidget {
  final profile;

  InfoTabs(this.profile);
  @override
  _InfoTabsState createState() => _InfoTabsState();
}

class _InfoTabsState extends State<InfoTabs> {
  static const routeName = '/infotabs';
  int _currentTabIndex = 0;
  static const _kBottmonNavBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Personal')),
    BottomNavigationBarItem(
        icon: Icon(Icons.import_contacts), title: Text('Professional')),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_balance), title: Text('Other')),
  ];

  @override
  void initState() {
    setCurrentRoute(routeName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).accentColor,
        selectedItemColor: Theme.of(context).accentColor,
        items: _kBottmonNavBarItems,
        currentIndex: _currentTabIndex,
        onTap: (int index) {
          setState(() => this._currentTabIndex = index);
        },
      ),
      body: IndexedStack(
        children: <Widget>[
          UserForm(widget.profile),
          EducationForm(widget.profile),
          OtherDetails(widget.profile),
        ],
        index: _currentTabIndex,
      ),
    );
  }
}
