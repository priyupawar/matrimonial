import 'package:flutter/material.dart';
import 'package:matrimonial/forms/infotabs.dart';
import 'package:matrimonial/main.dart';

Map user = {
  "Name": '',
  "Email": '',
  "Pass": '',
  "Mobile": 0,
  "DOB": '',
  "Address": '',
  "City": '',
  "State": '',
  "Pincode": 0,
  "Status": '',
  "Education": '',
  "Jobtype": '',
  "Job": '',
  "Salary": 0,
  "Height": '',
  "Weight": 0,
  "Complexion": '',
  "Native": '',
  "Church Name": '',
  "Church Address": '',
  "Resident": '',
  "Expectation": '',
  "Mother Tounge": '',
  "image1":
      'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
  "image2":
      'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
  "image3":
      'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
  "Bio Headline": '',
  "Age": '',
  "Gender": ''
};

class AddProfile extends StatefulWidget {
  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  static const routeName = '/addprofile';
  @override
  void initState() {
    setCurrentRoute(routeName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InfoTabs(user),
    );
  }
}
