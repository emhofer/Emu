import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, amount INTEGER NOT NULL, description TEXT NOT NULL, date TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertExpense(Expense expense) async {
    final Database db = await initializeDB();
    await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Expense>> getItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'expenses',
      orderBy: 'id DESC',
    );
    return queryResult.map((e) => Expense.fromMap(e)).toList();
  }

  Future<void> deleteItem(int id) async {
    final db = await initializeDB();
    try {
      await db.delete("expenses", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}

class Expense {
  final int id;
  final int amount;
  final String description;
  final String date;

  Expense(
      {
      required this.id,
      required this.amount,
      required this.description,
      required this.date});

  Expense.fromMap(Map<String, dynamic> item)
      :
        id = item["id"],
        amount = item["amount"],
        description = item["description"],
        date = item["date"];

  Map<String, Object> toMap() {
    return {
      // 'id': null,
      'amount': amount,
      'description': description,
      'date': date
    };
  }
}
