import 'package:flutter/material.dart';

class CourseManager extends ChangeNotifier {
  List<String> _courses = ['Course 1', 'Course 2', 'Course 3'];

  List<String> get courses => _courses;

  void deleteCourse(String course) {
    _courses.remove(course);
    notifyListeners(); // Notify listeners to update the UI
  }
}