import 'package:flutter/material.dart';
import 'package:school/models/student.dart';
import 'package:school/utils/database_helper.dart';

class ChangeMarks extends StatefulWidget {
  final String subject;
  ChangeMarks(this.subject);

  @override
  _ChangeMarksState createState() => _ChangeMarksState();
}

class _ChangeMarksState extends State<ChangeMarks> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List _studentList = List<Student>();
  List _controllers = List<TextEditingController>();
  final List<String> _years = ['1', '2', '3'];
  String _selectedYear = '1';

  void _updateList() async {
    Future<List> list = _databaseHelper.getSortedList('student_table', _selectedYear);
    list.then((list) {
      _controllers = List<TextEditingController>();
      for (int i = 0; i < list.length; i++)
        _controllers.add(TextEditingController());
      setState(() => this._studentList = list);
    });
  }

  void _changeMarks() async {
    if (widget.subject == 'Arabic')
      for (int i = 0; i < _studentList.length; i++) {
        if (_studentList[i].arabic != int.parse(_controllers[i].text)) {
          _studentList[i].arabic = int.parse(_controllers[i].text);
          await _databaseHelper.update(_studentList[i]);
        }
      }
    else if (widget.subject == 'English')
      for (int i = 0; i < _studentList.length; i++) {
        if (_studentList[i].english != int.parse(_controllers[i].text)) {
          _studentList[i].english = int.parse(_controllers[i].text);
          await _databaseHelper.update(_studentList[i]);
        }
      }
    else if (widget.subject == 'Maths')
      for (int i = 0; i < _studentList.length; i++) {
        if (_studentList[i].maths != int.parse(_controllers[i].text)) {
          _studentList[i].maths = int.parse(_controllers[i].text);
          await _databaseHelper.update(_studentList[i]);
        }
      }
    else if (widget.subject == 'Science')
      for (int i = 0; i < _studentList.length; i++) {
        if (_studentList[i].science != int.parse(_controllers[i].text)) {
          _studentList[i].science = int.parse(_controllers[i].text);
          await _databaseHelper.update(_studentList[i]);
        }
      }
    else if (widget.subject == 'History')
      for (int i = 0; i < _studentList.length; i++) {
        if (_studentList[i].history != int.parse(_controllers[i].text)) {
          _studentList[i].history = int.parse(_controllers[i].text);
          await _databaseHelper.update(_studentList[i]);
        }
      }
    else if (widget.subject == 'Computer')
      for (int i = 0; i < _studentList.length; i++) {
        if (_studentList[i].computer != int.parse(_controllers[i].text)) {
          _studentList[i].computer = int.parse(_controllers[i].text);
          await _databaseHelper.update(_studentList[i]);
        }
      }

    _updateList();
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Marks saved successfully.'),
        actions: <Widget>[
          FlatButton(child: Text('OK'), onPressed: () => Navigator.pop(context),),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change ${widget.subject} Marks'),),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Select Year:', textScaleFactor: 1.2,),
                DropdownButton(
                  items: _years.map((String year) {
                    return DropdownMenuItem<String>(value: year, child: Text(year),);
                  }).toList(),
                  value: _selectedYear,
                  onChanged: (selected) {
                    _selectedYear = selected;
                    _updateList();
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _studentList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(_studentList[index].name, textScaleFactor: 1.5,),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 50,
                      child: TextField(
                        controller: _controllers[index]..text =
                            (widget.subject == 'Arabic') ? '${_studentList[index].arabic}' :
                            (widget.subject == 'English') ? '${_studentList[index].english}' :
                            (widget.subject == 'Maths') ? '${_studentList[index].maths}' :
                            (widget.subject == 'Science') ? '${_studentList[index].science}' :
                            (widget.subject == 'History') ? '${_studentList[index].history}' :
                            '${_studentList[index].computer}',
                        onTap: () => _controllers[index].selection = TextSelection(
                          baseOffset: 0, extentOffset: _controllers[index].value.text.length,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 20),),
                    color: Colors.blue,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('Save changed marks?'),
                          actions: <Widget>[
                            FlatButton(child: Text('Yes'), onPressed: () {
                              Navigator.pop(context);
                              _changeMarks();
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
                          title: Text('Discard changed marks?'),
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
