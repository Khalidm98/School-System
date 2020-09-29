import 'package:flutter/material.dart';
import 'package:school/models/announcement.dart';
import 'package:school/utils/database_helper.dart';

class DeleteAnnouncement extends StatefulWidget {
  @override
  _DeleteAnnouncementState createState() => _DeleteAnnouncementState();
}

class _DeleteAnnouncementState extends State<DeleteAnnouncement> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List _announcementList = List<Announcement>();

  void _updateList() async {
    Future<List> list = _databaseHelper.getAnnouncementList();
    list.then((list) {
      setState(() => this._announcementList = list);
    });
  }

  void _confirmDelete(Announcement announcement) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Delete "${announcement.title}"?'),
        actions: <Widget>[
          FlatButton(child: Text('Yes'), onPressed: () {
            Navigator.pop(context);
            _deleteAnnouncement(announcement);
          },),
          FlatButton(child: Text('No'), onPressed: () => Navigator.pop(context),),
        ],
      ),
    );
  }

  void _deleteAnnouncement(Announcement announcement) async {
    int status = await _databaseHelper.delete(announcement);
    if (status == 0)
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error deleting announcement!'),
          actions: <Widget>[
            FlatButton(child: Text('OK'), onPressed: () => Navigator.pop(context),),
          ],
        ),
      );
    else {
      _updateList();
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Announcement deleted successfully.'),
          actions: <Widget>[
            FlatButton(child: Text('OK'), onPressed: () => Navigator.pop(context),),
          ],
        ),
      );
    }
  }

  // build is called twice because initState calls setState()
  @override
  void initState() {
    super.initState();
    _updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Delete Announcement'),),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _announcementList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Card(
              elevation: 3,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(_announcementList[index].title, textScaleFactor: 1.5,),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _confirmDelete(_announcementList[index]),
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
