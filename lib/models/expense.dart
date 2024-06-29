import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Category { work, enjoyment, bills, fee }

var uuid = Uuid();

class Expense {
  Expense(
      {required this.title,
      required this.price,
      required this.category,
      required this.date})
      : uid = uuid.v4();
  String title;
  int price;
  DateTime date;
  Category category;
  String uid;

  Map<Category, IconData> icon = {
    Category.enjoyment: Icons.add,
    Category.bills: Icons.remove,
    Category.fee: Icons.abc_outlined,
    Category.work: Icons.access_alarm_sharp,
  };
}
