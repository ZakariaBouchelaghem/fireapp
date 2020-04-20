import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'modal.dart';



class DatabaseHelper {
  final String tableUser = "userTable";
  final String columnId = "id";
  final String columnName = "nom";
  final String columnProfilimage = "profilimage";
  final String columnCovlimage = "covimage";
  final String columnGrad = "grad";
  final String columnExp = "exper";
  final String columnWilaya = "wilaya";
  final String columnLocation = "location";
  final String columnTiming = "timing";
  final String columnEmail = "email";
  final String columnNumber = "number";
  final String columnRecmonded = "recomended";
//  final String columnPassword = "Password";

  //Singlton
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  //internal can be any name
  DatabaseHelper.internal();

  //to cashe all the states of the Database  - better for memory
  //not create new DB helper
  factory DatabaseHelper() => _instance;

  //Database reference
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    // from here video 2
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "db34.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }


  void _onCreate(Database db, int version) async {
        await db.execute(
        "CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnGrad TEXT, $columnExp TEXT, $columnProfilimage TEXT, $columnCovlimage TEXT, $columnWilaya TEXT, $columnLocation TEXT, $columnEmail TEXT, $columnNumber TEXT, $columnTiming TEXT, $columnRecmonded INTEGER)");

//    await db.execute(
//        "CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnPassword TEXT)");
  }

  //CRUD - Create Read Update DELETE

  //READ
  Future<int> saveUser(User user) async {
    //will call get db from above
    var dbClient = await db;
    //result of insert is number
    int result = await dbClient.insert(tableUser, user.toMap());
    return result;
  }

  //GET USERS
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser");
    return result.toList();
  }

  //GET Count

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableUser"));
  }

  Future<User> getUser(String name) async {
    final dbClient = await db;
    var res =await  dbClient.query(tableUser, where: "$columnName = ?", whereArgs: [name]);
    return res.isNotEmpty ? User.fromMap(res.first) : Null ;
    //END of Video 2
  }

  Future<int> deleteUser(String name) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableUser, where: "$columnName = ?", whereArgs: [name]);
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(),
        where: "$columnId = ? ", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
//End of Video 3
}