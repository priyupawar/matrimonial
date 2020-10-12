import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matrimonial/main.dart';
import 'package:matrimonial/profile.dart';
//import 'package:myproject/authform.dart';
//import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  final email;

  SplashScreen(this.email);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const routeName = '/splashscreen';
  @override
  void initState() {
    setCurrentRoute(routeName);
    super.initState();
    Timer(
        Duration(seconds: 3),
        () =>
            //Navigator.of(context).pushReplacement(

            //     PageTransition(
            //         type: PageTransitionType.fade,
            //         child: MainPage()))
            Navigator.pushReplacementNamed(context, '/profile',
                arguments: widget.email));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.3,
                      0.7,
                      0.9,
                    ],
                    colors: [
                      Colors.deepPurple,
                      Colors.deepPurpleAccent,
                      Colors.white,
                    ]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/ring.png'))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Christi Jeevan Sathi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Suchak Kendra',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        child: FlareActor(
                          'assets/loading_spinner.flr',
                          animation: "loadingspinner",
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Center(
                          child: Text(
                        'Loading...',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
