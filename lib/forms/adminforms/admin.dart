import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial/forms/searchprofile.dart';
import 'package:matrimonial/main.dart';
import 'package:matrimonial/widget/list.dart';
import 'package:matrimonial/widget/sidenav.dart';

bool search = false;
String type;
String textvalue;
String searchby;

class AdminForm extends StatefulWidget {
  final email;
  AdminForm(this.email);
  @override
  _AdminFormState createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  static const routeName = '/admin';
  @override
  void initState() {
    setCurrentRoute(routeName);
    type = 'all';
    textvalue = '';
    searchby = 'Name';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profiles'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  search = !search;
                });
                // Navigator.pushNamed(context, '/searchprofile');
              },
              child: !search
                  ? Icon(Icons.search)
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          search = !search;
                          type = 'all';
                        });
                      },
                      child: Padding(
                          padding: EdgeInsets.all(10), child: Text('Clear'))),
            ),
          )
        ],
      ),
      drawer: Sidenav(widget.email, true),
      body: Column(
        children: <Widget>[
          search
              ? Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  // color: Colors.grey.withOpacity(0),
                  child: TextField(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        // contentPadding: EdgeInsets.all(10),
                        hintStyle: TextStyle(fontSize: 18),
                        hintText: 'Search By ' + searchby,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        type = 'search';
                                        searchby = 'Name';
                                      });
                                    },
                                    child: ListTile(title: Text('By Name'))),
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        type = 'search';
                                        searchby = 'Age';
                                      });
                                    },
                                    child: ListTile(title: Text('By Age'))),
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        type = 'search';
                                        searchby = 'Gender';
                                      });
                                    },
                                    child: ListTile(title: Text('By Gender'))),
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        type = 'search';
                                        searchby = 'City';
                                      });
                                    },
                                    child: ListTile(title: Text('By City'))),
                              ),
                            ];
                          },
                        ),
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    onChanged: (value) {
                      setState(() {
                        // buildList('', 'search', value, '');
                        type = 'search';
                        textvalue = value;
                      });
                    },
                  ),
                  margin: EdgeInsets.all(10),
                )
              : SizedBox(height: 10),
          Expanded(
            child: buildList('', type, textvalue, '', searchby),
          )
        ],
      ),
    );
  }
}
