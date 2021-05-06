import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'todus.dart';

class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'todos_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT, favorite BOOL, dateTime DATETIME)");
    });
  }

  insertTodo(ItemLists todo) async {
    final db = await database;
    var res = await db.insert(ItemLists.TABLENAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  updateTodo(ItemLists todo) async {
    final db = await database;

    await db.update(ItemLists.TABLENAME, todo.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
