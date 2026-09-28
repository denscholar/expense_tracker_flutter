import 'package:expense_app_flutter/widgets/expense_list/expenses_list.dart';
import 'package:expense_app_flutter/models/expense.dart';
import 'package:expense_app_flutter/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const new({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerdExpenses = [
    Expense(
      title: 'Flutter course',
      amount: 4000,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 10000,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(context: context, builder: (ctx) => NewExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Expense Tracker',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          Text('The Chart'),
          Expanded(child: ExpensesList(expenses: _registerdExpenses)),
          //
        ],
      ),
    );
  }
}
