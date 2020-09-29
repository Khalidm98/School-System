import 'package:flutter/material.dart';
import 'package:school/models/admin.dart';
import 'package:school/models/teacher.dart';
import 'package:school/models/student.dart';
import 'package:school/utils/database_helper.dart';

class AddPerson extends StatefulWidget {
  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  List<FocusNode> _focusNodes = List<FocusNode>();
  List<TextEditingController> _controllers = List<TextEditingController>();
  final List<String> _users = ['Admin', 'Teacher', 'Student'];
  final List<String> _jobs = ['Principal', 'Secretary', 'HR'];
  final List<String> _subjects = ['Arabic', 'English', 'Maths', 'Science', 'History', 'Computer'];
  final List<String> _years = ['1', '2', '3'];
  String _selectedUser = 'Student';
  String _selectedField = '1';
  String _birthDate = '';
  DateTime _birth = DateTime(DateTime.now().year - 10);

  void _pickDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _birth,
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year - 5).subtract(Duration(days: 1)),
    );
    if (picked != null) {
      _birth = picked;
      setState(() => _birthDate = picked.toString().substring(0, 10));
    }
  }

  void _addUser() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    int status;
    if (_selectedUser == 'Admin')
      status = await databaseHelper.insert(
          Admin(
            _controllers[0].text,
            _controllers[1].text,
            _controllers[2].text,
            _birth.toString().substring(0, 10),
            _controllers[3].text,
            _controllers[4].text,
            _selectedField,
          ));
    if (_selectedUser == 'Teacher')
      status = await databaseHelper.insert(
          Teacher(
            _controllers[0].text,
            _controllers[1].text,
            _controllers[2].text,
            _birth.toString().substring(0, 10),
            _controllers[3].text,
            _controllers[4].text,
            _selectedField,
          ));
    else if (_selectedUser == 'Student')
      status = await databaseHelper.insert(
          Student(
            _controllers[0].text,
            _controllers[1].text,
            _controllers[2].text,
            _birth.toString().substring(0, 10),
            _controllers[3].text,
            _controllers[4].text,
            int.parse(_selectedField),
          ));

    if (status == 0)
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error adding user!'),
          actions: <Widget>[
            FlatButton(child: Text('OK'), onPressed: () => Navigator.pop(context),),
          ],
        ),
      );
    else
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('User added successfully.'),
          actions: <Widget>[
            FlatButton(child: Text('OK'), onPressed: () => Navigator.pop(context),),
          ],
        ),
      );
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++){
      _focusNodes.add(FocusNode());
      _controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add User'),),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Select User:', textScaleFactor: 1.2,),
                DropdownButton(
                  items: _users.map((String user) {
                    return DropdownMenuItem<String>(value: user, child: Text(user),);
                  }).toList(),
                  value: _selectedUser,
                  onChanged: (selected) {
                    if (selected == 'Admin')
                      _selectedField = 'Principal';
                    else if (selected == 'Teacher')
                      _selectedField = 'Arabic';
                    else if (selected == 'Student')
                      _selectedField = '1';
                    setState(() => _selectedUser = selected);
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _controllers[0],
              onSubmitted: (_) => _focusNodes[0].requestFocus(),
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              focusNode: _focusNodes[0],
              controller: _controllers[1],
              onSubmitted: (_) => _focusNodes[1].requestFocus(),
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              obscureText: true,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              focusNode: _focusNodes[1],
              controller: _controllers[2],
              onSubmitted: (_) => _focusNodes[2].requestFocus(),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              focusNode: _focusNodes[2],
              controller: _controllers[3],
              onSubmitted: (_) => _focusNodes[3].requestFocus(),
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              focusNode: _focusNodes[3],
              controller: _controllers[4],
              onSubmitted: (_) => _focusNodes[4].requestFocus(),
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              keyboardType: TextInputType.phone,
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
                DropdownButton(
                  items: (
                    (_selectedUser == 'Admin') ? _jobs :
                    (_selectedUser == 'Teacher') ? _subjects : _years
                      ).map((String element) {
                        return DropdownMenuItem<String>(value: element, child: Text(element),);
                      }).toList(),
                  value: _selectedField,
                  focusNode: _focusNodes[4],
                  onChanged: (selected) => setState(() => _selectedField = selected),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Date of Birth: $_birthDate', textScaleFactor: 1.2,),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                  tooltip: 'Select',
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
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
                          title: Text('Add User?'),
                          actions: <Widget>[
                            FlatButton(child: Text('Yes'), onPressed: () {
                              Navigator.pop(context);
                              _addUser();
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
                          title: Text('Discard adding user?'),
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
