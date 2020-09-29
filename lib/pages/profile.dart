import 'package:flutter/material.dart';
import 'package:school/models/admin.dart';
import 'package:school/models/teacher.dart';
import 'package:school/pages/login.dart';

class Profile<T> extends StatefulWidget {
  final T user;
  Profile(this.user);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, size: 100,),
                ),
              ),

              Text(
                '${widget.user.name}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500,),
              ),

              Divider(
                thickness: 2, height: 40, indent: 20, endIndent: 20,
                color: Colors.white,
              ),

              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Date of Birth: ${widget.user.date}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Email: ${widget.user.email}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Phone: ${widget.user.phone}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  (widget.user is Admin) ? 'Job Title: ${widget.user.jobTitle}' :
                  (widget.user is Teacher) ? 'Subject: ${widget.user.subject}' :
                  'Year: ${widget.user.year}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

              SizedBox(height: 50,),
              RaisedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false
                  );
                },
                color: Colors.red[400],
                padding: EdgeInsets.all(10),
                child: Text('Log Out', style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
