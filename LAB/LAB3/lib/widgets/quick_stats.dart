import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/constants.dart';

class QuickStats extends StatelessWidget {
  final double income;
  final double expense;

  const QuickStats({
    Key? key,
    required this.income,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedIncome = NumberFormat('#,##,###').format(income);
    final formattedExpense = NumberFormat('#,##,###').format(expense);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Income',
              formattedIncome,
              Icons.arrow_downward,
              AppColors.successColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Expense',
              formattedExpense,
              Icons.arrow_upward,
              AppColors.expenseColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String amount, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${AppConstants.currency}$amount',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
