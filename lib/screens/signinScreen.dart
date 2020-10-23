import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'teacherCoursesScreen.dart';
import 'StudentClassScreen.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = '/signinScreen';

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool radioValue = true;
  bool visible;

  void initState() {
    super.initState();

    visible = true;
  }

  login(){
    String email = emailController.text;
    String password = passwordController.text;

    if(email == 'student@gmail.com'){
      if(password == '12345678'){
        Navigator.of(context).pushReplacementNamed(StudentClassScreen.routeName);
      }else{
        showToast('Incorrect Password');
      }
      }else if(email == 'teacher@gmail.com'){
        if(password == '123'){
          Navigator.of(context).pushReplacementNamed(TeacherCoursesScreen.routeName);
        }else{
        showToast('Incorrect Password');
        }
      } else{
        showToast('Incorrect Email');
      }
  }

  showToast(message){
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: width / 1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height < 500 ? 30 : 250,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                TextFormField(
                  cursorColor: Theme.of(context).primaryColor,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 3),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        // color: Theme.of(context).accentColor,
                        // fontStyle: Avenir,
                        ),
                  ),
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                  onSaved: (value) => {},
                ),
                SizedBox(height: 30),
                TextFormField(
                  cursorColor: Theme.of(context).primaryColor,
                  controller: passwordController,
                  obscureText: visible,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 3),
                    ),
                    // suffixIcon: Icon(Icons.visibility),
                    suffixIcon: IconButton(
                        icon: visible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        }),
                    fillColor: Theme.of(context).accentColor,
                    labelText: 'password',
                    labelStyle: TextStyle(
                        // color: Theme.of(context).accentColor,
                        // fontStyle: Avenir,
                        ),
                  ),
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                  onSaved: (value) => {},
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Remember me'),
                    Checkbox(
                        activeColor: Theme.of(context).primaryColor,
                        value: radioValue,
                        onChanged: (bool value) {
                          setState(() {
                            this.radioValue = value;
                          });
                        }),
                    // Radio(value: radioValue, groupValue: null, onChanged: (bool value) {
                    //   // setState(() {
                    //   //   this.radioValue = value;
                    //   // });
                    // }),
                  ],
                ),
                SizedBox(height: 50),
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
                      login();
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
                SizedBox(height: 20),
                Container(
                  width: width,
                  child: Text(
                    'Forgot Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
