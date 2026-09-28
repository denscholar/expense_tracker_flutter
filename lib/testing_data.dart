import 'package:expense_app_flutter/models/expense.dart';

void main() {
  final expense = Expense(
    title: 'work',
    amount: 2000,
    category: Category.work,
    date: DateTime.now(),
  );

  print(expense.date);
}
