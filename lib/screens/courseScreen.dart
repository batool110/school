import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';

import 'teacherCoursesScreen.dart';
import 'firstScreen.dart';

class CourseScreen extends StatefulWidget {
  static const routeName = '/courseScreen';

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final _form = GlobalKey<FormState>();

  TextEditingController questionController = TextEditingController();

  List<String> _questionList;

  String _getQuestions;
  File _image;
  String _imagePath;
  String _homeworkImage;
  final picker = ImagePicker();
  String _getAnswer;

  void initState() {
    super.initState();
    _questionList = [];

    // openFile();
    getAnswer();
    getQuestions();
    getSavedImage();
  }

  void getAnswer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _getAnswer = prefs.getString('answer');

    print(_getAnswer);
  }


  String _openResult = 'Unknown';

  Future<void> openFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _homeworkImage = prefs.getString('assignmentImage');

//file:///storage/emulated/0/schoolManagement/canvas_image2020-10-04%2013%3A25%3A08.862264.jpg
    final result = await OpenFile.open(_homeworkImage);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });

    print('Open Result: $_openResult');
    print('Homework Image: $_homeworkImage');
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  getSavedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _imagePath = prefs.getString('imagePath');
      print(_imagePath);
    });
  }

  saveImage(path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('imagePath', path);
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
                }),
          ],
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(TeacherCoursesScreen.routeName);
              }),
          title: Text('Basic Computer'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'ClassRoom',
              ),
              Tab(
                text: 'Quiz',
              ),
              Tab(
                text: 'Home Work',
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
                      _image == null
                          ? Container()
                          : Column(
                              children: [
                                Container(
                                  height: 300,
                                  width: 300,
                                  child: Image.file(_image),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // width: width,
                                      height: 40,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color:
                                                Color.fromRGBO(108, 73, 73, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          saveImage(_image.path);
                                          print(_image.path);
                                          setState(() {
                                            _image = null;
                                          });
                                        },
                                        child: Text(
                                          'Upload Home Work',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: width,
                                      height: 40,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color:
                                                Color.fromRGBO(108, 73, 73, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          setState(() {
                                            _image = null;
                                          });
                                        },
                                        child: Text(
                                          'Remove',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      _image == null
                          ? Container()
                          : SizedBox(
                              height: 20,
                            ),
                      _image != null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Upload new assignment',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: 100,
                                  height: 40,
                                  color: Theme.of(context).primaryColor,
                                  child: FlatButton(
                                    onPressed: () {
                                      showModelBottomSheet(context);
                                      // Navigator.of(context).pushReplacementNamed(
                                      //     CourseScreen.routeName);
                                    },
                                    child: Text(
                                      'Upload',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/boyProfile.jpeg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Talha Hameed',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Teacher',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alina jabeen',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Student',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alina jabeen',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Student',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alina jabeen',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Student',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alina jabeen',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Student',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alina jabeen',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Student',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alina jabeen',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Student',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alina jabeen',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Student',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alina jabeen',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Student',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: width / 1.1,
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 0, 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/girl.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alina jabeen',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            'Student',
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Text('Groups'),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Home Work',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),
                _getQuestions == null ? Container(): Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_getQuestions, style: TextStyle(fontSize: 20, ),),
                    ),
                    _getAnswer == null ? Container() : Column(
                      children: [
                        Text('Student Answer is', textScaleFactor: 1.4,),
                        SizedBox(height: 10,),
                        Container(
                          width: width / 1.1,
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_getAnswer, textAlign: TextAlign.center ,style: TextStyle(fontSize: 20, ),),
                          ),
                        ),
                      ],
                    ), 
                  ],
                ),
                SizedBox(height: 20),
                _imagePath == null
                    ? Container()
                    : Container(
                        height: 300,
                        width: 300,
                        child: Image.file(File(_imagePath)),
                      ),
                _homeworkImage == null
                    ? Container()
                    : Column(
                        children: [
                          Text('open result: $_openResult\n'),
                          Container(
                            // height: 300,
                            // width: 300,
                            child: FlatButton(
                              onPressed: openFile,
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Show assignment',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 300,
                            child: Image.file(
                              File(_homeworkImage),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
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
                    title: new Text('Select Homework Image'),
                    onTap: () => {getImage()}),
                new ListTile(
                  leading: new Icon(
                    Icons.file_download,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: new Text('Type Homework'),
                  onTap: () => {typeQuestions()},
                ),
              ],
            ),
          );
        });
  }

  void typeQuestions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: List<Widget>.generate(_questionList.length,
                        (int index) {
                      return Chip(
                        label: Text(_questionList[index]),
                        onDeleted: () {
                          setState(() {
                            _questionList.removeAt(index);
                          });
                        },
                        deleteIcon: Icon(Icons.clear),
                      );
                    }),
                  ),
                  Form(
                    key: _form,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: TextFormField(
                            controller: questionController,
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
                              labelText: 'Type Question',
                            ),
                            onSaved: (value) => {
                              _questionList.add(value),
                            },
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              _form.currentState.save();
                              questionController.clear();
                            }),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                     print(_questionList);
                      printQuestions();
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

  void getQuestions() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    _getQuestions = prefs.getString('questions');

    print(_getQuestions);
  }

  void printQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String questions;
      questions = _questionList.join('\n');
    
    prefs.setString('questions', questions);
    // print(questions);
  }
}
