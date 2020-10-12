import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:matrimonial/main.dart';
import 'package:matrimonial/widget/swipeablelist.dart';

final List<Map> schoolLists = [
  {
    "name": "Edgewick Scchol",
    "location": "572 Statan NY, 12483",
    "type": "Higher Secondary School",
    "logoText":
        "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png",
    "xyz": "Haward Play",
    "haha": "572 Statan NY, 12483",
    "akjs": "Play Group School",
    "ahjsh":
        "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png",
    "amnxm": "Haward Play",
    "kwekj": "572 Statan NY, 12483",
    "bnxb": "Play Group School",
    "ashhsj":
        "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
  },
  {
    "name": "Xaviers International",
    "location": "234 Road Kathmandu, Nepal",
    "type": "Higher Secondary School",
    "logoText":
        "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
  },
  {
    "name": "Kinder Garden",
    "location": "572 Statan NY, 12483",
    "type": "Play Group School",
    "logoText":
        "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
  },
  {
    "name": "WilingTon Cambridge",
    "location": "Kasai Pantan NY, 12483",
    "type": "Lower Secondary School",
    "logoText":
        "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
  },
  {
    "name": "Fredik Panlon",
    "location": "572 Statan NY, 12483",
    "type": "Higher Secondary School",
    "logoText":
        "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
  },
  {
    "name": "Whitehouse International",
    "location": "234 Road Kathmandu, Nepal",
    "type": "Higher Secondary School",
    "logoText":
        "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
  },
  {
    "name": "Haward Play",
    "location": "572 Statan NY, 12483",
    "type": "Play Group School",
    "logoText":
        "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
  },
  {
    "name": "Campare Handeson",
    "location": "Kasai Pantan NY, 12483",
    "type": "Lower Secondary School",
    "logoText":
        "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
  },
];

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class ShortList extends StatefulWidget {
  @override
  _ShortListState createState() => _ShortListState();
}

class _ShortListState extends State<ShortList> {
  static const routeName = '/shortlist';
  @override
  void initState() {
    setCurrentRoute(routeName);
    // schoolLists.insert(0, {"name": 'Xaviers International', 'location': '234 Road Kathmandu, Nepal', 'type': 'Higher Secondary School', 'logoText': 'https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png'});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Shortlist'),
        ),
        body: SwipeList(_scaffoldKey));
  }
}
