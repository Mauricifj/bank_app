import 'dart:async';

import 'package:bankapp/database/app_database.dart';
import 'package:bankapp/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String createTableSql = "CREATE TABLE $_tableName("
      "$_id INTEGER PRIMARY KEY, "
      "$_name TEXT, "
      "$_accountNumber INTEGER)";
  static const String _tableName = "contacts";
  static const String _id = "id";
  static const String _name = "name";
  static const String _accountNumber = "account_number";

  Future<List<Contact>> contacts() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    await Future.delayed(Duration(seconds: 2)); // Mock delay
    return List.generate(maps.length, (index) {
      return Contact(
        maps[index][_id],
        maps[index][_name],
        maps[index][_accountNumber],
      );
    });
  }

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    return db.insert(
      _tableName,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Contact> find(int id) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> map = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return Contact(id, map[0]['name'], map[0]['account_number']);
  }

  Future<int> update(Contact contact) async {
    final Database db = await getDatabase();
    return await db.update(
      _tableName,
      contact.toMap(),
      where: "id = ?",
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
