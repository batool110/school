import 'package:flutter/material.dart';

import 'courseScreen.dart';
import 'firstScreen.dart';

class TeacherCoursesScreen extends StatefulWidget {
  static const routeName = '/teacherCourses';

  @override
  _TeacherCoursesScreenState createState() => _TeacherCoursesScreenState();
}

class _TeacherCoursesScreenState extends State<TeacherCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(FirstScreen.routeName);
              }),
          title: Text('Teacher'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'ClassRoom',
              ),
              Tab(
                text: 'Attendence',
              ),
              Tab(
                text: 'Notifications',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: width / 1.1,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Create a new class',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            color: Theme.of(context).primaryColor,
                            child: FlatButton(
                              onPressed: () {
                                // Navigator.of(context).pushReplacementNamed(CourseScreen.routeName);
                              },
                              child: Text(
                                'Create',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                            onTap: () {
                              print('..........');
                              Navigator.of(context)
                                  .pushReplacementNamed(CourseScreen.routeName);
                            },
                                              child: Container(
                          child: Stack(
                            children: [
                              Container(
                                height: 130,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage('images/computer.jpg'),
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.dstATop),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                          child: Text(
                                            'Basic Computer',
                                            textScaleFactor: 1.2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Theme.of(context).accentColor),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                          child: Text(
                                            'Class 5',
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).accentColor),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                          child: Text(
                                            'Alina Suleman',
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).accentColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(CourseScreen.routeName);
                            },
                            child: Container(
                              height: 130,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage('images/computer.jpg'),
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.dstATop),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('images/girl.jpg'),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text(
                                        'Basic Computer',
                                        textScaleFactor: 1.2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text(
                                        'Class 4',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text(
                                        'Alina Suleman',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Text('Groups'),
          Text('Sessions'),
        ]),
      ),
    );
  }
}
