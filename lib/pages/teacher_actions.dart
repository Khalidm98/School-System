import 'package:flutter/material.dart';
import 'package:school/pages/change_marks.dart';
import 'package:school/pages/add_announcement.dart';
import 'package:school/pages/delete_announcement.dart';

class TeacherActions extends StatefulWidget {
  final String subject;
  TeacherActions(this.subject);

  @override
  _TeacherActionsState createState() => _TeacherActionsState();
}

class _TeacherActionsState extends State<TeacherActions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('Select an Action', textScaleFactor: 1.5,),

        RaisedButton(
          child: Text('Change Marks', textScaleFactor: 1.5,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeMarks(widget.subject)));
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
