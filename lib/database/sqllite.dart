import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
import 'package:tailor/models/work.dart';

class WorkDatabase {
  WorkDatabase._init();
  static final WorkDatabase instance = WorkDatabase._init();
  static Database? _database;
  String tableName = "testtable";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("testdatabase.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE testtable(_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,phone TEXT,style TEXT,styleImg TEXT,clothImg TEXT, description TEXT, price INTEGER,dueDate TEXT,daysLeft INTEGER, measurements TEXT,done INTEGER)');
  }

  Future<Work> create(Work work) async {
    final db = await instance.database;
    final id = await db.insert(tableName, work.toMap());
    return work;
  }

  Future<List<Work>> getAllWorks() async {
    final db = await instance.database;
    final result = await db.query(tableName,
        orderBy: "daysLeft", where: "done =?", whereArgs: [0]);
    return result.map((json) => Work.fromJson(json)).toList();
  }

  Future<List<Work>> getAllDoneWorks() async {
    final db = await instance.database;
    final result = await db.query(tableName, where: "done =?", whereArgs: [1]);
    return result.map((json) => Work.fromJson(json)).toList();
  }

  Future<int> update(Work work) async {
    final db = await instance.database;
    return db.update(tableName, work.toMap(),
        where: "_id = ?", whereArgs: [work.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableName, where: "_id = ?", whereArgs: [id]);
  }

  Future<Work> getWork(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableName,
        columns: ["_id", "name", "description", "price"],
        where: "_id =?*",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Work.fromJson(maps.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
