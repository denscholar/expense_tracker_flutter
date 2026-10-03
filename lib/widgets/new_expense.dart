import 'package:expense_app_flutter/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final Function(Expense expense) onAddExpense;
  // final Function(Expense expense) onRemoveExpense;

  const new({
    super.key,
    required this.onAddExpense,
    // required this.onRemoveExpense,
  });

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  Category? _selectedCategory;

  final formater = DateFormat.yMd();

  DateTime? _selectedDate;

  // =====================================
  // HANDLES DATE PICKER
  // ====================================
  void _presentDatePicker() async {
    final now = DateTime.now();

    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate == null) {
      return; // User cancelled
    }

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // ======================================
  // HANDLE SUBMIT EXPENSES
  // =====================================
  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Close'),
            ),
          ],
          title: Text("Invalid Input"),
          content: Text(
            'Make sure a valid title, amount, date and category was entered. ',
          ),
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );
    Navigator.pop(context);
  }

  // ==============================================
  // when using the controller, always dispose it
  // =================================================
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                hint: Text('Select Category'),
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toLowerCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel, color: Colors.red, size: 30.0),
              ),
            ],
          ),
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  maxLength: 50,
                  decoration: InputDecoration(
                    label: Text('Amount'),
                    prefixText: "\$",
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : formater.format(_selectedDate!),
                      ),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),

              // date widget
            ],
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: _submitExpense,
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
