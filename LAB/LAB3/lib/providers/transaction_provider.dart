import 'package:flutter/foundation.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../services/database_service.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  double _balance = 0.0;
  bool _isLoading = false;
  final UserModel _user = UserModel(
    name: 'Ahmed Rahman',
    accountNumber: '1234 5678 9012',
  );

  List<TransactionModel> get transactions => _transactions;
  double get balance => _balance;
  bool get isLoading => _isLoading;
  UserModel get user => _user;

  TransactionProvider() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _transactions = await DatabaseService.instance.getAllTransactions();
      _balance = await DatabaseService.instance.getTotalBalance();
    } catch (e) {
      debugPrint('Error loading transactions: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await DatabaseService.instance.createTransaction(transaction);
      await loadTransactions();
    } catch (e) {
      debugPrint('Error adding transaction: $e');
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      await DatabaseService.instance.deleteTransaction(id);
      await loadTransactions();
    } catch (e) {
      debugPrint('Error deleting transaction: $e');
    }
  }

  List<TransactionModel> get recentTransactions {
    return _transactions.take(5).toList();
  }

  double get totalIncome {
    return _transactions
        .where((t) => t.type == 'income')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (sum, t) => sum + t.amount);
  }
}
