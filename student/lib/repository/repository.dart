import 'package:sqflite/sqflite.dart';

import '../database/databaseConnection.dart';

class Repository{
  late DatabaseConnection _databaseConnection;

  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async{
    if (_database != null){
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  readDataById(table, id) async {
    var connection = await database;
    return await connection?.query(table, where: "id = ?", whereArgs: [id]);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection?.update(table, data, where: "id = ?", whereArgs: [data['id']]);
  }

  deleteDataById(table, id) async{
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id =$id");
  }
}