import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction_model.dart';
import '../core/constants.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(AppConstants.dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    final sampleTransactions = [
      {
        'title': 'Salary Deposit',
        'amount': 50000.0,
        'type': 'income',
        'date':
            DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'category': 'Salary',
      },
      {
        'title': 'Grocery Shopping',
        'amount': 3500.0,
        'type': 'expense',
        'date':
            DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
        'category': 'Food',
      },
      {
        'title': 'Freelance Project',
        'amount': 15000.0,
        'type': 'income',
        'date':
            DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'category': 'Freelance',
      },
      {
        'title': 'Electricity Bill',
        'amount': 2500.0,
        'type': 'expense',
        'date':
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'category': 'Bills',
      },
      {
        'title': 'Mobile Recharge',
        'amount': 500.0,
        'type': 'expense',
        'date': DateTime.now().toIso8601String(),
        'category': 'Mobile',
      },
    ];

    for (var transaction in sampleTransactions) {
      await db.insert('transactions', transaction);
    }
  }

  Future<int> createTransaction(TransactionModel transaction) async {
    final db = await instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await instance.database;
    final result = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );

    return result.map((map) => TransactionModel.fromMap(map)).toList();
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    final db = await instance.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<double> getTotalBalance() async {
    final db = await instance.database;

    final incomeResult = await db.rawQuery(
      'SELECT SUM(amount) as total FROM transactions WHERE type = ?',
      ['income'],
    );

    final expenseResult = await db.rawQuery(
      'SELECT SUM(amount) as total FROM transactions WHERE type = ?',
      ['expense'],
    );

    final income = incomeResult.first['total'] as double? ?? 0.0;
    final expense = expenseResult.first['total'] as double? ?? 0.0;

    return income - expense;
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
