import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'dart:async';

import '../models/StudentModel.dart';

class DatabaseConnection{

  Future<Database> setDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "school.db");
    var database = await openDatabase(
        path,
        version: 1,
        onCreate : _createDatabase);

    return database;
      // onCreate: (Database db, int version) async{
      //   await db.execute("""
      //     CREATE TABLE student(
      //       id INTEGER PRIMARY KEY IDENTITY,
      //       firstName TEXT,
      //       lastName TEXT,
      //       dateOfBirth TEXT,
      //       gender TEXT) """
      //   );
      }
    // );
  // }

  Future<void> _createDatabase(Database database, int version) async {
    String sql = """CREATE TABLE student(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          firstName TEXT,
          lastName TEXT,
          dateOfBirth TEXT,
          gender TEXT) """;

    await database.execute(sql);
  }

  // Future<int> addStudent(StudentModel student) async {
  //   final db = await init();
  //
  //   return db.insert("student", student.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.ignore,
  //   );
  // }
  //
  // Future<List<StudentModel>> fetchStudents() async{
  //   final db = await init();
  //   final maps = await db.query("student");
  //
  //   return List.generate(maps.length, (i) {
  //     return StudentModel(
  //       id: maps[i]['id'] as int,
  //       firstName: maps[i]['firstName'].toString(),
  //       lastName: maps[i]['lastName'].toString(),
  //       dateOfBirth: maps[i]['dateOfBirth'].toString(),
  //       gender: maps[i]['gender'].toString()
  //     );
  //   });
  // }
  //
  // Future<int> deleteStudent(int id) async{
  //   final db = await init();
  //
  //   int result = await db.delete(
  //     "student",
  //     where: "id = ?",
  //     whereArgs: [id]
  //   );
  //
  //   return result;
  // }
  //
  // Future<int> updateStudent(int id, StudentModel student) async {
  //   final db = await init();
  //
  //   int result = await db.update(
  //       "student",
  //       student.toMap(),
  //       where: "id = ?",
  //       whereArgs: [id]
  //   );
  //
  //   return result;
  // }
}