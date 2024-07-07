import 'package:flutter/material.dart';

class FilePage extends StatelessWidget {
  final String courseName;

  FilePage({required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
      ),
      body: Center(
        child: Text('Welcome to $courseName'),
      ),
    );
  }
}