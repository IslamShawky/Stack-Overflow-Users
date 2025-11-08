import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/users_response_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bookmarks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE bookmarks (
  user_id INTEGER PRIMARY KEY,
  user_data TEXT NOT NULL
)
''');
  }

  Future<void> bookmarkUser(User user) async {
    final db = await instance.database;
    await db.insert(
        'bookmarks',
        {
          'user_id': user.userId,
          'user_data': json.encode(user.toJson()),
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> unbookmarkUser(int? userId) async {
    if (userId == null) return;
    final db = await instance.database;
    await db.delete('bookmarks', where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<bool> isBookmarked(int? userId) async {
    if (userId == null) return false;
    final db = await instance.database;
    final maps = await db.query(
      'bookmarks',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return maps.isNotEmpty;
  }

  Future<List<User>> getBookmarkedUsers() async {
    final db = await instance.database;
    final maps = await db.query('bookmarks');
    return maps
        .map((map) => User.fromJson(json.decode(map['user_data'] as String)))
        .toList();
  }
}
