class TransactionModel {
  final int? id;
  final String title;
  final double amount;
  final String type; // 'income' or 'expense'
  final DateTime date;
  final String category;

  TransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type,
      'date': date.toIso8601String(),
      'category': category,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: map['amount'] as double,
      type: map['type'] as String,
      date: DateTime.parse(map['date'] as String),
      category: map['category'] as String,
    );
  }

  TransactionModel copyWith({
    int? id,
    String? title,
    double? amount,
    String? type,
    DateTime? date,
    String? category,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }
}
