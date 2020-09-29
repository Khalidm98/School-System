import 'package:flutter/material.dart';
import 'package:school/utils/database_helper.dart';

class DeletePerson extends StatefulWidget {
  @override
  _DeletePersonState createState() => _DeletePersonState();
}

class _DeletePersonState extends State<DeletePerson> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List _personList = List();
  final List<String> _users = ['Admin', 'Teacher', 'Student'];
  final List<String> _jobs = ['All', 'Principal', 'Secretary', 'HR'];
  final List<String> _subjects = ['All', 'Arabic', 'English', 'Maths', 'Science', 'History', 'Computer'];
  final List<String> _years = ['All', '1', '2', '3'];
  String _selectedUser = 'Student';
  String _selectedField = 'All';

  void _updateList() async {
    Future<List> list = _databaseHelper.getSortedList(
        '${_selectedUser.toLowerCase()}_table', _selectedField);
    list.then((list) {
      setState(() => this._personList = list);
    });
  }

  void _confirmDelete<T>(T user, String name) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Delete "$name"?'),
        actions: <Widget>[
          FlatButton(child: Text('Yes'), onPressed: () {
            Navigator.pop(context);
            _deleteUser(user);
          },),
          FlatButton(child: Text('No'), onPressed: () => Navigator.pop(context),),
        ],
      ),
    );
  }

  void _deleteUser<T>(T user) async {
    int status = await _databaseHelper.delete(user);
    if (status == 0)
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error deleting user!'),
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
          title: Text('User deleted successfully.'),
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
      appBar: AppBar(title: Text('Delete User'),),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Select User:', textScaleFactor: 1.2,),
                SizedBox(
                  width: 100,
                  child: DropdownButton(
                    items: _users.map((String user) {
                      return DropdownMenuItem<String>(value: user, child: Text(user),);
                    }).toList(),
                    value: _selectedUser,
                    onChanged: (selected) {
                      _selectedUser = selected;
                      _selectedField = 'All';
                      _updateList();
                    }
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  (_selectedUser == 'Admin') ? 'Job Title:' :
                  (_selectedUser == 'Teacher') ? 'Subject:' : 'Academic Year:',
                  textScaleFactor: 1.2,
                ),
                SizedBox(
                  width: 100,
                  child: DropdownButton(
                    items: (
                      (_selectedUser == 'Admin') ? _jobs :
                      (_selectedUser == 'Teacher') ? _subjects : _years
                        ).map((String element) {
                          return DropdownMenuItem<String>(value: element, child: Text(element),);
                        }).toList(),
                    value: _selectedField,
                    onChanged: (selected) {
                      _selectedField = selected;
                      _updateList();
                    },
                  ),
                ),
              ],
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            itemCount: _personList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(_personList[index].name, textScaleFactor: 1.5,),
                  ),
                  subtitle: (_selectedField != 'All') ? null :
                    Text(
                      (_selectedUser == 'Admin') ? 'Job Title: ${_personList[index].jobTitle}' :
                      (_selectedUser == 'Teacher') ? 'Subject: ${_personList[index].subject}' :
                      'Academic Year: ${_personList[index].year}'
                    ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _confirmDelete(_personList[index], _personList[index].name),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
