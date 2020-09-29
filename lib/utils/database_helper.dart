import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school/models/admin.dart';
import 'package:school/models/teacher.dart';
import 'package:school/models/student.dart';
import 'package:school/models/announcement.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null)
      _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path + '/school.db';
      await deleteDatabase(path);
      _database = await openDatabase(path, version: 1, onCreate: _createDB);
    }
    return _database;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute('CREATE TABLE admin_table(id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'username TEXT, password TEXT, name TEXT, date TEXT, email TEXT, '
        'phone TEXT, job_title TEXT)');

    await db.execute('CREATE TABLE teacher_table(id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'username TEXT, password TEXT, name TEXT, date TEXT, email TEXT, '
        'phone TEXT, subject TEXT)');

    await db.execute('CREATE TABLE student_table(id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'username TEXT, password TEXT, name TEXT, date TEXT, email TEXT, '
        'phone TEXT, year INTEGER, arabic INTEGER, english INTEGER, '
        'maths INTEGER, science INTEGER, history INTEGER, computer INTEGER)');

    await db.execute('CREATE TABLE announcement_table(id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title TEXT, description TEXT, due TEXT, created TEXT)');

    // just for now..................
    await db.insert('admin_table', Admin('admin', 'admin', 'Essam Esmail',
        '1970-01-02', 'essam_elmodeer@example.com', '01234567890', 'Principal').toMap());
    await db.insert('teacher_table', Teacher('teacher', 'teacher', 'Hany Muhammad',
        '1985-03-04', 'hany_muhammad@example.com', '01478523695', 'English').toMap());
    await db.insert('student_table', Student('student', 'student', 'Khalid Refaat',
        '1998-07-08', 'khalid.refaat98@gmail.com', '01067548861', 3).toMap());

    await db.insert('announcement_table', Announcement('Pay Tuition Fees',
        'We started to accept the tuition fees.\nPlease pay it before the end of the year.',
        '2020-08-31 23:59', '2019-10-01 10:36').toMap());
    await db.insert('announcement_table', Announcement('Maths Quiz',
        '3rd year students have a maths quiz next week.\nThe quiz will cover Newton\'s Laws of Motion.\nBest Wishes.',
        '2020-08-13 14:00', '2020-08-06 19:07').toMap());
  }

  Future<List> getList(String table) async {
    Database db = await this.database;
    var mapList = await db.query(table);
    int count = mapList.length;
    List list = List();
    if (table == 'admin_table')
      for (int i = 0; i < count; i++)
        list.add(Admin.fromMap(mapList[i]));
    else if (table == 'teacher_table')
      for (int i = 0; i < count; i++)
        list.add(Teacher.fromMap(mapList[i]));
    else if (table == 'student_table')
      for (int i = 0; i < count; i++)
        list.add(Student.fromMap(mapList[i]));
    return list;
  }

  Future<List> getSortedList(String table, String selection) async {
    Database db = await this.database;
    List list = List();
    var mapList;
    if (table == 'admin_table') {
      if (selection == 'All')
        mapList = await db.query(table, orderBy: 'name ASC');
      else
        mapList = await db.rawQuery(
            'SELECT * FROM $table WHERE job_title = \'$selection\' ORDER BY name ASC');
      int count = mapList.length;
      for (int i = 0; i < count; i++)
        list.add(Admin.fromMap(mapList[i]));
    }
    else if (table == 'teacher_table') {
      if (selection == 'All')
        mapList = await db.query(table, orderBy: 'name ASC');
      else
        mapList = await db.rawQuery(
            'SELECT * FROM $table WHERE subject = \'$selection\' ORDER BY name ASC');
      int count = mapList.length;
      for (int i = 0; i < count; i++)
        list.add(Teacher.fromMap(mapList[i]));
    }
    else if (table == 'student_table') {
      if (selection == 'All')
        mapList = await db.query(table, orderBy: 'name ASC');
      else
        mapList = await db.rawQuery(
            'SELECT * FROM $table WHERE year = $selection ORDER BY name ASC');
      int count = mapList.length;
      for (int i = 0; i < count; i++)
        list.add(Student.fromMap(mapList[i]));
    }
    return list;
  }

  Future<List<Announcement>> getAnnouncementList() async {
    Database db = await this.database;
    List<Announcement> list = List<Announcement>();
    var mapList = await db.rawQuery(
        'SELECT * FROM announcement_table ORDER BY due ASC, created ASC');
    int count = mapList.length;
    for (int i = 0; i < count; i++)
      list.add(Announcement.fromMap(mapList[i]));
    return list;
  }

  Future<int> insert<T>(T element) async {
    Database db = await this.database;
    int result;
    if (element is Admin)
      result = await db.insert('admin_table', element.toMap());
    else if (element is Teacher)
      result = await db.insert('teacher_table', element.toMap());
    else if (element is Student)
      result = await db.insert('student_table', element.toMap());
    else if (element is Announcement)
      result = await db.insert('announcement_table', element.toMap());
    return result;
  }

  Future<int> update<T>(T element) async {
    Database db = await this.database;
    int result;
    if (element is Admin)
      result = await db.update('admin_table', element.toMap(), where: 'id = ?', whereArgs: [element.id]);
    else if (element is Teacher)
      result = await db.update('teacher_table', element.toMap(), where: 'id = ?', whereArgs: [element.id]);
    else if (element is Student)
      result = await db.update('student_table', element.toMap(), where: 'id = ?', whereArgs: [element.id]);
    else if (element is Announcement)
      result = await db.update('announcement_table', element.toMap(), where: 'id = ?', whereArgs: [element.id]);
    return result;
  }

  Future<int> delete<T>(T element) async {
    Database db = await this.database;
    int result;
    if (element is Admin)
      result = await db.delete('admin_table', where: 'id = ?', whereArgs: [element.id]);
    else if (element is Teacher)
      result = await db.delete('teacher_table', where: 'id = ?', whereArgs: [element.id]);
    else if (element is Student)
      result = await db.delete('student_table', where: 'id = ?', whereArgs: [element.id]);
    else if (element is Announcement)
      result = await db.delete('announcement_table', where: 'id = ?', whereArgs: [element.id]);
    return result;
  }
}
