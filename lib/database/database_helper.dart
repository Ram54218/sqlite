import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Database Name:
  static var database;

  // Table Names :
  static const databaseName = "Employee.db";
  static const officeTableName = "EmployeeDetail";

  // Person Table Column
  static const id = "id";
  static const name = "name";
  static const gender = "gender";
  static const address = "address";
  static const dob = "dob";
  static const emailAddress = "emailAddress";
  static const mobileNumber = "mobileNumber";
  static const state = "state";
  static const district = "district";

  //

  static const officeLocationTableName = "officeLocation";

  Future<Database?> setDatabase() async {
    var path = join(await getDatabasesPath(), databaseName);
    database = await openDatabase(path, version: 2, onCreate: _onCreate);
    return database;
  }

  _onCreate(Database db, int version) async {
    String officeTable =
        "CREATE TABLE $officeTableName($id INTEGER PRIMARY KEY,$name TEXT,$gender TEXT,$address TEXT, $dob TEXT, $emailAddress TEXT, $mobileNumber TEXT, $state TEXT, $district TEXT);";
    await db.execute(officeTable);

    String officeLocation =
        "CREATE TABLE $officeLocationTableName($id INTEGER PRIMARY KEY,$name TEXT);";
    await db.execute(officeLocation);
  }
}
