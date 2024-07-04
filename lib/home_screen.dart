import 'package:expense_tracker_app/add_expense.dart';
import 'package:expense_tracker_app/all_expenses.dart';
import 'package:flutter/material.dart';

import 'models/expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Expense> _expensesList = [
  //   Expense(
  //       title: '1',
  //       price: 1,
  //       category: Category.enjoyment,
  //       date: DateTime.now()),
  //   Expense(
  //       title: '2',
  //       price: 2,
  //       category: Category.enjoyment,
  //       date: DateTime.now()),
  //   Expense(
  //       title: '3',
  //       price: 30,
  //       category: Category.enjoyment,
  //       date: DateTime.now()),
  //   Expense(
  //       title: '4',
  //       price: 40,
  //       category: Category.enjoyment,
  //       date: DateTime.now()),
  // ];
  List<Expense> _expensesList = [];

  void openBottomModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return AddExpense(saveExpenseOnHomeScreen: saveExpenseOnHomeScreen);
        });
  }

  void saveExpenseOnHomeScreen(
      String title, int amount, DateTime date, Category category) {
    _expensesList.add(
        Expense(title: title, price: amount, category: category, date: date));

    setState(() {});
    Navigator.pop(context);
  }

  void deleteExpense(Expense expense, int indexForUndoDelete) {
    setState(() {
      _expensesList.remove(expense);
    });

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    showSnackBarAfterDelete(expense, indexForUndoDelete);
  }

  void showSnackBarAfterDelete(Expense expense, int indexForUndoDelete) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Expense deleted successfully'),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();

                undoDelete(expense, indexForUndoDelete);
              },
              child: Text('Undo'),
            ),
          ],
        ),
      ),
    );
  }

  void undoDelete(Expense expense, int indexForUndoDelete) {
    setState(() {
      _expensesList.insert(indexForUndoDelete, expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
        ),
        actions: [
          IconButton(
            onPressed: openBottomModal,
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: AllExpenses(
                expensesList: _expensesList,
                deleteExpense: deleteExpense,
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
