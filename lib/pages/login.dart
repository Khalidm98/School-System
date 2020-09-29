import 'package:flutter/material.dart';
import 'package:school/models/admin.dart';
import 'package:school/models/teacher.dart';
import 'package:school/models/student.dart';
import 'package:school/pages/home.dart';
import 'package:school/utils/database_helper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode _focusPassword = FocusNode();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  void _signIn() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    List list = await databaseHelper.getList('admin_table');
    for (Admin admin in list) {
      if (admin.username == _username.text && admin.password == _password.text) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home(admin)),
                (Route<dynamic> route) => false
        );
        return;
      }
    }

    list = await databaseHelper.getList('teacher_table');
    for (Teacher teacher in list) {
      if (teacher.username == _username.text && teacher.password == _password.text) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home(teacher)),
                (Route<dynamic> route) => false
        );
        return;
      }
    }

    list = await databaseHelper.getList('student_table');
    for (Student student in list) {
      if (student.username == _username.text && student.password == _password.text) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home(student)),
                (Route<dynamic> route) => false
        );
        return;
      }
    }

    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Cannot Sign In!'),
        content: Text('Wrong Username or Password.'),
        actions: <Widget>[
          FlatButton(child: Text('OK'), onPressed: () => Navigator.pop(context),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // decoration
          Container(color: Colors.blue[900],),
          Positioned(
            top: 0,
            child: CircleAvatar(backgroundColor: Colors.blue, radius: 500,),
          ),

          // Login
          ListView(
            children: <Widget>[
              SizedBox(height: 100,),
              Text(
                'SCHOOL',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 100,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _username,
                      onSubmitted: (_) => _focusPassword.requestFocus(),
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        icon: Icon(Icons.email, color: Colors.black,),
                      ),
                    ),

                    SizedBox(height: 30,),
                    TextField(
                      controller: _password,
                      focusNode: _focusPassword,
                      onSubmitted: (_) => _signIn(),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        icon: Icon(Icons.lock, color: Colors.black,),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 100,),
              InkWell(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue[800],
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(color: Colors.white, fontSize: 20,),
                  ),
                ),
                onTap: _signIn,
              ),
            ],
          )
        ],
      ),
    );
  }
}
