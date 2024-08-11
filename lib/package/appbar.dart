import 'package:flutter/material.dart';

PreferredSizeWidget appbar() {
  return AppBar(
    backgroundColor: Colors.grey[850],
    title: const Padding(
      padding:  EdgeInsets.all(30.0),
      child:  Text('EMI 課程助教',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  )
;}
