import 'package:school/models/person.dart';

class Admin extends Person {
  String jobTitle;

  Admin(username, password, name, date, email, phone, this.jobTitle)
      : super(username, password, name, date, email, phone);

  Admin.fromMap(Map<String, dynamic> map)
      : jobTitle = map['job_title'],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map['job_title'] = jobTitle;
    return map;
  }
}
