import 'package:flutter/material.dart';
import 'package:matrimonial/forms/infotabs.dart';
import 'package:matrimonial/forms/payments.dart';
import 'package:matrimonial/forms/resetpass.dart';
import 'package:matrimonial/forms/shortlist.dart';
import 'package:matrimonial/homepage.dart';
import 'package:matrimonial/profile.dart';
import 'package:matrimonial/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
String currRoute;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getCurrentRoute();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // home: HomePage(),
      initialRoute: isLoggedIn ? '/' : currRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

setCurrentRoute(String routeName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('curRoute', routeName);
}

getCurrentRoute() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('isLoggedIn');
  currRoute = prefs.getString('curRoute');
}
