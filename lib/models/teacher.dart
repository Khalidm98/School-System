import 'package:school/models/person.dart';

class Teacher extends Person {
  String subject;

  Teacher(username, password, name, date, email, phone, this.subject)
      : super(username, password, name, date, email, phone);

  Teacher.fromMap(Map<String, dynamic> map)
      : subject = map['subject'],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map['subject'] = subject;
    return map;
  }
}
