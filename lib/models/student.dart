import 'package:school/models/person.dart';

class Student extends Person {
  int year;
  int arabic = 0;
  int english = 0;
  int maths = 0;
  int science = 0;
  int history = 0;
  int computer = 0;

  Student(username, password, name, date, email, phone, this.year)
      : super(username, password, name, date, email, phone);

  Student.fromMap(Map<String, dynamic> map)
      : year = map['year'],
        arabic = map['arabic'],
        english = map['english'],
        maths = map['maths'],
        science = map['science'],
        history = map['history'],
        computer = map['computer'],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map['year'] = year;
    map['arabic'] = arabic;
    map['english'] = english;
    map['maths'] = maths;
    map['science'] = science;
    map['history'] = history;
    map['computer'] = computer;
    return map;
  }
}
