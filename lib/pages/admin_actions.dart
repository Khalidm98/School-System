import 'package:flutter/material.dart';
import 'package:school/pages/add_person.dart';
import 'package:school/pages/delete_person.dart';
import 'package:school/pages/add_announcement.dart';
import 'package:school/pages/delete_announcement.dart';

class AdminActions extends StatefulWidget {
  @override
  _AdminActionsState createState() => _AdminActionsState();
}

class _AdminActionsState extends State<AdminActions> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('Select an Action', textScaleFactor: 1.5,),

        RaisedButton(
          child: Text('Add User', textScaleFactor: 1.5,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddPerson()));
          },
        ),

        RaisedButton(
          child: Text('Delete User', textScaleFactor: 1.5,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DeletePerson()));
          },
        ),

        RaisedButton(
          child: Text('Add Announcement', textScaleFactor: 1.5,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddAnnouncement()));
          },
        ),

        RaisedButton(
          child: Text('Delete Announcement', textScaleFactor: 1.5,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteAnnouncement()));
          },
        ),
      ],
    );
  }
}
