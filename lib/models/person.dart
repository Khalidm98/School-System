class Person {
  int id;
  String username;
  String password;
  String name;
  String date;
  String email;
  String phone;

  Person(this.username, this.password, this.name, this.date, this.email, this.phone);

  Person.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    password = map['password'];
    name = map['name'];
    date = map['date'];
    email = map['email'];
    phone = map['phone'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null)
      map['id'] = id;
    map['username'] = username;
    map['password'] = password;
    map['name'] = name;
    map['date'] = date;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }
}
