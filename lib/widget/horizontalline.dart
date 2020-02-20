import 'package:flutter/material.dart';

Widget horizontalLine(width) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: width,
        height: 1.0,
        color: Colors.black26.withOpacity(.2),
      ),
    );
