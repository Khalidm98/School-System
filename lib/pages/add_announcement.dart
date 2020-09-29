import 'package:flutter/material.dart';
import 'package:school/models/announcement.dart';
import 'package:school/utils/database_helper.dart';

class AddAnnouncement extends StatefulWidget {
  @override
  _AddAnnouncementState createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  FocusNode _focusDescription = FocusNode();
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  String _due = '';
  DateTime _dueDate = DateTime.now();
  TimeOfDay _dueTime = TimeOfDay.now();

  void _pickDate() async {
    DateTime vacation = DateTime.now();
    if (vacation.month < 9)
      vacation = DateTime(vacation.year, 8, 31);
    else
      vacation = DateTime(vacation.year + 1, 8, 31);

    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: vacation,
    );
    if (picked != null) {
      _dueDate = picked;
      _pickTime();
    }
  }

  void _pickTime() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _dueTime,
    );
    if (picked != null) {
      _dueTime = picked;
      setState(() {
        _due = _dueDate.toString().substring(0, 11) + _dueTime.toString().substring(10, 15);
      });
    }
  }

  void _addAnnouncement() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    int status = await databaseHelper.insert(
        Announcement(_title.text, _description.text, _due, DateTime.now().toString().substring(0, 16)));
    if (status == 0)
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error adding announcement!'),
          actions: <Widget>[
            FlatButton(child: Text('OK'), onPressed: () => Navigator.pop(context),),
          ],
        ),
      );
    else
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Announcement added successfully.'),
          actions: <Widget>[
            FlatButton(child: Text('OK'), onPressed: () => Navigator.pop(context),),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Announcement'),),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _title,
              onSubmitted: (_) => _focusDescription.requestFocus(),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _description,
              focusNode: _focusDescription,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              minLines: 3,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Due Date: $_due', textScaleFactor: 1.2,),),
                IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: _pickDate,
                  tooltip: 'Select',
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text('Add', style: TextStyle(color: Colors.white, fontSize: 20),),
                    color: Colors.blue,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('Add Announcement?'),
                          actions: <Widget>[
                            FlatButton(child: Text('Yes'), onPressed: () {
                              Navigator.pop(context);
                              _addAnnouncement();
                            },),
                            FlatButton(child: Text('No'), onPressed: () => Navigator.pop(context),),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(width: 20,),
                Expanded(
                  child: RaisedButton(
                    child: Text('Discard', style: TextStyle(color: Colors.white, fontSize: 20),),
                    color: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('Discard Announcement?'),
                          actions: <Widget>[
                            FlatButton(child: Text('Yes'), onPressed: () => Navigator.pop(context),),
                            FlatButton(child: Text('No'), onPressed: () => Navigator.pop(context),),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
