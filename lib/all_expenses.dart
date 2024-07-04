import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/expense.dart';

class AllExpenses extends StatelessWidget {
  AllExpenses({
    super.key,
    required this.expensesList,
    required this.deleteExpense,
  });

  final void Function(Expense expense, int indexForUndoDelete) deleteExpense;
  List<Expense> expensesList;
  final _dateFormatter = DateFormat.yMd();

  @override
  Widget build(BuildContext context) {
    // show 'not expense found' in case of 0 expenses

    return expensesList.length == 0
        ? Center(
            child: Text(
              'No Expense Found!',
            ),
          )
        : ListView.builder(
            itemCount: expensesList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: ValueKey(expensesList[index]),
                  onDismissed: (direction) {
                    deleteExpense(expensesList[index], index);
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expensesList[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  '\$${expensesList[index].price}',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      expensesList[index]
                                          .icon[expensesList[index].category],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _dateFormatter
                                          .format(expensesList[index].date),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
            });
  }
}
