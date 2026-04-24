import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../core/constants.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onDelete;

  const TransactionItem({
    Key? key,
    required this.transaction,
    this.onDelete,
  }) : super(key: key);

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'salary':
        return Icons.attach_money;
      case 'food':
        return Icons.restaurant;
      case 'freelance':
        return Icons.work;
      case 'bills':
        return Icons.receipt_long;
      case 'mobile':
        return Icons.phone_android;
      case 'shopping':
        return Icons.shopping_bag;
      case 'transport':
        return Icons.directions_car;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String type) {
    return type == 'income' ? AppColors.successColor : AppColors.expenseColor;
  }

  @override
  Widget build(BuildContext context) {
    final formattedAmount = NumberFormat('#,##,###').format(transaction.amount);
    final formattedDate = DateFormat('MMM dd, yyyy').format(transaction.date);
    final isIncome = transaction.type == 'income';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getCategoryColor(transaction.type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getCategoryIcon(transaction.category),
            color: _getCategoryColor(transaction.type),
            size: 24,
          ),
        ),
        title: Text(
          transaction.title,
          style: AppStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          formattedDate,
          style: AppStyles.bodyMedium,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isIncome ? '+' : '-'} ${AppConstants.currency}$formattedAmount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getCategoryColor(transaction.type),
              ),
            ),
            if (onDelete != null)
              InkWell(
                onTap: onDelete,
                child: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
