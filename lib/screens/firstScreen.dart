import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'signinScreen.dart';
import 'signupScreen.dart';

class FirstScreen extends StatefulWidget {
  static const routeName = '/firstScreen';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: 700,
              width: width / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  // Image.asset('images/cage-2.png'),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: width,
                    height: 60,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
                      },
                      child: Text(
                        'Create an Account',
                        textScaleFactor: 1.4,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: width,
                    height: 60,
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
                        Navigator.of(context).pushReplacementNamed(SigninScreen.routeName);
                      },
                      child: Text(
                        'Login to Account',
                        textScaleFactor: 1.4,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: width,
                    height: 60,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.red
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.transparent,
                      onPressed: () async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        prefs.clear();
                      },
                      child: Text(
                        'Clear App Data',
                        textScaleFactor: 1.4,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
