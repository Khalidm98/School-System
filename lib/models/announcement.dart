class Announcement {
  int id;
  String title;
  String description;
  String dueDate;
  String dateCreated;

  Announcement(this.title, this.description, this.dueDate, this.dateCreated);

  Announcement.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    dueDate = map['due'];
    dateCreated = map['created'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null)
      map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['due'] = dueDate;
    map['created'] = dateCreated;
    return map;
  }
}
