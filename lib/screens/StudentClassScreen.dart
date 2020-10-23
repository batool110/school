import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'firstScreen.dart';
import 'assignmentScreen.dart';

class StudentClassScreen extends StatefulWidget {
  static const routeName = '/studentClassScreen';
  @override
  _StudentClassScreenState createState() => _StudentClassScreenState();
}

class _StudentClassScreenState extends State<StudentClassScreen> {
  final _form = GlobalKey<FormState>();

  String _imagePath;
  String _getQuestions;
  String _getAnswer;

  String _answerList;

  TextEditingController answerController = TextEditingController();

  void initState() {
    super.initState();

    // _answerList = [];

    getAnswer();
    getQuestions();
    getSavedImage();
  }

  void getQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _getQuestions = prefs.getString('questions');

    print(_getQuestions);
  }

  getSavedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _imagePath = prefs.getString('imagePath');
    });
  }

  void getAnswer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _getAnswer = prefs.getString('answer');

    print(_getAnswer);
  }

  void printAnswer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // String answer;
    // answer = _answerList.join('\n');

    prefs.setString('answer', _answerList);
    // print(questions);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: FaIcon(FontAwesomeIcons.powerOff),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(FirstScreen.routeName);
                })
          ],
          title: Text('Hello Student'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'ClassRoom',
              ),
              Tab(
                text: 'Assignment',
              ),
              Tab(
                text: 'Sessions',
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
                            'Join a new class',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            color: Theme.of(context).primaryColor,
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Join',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Stack(
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
                      SizedBox(height: 4),
                      Stack(
                        children: [
                          Container(
                            height: 130,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1580582932707-520aed937b7b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80'),
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
                                      AssetImage('images/profile.png'),
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
                                        'English',
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
                                        'Class 1',
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
                                        'Batool Ali',
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
                      SizedBox(height: 4),
                      Stack(
                        children: [
                          Container(
                            height: 130,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.shutterstock.com/image-photo/education-elementary-school-learning-people-260nw-303888209.jpg'),
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
                                  backgroundImage: NetworkImage(
                                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
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
                                        'Mathematics',
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
                                        'Class 3',
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
                                        'Nouman Suleman',
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
                      SizedBox(height: 4),
                      Stack(
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
                                  backgroundImage: NetworkImage(
                                      'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
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
                                        'Islamiyat',
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
                                        'Asma Hameed',
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
                      SizedBox(height: 4),
                      Stack(
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
                                        'Computer Class',
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
                                        'Nouman Suleman',
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
                      SizedBox(height: 4),
                      Stack(
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
                                        'Computer Class',
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
                                        'Nouman Suleman',
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
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                _getQuestions == null
                    ? Text(
                        'You don\'t have any question home work',
                        textAlign: TextAlign.center,
                        textScaleFactor: 2,
                      )
                    : Container(
                        width: width / 1.1,
                        // height: 500,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/monkey.png',
                                height: 120,
                              ),
                              // CircleAvatar(
                              //     backgroundColor: Colors.black,
                              //     radius: 40,
                              //     backgroundImage:
                              //         AssetImage('images/monkey.png'),
                              //   ),
                              Text(
                                'Homework Questions are:',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  _getQuestions,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                // width: width,
                                height: 40,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(108, 73, 73, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    showModelBottomSheet(context);
                                    },
                                  child: Text(
                                    'Submit Home Work',
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              _getAnswer == null ? Container() :
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Your answer',
                                    textScaleFactor: 1.3,
                                  ),
                                  Container(
                                    color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(_getAnswer),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                // SizedBox(
                //   height: 30,
                // ),
                _imagePath == null
                    ? Container(
                        width: 300,
                        height: 300,
                        child: Text(
                          'You don\'t have any Picture home work',
                          textAlign: TextAlign.center,
                          textScaleFactor: 2,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Homework Picture is:',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 400,
                              width: 400,
                              child: Image.file(File(_imagePath)),
                            ),
                            SizedBox(height: 20),
                            Container(
                              // width: width,
                              height: 40,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(108, 73, 73, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  showModelBottomSheet(context);
                                },
                                child: Text(
                                  'Submit Home Work',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            _getAnswer == null ? Container() :
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Your answer',
                                    textScaleFactor: 1.3,
                                  ),
                                  Text(_getAnswer),
                                ],
                              ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          Text('Sessions'),
        ]),
      ),
    );
  }

  void showModelBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(
                      Icons.camera,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: new Text('Write Answer by hand'),
                    onTap: () => {
                          Navigator.of(context)
                              .pushReplacementNamed(AssignmentScreen.routeName),
                        }),
                new ListTile(
                  leading: new Icon(
                    Icons.file_download,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: new Text('Type Answer'),
                  onTap: () => {typeAnswer()},
                ),
              ],
            ),
          );
        });
  }

  void typeAnswer() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                children: [
                  // Wrap(
                  //   spacing: 6,
                  //   runSpacing: 6,
                  //   children: List<Widget>.generate(_answerList.length,
                  //       (int index) {
                  //     return Chip(
                  //       label: Text(_answerList[index]),
                  //       onDeleted: () {
                  //         setState(() {
                  //           _answerList.removeAt(index);
                  //         });
                  //       },
                  //       deleteIcon: Icon(Icons.clear),
                  //     );
                  //   }),
                  // ),
                  Form(
                    key: _form,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: TextFormField(
                            controller: answerController,
                            keyboardType: TextInputType.text,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 3),
                              ),
                              labelText: 'Type Answer',
                            ),
                            onSaved: (value) => {
                              // _answerList(value),
                            },
                          ),
                        ),
                      //   IconButton(
                      //       icon: Icon(
                      //         Icons.check,
                      //         color: Theme.of(context).primaryColor,
                      //       ),
                      //       onPressed: () {
                      //         String answer = answerController.text;
                      //         _form.currentState.save();
                      //         answerController.clear();
                      //       }),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      _answerList = answerController.text;
                     print(_answerList);
                      printAnswer();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'submit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          );
        });
  }

}
