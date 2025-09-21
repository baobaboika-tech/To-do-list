import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:testmodal/todo_item.dart';

class DataBaseWorks {
  Database? _database;

  // Getter for the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  // Initialize or open the database
  Future<Database> initDatabase() async {
    // Get the documents directory path
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'todoList.db');

    // Open the database or create it if it doesn't exist
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  // Function to create tables when database is created
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE todo_list (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          text TEXT NOT NULL,
          is_done BOOLEAN NOT NULL
        )''');
  }

  // Example: insert data
  Future<void> insertItem(String text, bool isDone) async {
    final db = await database;
    await db.insert('todo_list', {'text': text, 'is_done': isDone});
  }

  // Example: fetch data
  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query('todo_list');
  }

  Future<List<Task>> getTasks() async {
    final items = await getItems();
    return items.map((element) => Task.fromMap(element)).toList();
  }
}
