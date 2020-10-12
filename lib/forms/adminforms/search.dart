import 'package:flutter/material.dart';
import 'package:matrimonial/main.dart';

class SearchProfile extends StatelessWidget {
  static const routeName = '/searchprofile';
  @override
  Widget build(BuildContext context) {
    setCurrentRoute(routeName);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Profiles'),
      ),
    );
  }
}
