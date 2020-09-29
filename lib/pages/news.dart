import 'package:flutter/material.dart';
import 'package:school/models/announcement.dart';
import 'package:school/utils/database_helper.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List _announcementList = List<Announcement>();

  // build is called twice because initState calls setState()
  @override
  void initState() {
    super.initState();
    DatabaseHelper databaseHelper = DatabaseHelper();
    Future<List> list = databaseHelper.getAnnouncementList();
    list.then((list) {
      setState(() => this._announcementList = list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: ListView.builder(
        itemCount: _announcementList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Card(
              elevation: 3,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    _announcementList[index].title,
                    style: TextStyle(color: Colors.blue[900],),
                    textScaleFactor: 1.5,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${_announcementList[index].description}\n'
                    'Date Announced: ${_announcementList[index].dateCreated}\n'
                    'Due Date: ${_announcementList[index].dueDate}',
                    style: TextStyle(height: 1.5, color: Colors.black,),
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1.2,
                  ),
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
