import 'package:flutter/material.dart';
import 'package:school/models/admin.dart';
import 'package:school/models/teacher.dart';
import 'package:school/pages/news.dart';
import 'package:school/pages/profile.dart';
import 'package:school/pages/admin_actions.dart';
import 'package:school/pages/teacher_actions.dart';
import 'package:school/pages/student_actions.dart';

class Home<T> extends StatefulWidget {
  final T user;
  Home(this.user);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.work)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            News(),
            (widget.user is Admin) ? AdminActions() :
            (widget.user is Teacher) ? TeacherActions(widget.user.subject) :
            StudentActions(widget.user),
            Profile(widget.user),
          ],
        ),
      ),
    );
  }
}
