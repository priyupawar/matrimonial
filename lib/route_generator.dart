import 'package:flutter/material.dart';
import 'package:matrimonial/authform.dart';
import 'package:matrimonial/forms/adminforms/addprofile.dart';
import 'package:matrimonial/forms/adminforms/admin.dart';
import 'package:matrimonial/forms/adminforms/adminview.dart';
import 'package:matrimonial/forms/adminforms/search.dart';
import 'package:matrimonial/forms/infotabs.dart';
import 'package:matrimonial/forms/payments.dart';
import 'package:matrimonial/forms/resetpass.dart';
import 'package:matrimonial/forms/shortlist.dart';
import 'package:matrimonial/profile.dart';
import 'package:matrimonial/widget/notifications.dart';
import 'package:matrimonial/widget/splashscreen.dart';
import 'package:matrimonial/widget/profileview.dart';

import 'forms/adminforms/shortlistadmin.dart';

class ScreenArguments {
  final profile;
  final admin;

  ScreenArguments(this.profile, this.admin);
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    final args = setting.arguments;
    //final ScreenArguments screenargs = setting.arguments;
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(builder: (BuildContext context) => Authform());
      case '/profile':
        return MaterialPageRoute(
            builder: (BuildContext context) => MainPageProfile(args));
      case '/resetpass':
        return MaterialPageRoute(
            builder: (BuildContext context) => ResetPassword());
      case '/infotabs':
        return MaterialPageRoute(
            builder: (BuildContext context) => InfoTabs(args));
      case '/payments':
        return MaterialPageRoute(
            builder: (BuildContext context) => Payments(args));
      case '/shortlist':
        return MaterialPageRoute(
            builder: (BuildContext context) => ShortList());
      case '/splashscreen':
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen(args));
      case '/notification':
        return MaterialPageRoute(
            builder: (BuildContext context) => NotificationClass());
      case '/myprofile':
        return MaterialPageRoute(
            builder: (BuildContext context) => Profile(args));
      case '/profileview':
        return MaterialPageRoute(
            builder: (BuildContext context) => ProfileView(data: args));
      case '/adminview':
        return MaterialPageRoute(
            builder: (BuildContext context) => AdminView(data: args));
      case '/admin':
        return MaterialPageRoute(
            builder: (BuildContext context) => AdminForm(args));
      case '/adminshortlist':
        return MaterialPageRoute(
            builder: (BuildContext context) => AdminShortlist());
      case '/addprofile':
        return MaterialPageRoute(
            builder: (BuildContext context) => AddProfile());
      case '/searchprofile':
        return MaterialPageRoute(
            builder: (BuildContext context) => SearchProfile());
    }
  }
}
