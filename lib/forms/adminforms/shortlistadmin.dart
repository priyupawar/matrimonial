import 'package:flutter/material.dart';
import 'package:matrimonial/forms/adminforms/adminview.dart';
import 'package:matrimonial/services/shortist_service.dart';

class AdminShortlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shortlist'),
        ),
        body: FutureBuilder(
          future: getAllShortlist(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    //  return Text(snapshot.data[index].documentID);
                    //  print(snapshot.data[index]['shortlist_id']);
                    return FutureBuilder(
                        future: getPhoneno(snapshot.data[index].documentID),
                        builder: (context, snapshot2) {
                          if (snapshot2.hasData) {
                            // print('snapshot2');
                            //print(snapshot2.data['Mobile']);
                            return ExpansionTile(
                              title: Text(snapshot.data[index].documentID),
                              children: returnList(
                                  snapshot.data[index]['shortlist_id'],
                                  context,
                                  snapshot2.data['Mobile']),
                            );
                          } else {
                            return ExpansionTile(
                              title: Text(snapshot.data[index].documentID),
                              children: returnList(
                                  snapshot.data[index]['shortlist_id'],
                                  context,
                                  ''),
                            );
                          }
                        });
                  });
            } else {
              return Center(child: Text('No Data Present'));
            }

            //return Text('hello);
          },
        ));
  }
}

returnList(List data, context, mobile) {
  List<Widget> widgetlist = [];
  for (int i = 0; i < data.length; i++) {
    widgetlist.add(RaisedButton(
        onPressed: () async {
          var profile = await getSpecificProfile(data[i]);
          Navigator.pushNamed(context, '/profileview',
              arguments: {"profile": profile, "admin": true, "mobile": mobile});
        },
        child: ListTile(
          title: Text(data[i]),
        )));
  }
  return widgetlist;
}

// getData(email) {
//   return FutureBuilder(
//       future: getSpecificProfile(email),
//       builder: (context, snapshot) {
//      //   print(snapshot);
//         return Text('');
//       });
// }
