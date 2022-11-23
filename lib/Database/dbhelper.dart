import 'package:my_notes/Model/notem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dart:io' as io;

import 'package:my_notes/main.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE mynotes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,description TEXT)",
    );
  }

  Future<Notes> insert(Notes notesModel) async {
    var dbClient = await db;
    await dbClient!.insert('mynotes', notesModel.toMap());
    return notesModel;
  }

  Future<List<Notes>> getCartListWithUserId() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('mynotes');
    return queryResult.map((e) => Notes.fromMap(e)).toList();
  }

  Future deleteTableContent() async {
    var dbClient = await db;
    return await dbClient!.delete(
      'mynotes',
    );
  }

  Future<int> updateQuantity(Notes notesModel) async {
    var dbClient = await db;
    return await dbClient!.update(
      'mynotes',
      notesModel.toMap(),
      where: 'id = ?',
      whereArgs: [notesModel.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'mynotes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
