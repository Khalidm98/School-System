import 'package:flutter/material.dart';
import 'package:school/models/student.dart';

class StudentActions extends StatefulWidget {
  final Student student;
  StudentActions(this.student);

  @override
  _StudentActionsState createState() => _StudentActionsState();
}

class _StudentActionsState extends State<StudentActions> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        DataTable(
          columns: [
            DataColumn(label: Text('Course', style: TextStyle(fontSize: 30),)),
            DataColumn(label: Text('Marks', style: TextStyle(fontSize: 30),))
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text("Arabic", style: TextStyle(fontSize: 20)),),
              DataCell(Text("${widget.student.arabic} ", style: TextStyle(fontSize: 20)))
            ]),
            DataRow(cells: [
              DataCell(Text("English", style: TextStyle(fontSize: 20))),
              DataCell(Text("${widget.student.english}", style: TextStyle(fontSize: 20)))
            ]),
            DataRow(cells: [
              DataCell(Text("Maths", style: TextStyle(fontSize: 20))),
              DataCell(Text("${widget.student.maths}", style: TextStyle(fontSize: 20)))
            ]),
            DataRow(cells: [
              DataCell(Text("Science", style: TextStyle(fontSize: 20))),
              DataCell(Text("${widget.student.science}", style: TextStyle(fontSize: 20))),
            ]),
            DataRow(cells: [
              DataCell(Text("History", style: TextStyle(fontSize: 20))),
              DataCell(Text("${widget.student.history}", style: TextStyle(fontSize: 20))),
            ]),
            DataRow(cells: [
              DataCell(Text("Computer", style: TextStyle(fontSize: 20))),
              DataCell(Text("${widget.student.computer}", style: TextStyle(fontSize: 20))),
            ]),
          ],
        ),
      ],
    );
  }
}
