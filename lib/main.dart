import 'package:flutter/material.dart';

import 'screens/firstScreen.dart';
import 'screens/signinScreen.dart';
import 'screens/signupScreen.dart';
import 'screens/StudentClassScreen.dart';
import 'screens/teacherCoursesScreen.dart';
import 'screens/courseScreen.dart';
import 'screens/assignmentScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff134B66),
        accentColor: Colors.white,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstScreen(),
      routes: {
        FirstScreen.routeName: (context)=> FirstScreen(),
        SigninScreen.routeName: (context)=> SigninScreen(),
        SignupScreen.routeName: (context)=> SignupScreen(),
        StudentClassScreen.routeName: (context)=> StudentClassScreen(),
        TeacherCoursesScreen.routeName: (context)=> TeacherCoursesScreen(),
        CourseScreen.routeName: (context)=> CourseScreen(),
        AssignmentScreen.routeName: (context)=> AssignmentScreen(), 
      },
    );
  }
}
