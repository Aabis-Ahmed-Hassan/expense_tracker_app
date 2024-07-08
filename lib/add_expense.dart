import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  AddExpense({super.key, required this.saveExpenseOnHomeScreen});

  Function saveExpenseOnHomeScreen;
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var dateFormatter = DateFormat.yMd();
  String _dateToShow = 'Choose Date';
  Category _selectedCategory = Category.work;

  DateTime? _pickedDate;
  void _chooseDate() async {
    _pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    setState(() {
      _dateToShow = dateFormatter.format(_pickedDate!);
    });
  }

  void _chooseCategory(Category pickedCategory) {
    setState(() {
      _selectedCategory = pickedCategory;
    });
  }

  void _saveExpenseOnAddExpenseScreen() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _pickedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all the fields. ',
          ),
        ),
      );

      return;
    }

    widget.saveExpenseOnHomeScreen(_titleController.text,
        int.parse(_amountController.text), _pickedDate, _selectedCategory);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //using scaffold so the scaffold messenger will be shown on bottom modal sheet, not home screen

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: InputDecoration(
                  label: Text(
                    'Title',
                  ),
                  hintText: 'Enter the title'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: Text(
                          'Amount',
                        ),
                        hintText: 'Enter the Amount'),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                      ),
                      TextButton(
                        onPressed: _chooseDate,
                        child: Text(
                          _dateToShow,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                DropdownMenu(
                  onSelected: (i) {
                    _chooseCategory(i!);
                  },
                  initialSelection: _selectedCategory,
                  textStyle: Theme.of(context).textTheme.titleSmall,
                  dropdownMenuEntries: [
                    for (var i = 0; i < Category.values.length; i++)
                      DropdownMenuEntry(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        value: Category.values[i],
                        label: Category.values[i].name.toUpperCase(),
                      ),
                  ],
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: _saveExpenseOnAddExpenseScreen,
                  child: Text(
                    'Save Expense',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
