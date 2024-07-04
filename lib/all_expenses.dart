import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/expense.dart';

class AllExpenses extends StatefulWidget {
  AllExpenses({
    super.key,
    required this.expensesList,
    required this.refreshHomeScreen,
    required this.showSnackBarAfterDelete,
    required this.itemToDeleteIndex,
    required this.indexToDelete,
  });

  var refreshHomeScreen;
  void Function() showSnackBarAfterDelete;
  List<Expense> expensesList;
  int indexToDelete;
  Expense itemToDeleteIndex;
  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> {
  final _dateFormatter = DateFormat.yMd();

  void _deleteExpense(int index, BuildContext context) {
    widget.itemToDeleteIndex = widget.expensesList[index];
    widget.expensesList.removeAt(index);

    widget.refreshHomeScreen();

    widget.indexToDelete = index;
    widget.showSnackBarAfterDelete();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.expensesList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.expensesList[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteExpense(index, context);
                        },
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '\$${widget.expensesList[index].price}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              widget.expensesList[index]
                                  .icon[widget.expensesList[index].category],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _dateFormatter
                                  .format(widget.expensesList[index].date),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
