import 'package:expenso/data/hive_database.dart';
import 'package:expenso/data/month.dart';
import 'package:expenso/datetime/date_time_helper.dart';
import 'package:flutter/foundation.dart';

import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallExpenseList = [];
  List<Month> monthList = [];

  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  List<Month> getAllMonthList() {
    return monthList;
  }

  String monthName(int monthNumber) {
    String name = '';
    if (monthNumber == 1) {
      name = "Jan";
    }
    if (monthNumber == 2) {
      name = "Feb";
    }
    if (monthNumber == 3) {
      name = "Mar";
    }
    if (monthNumber == 4) {
      name = "Apr";
    }
    if (monthNumber == 5) {
      name = "May";
    }
    if (monthNumber == 6) {
      name = "June";
    }
    if (monthNumber == 7) {
      name = "July";
    }
    if (monthNumber == 8) {
      name = "Aug";
    }
    if (monthNumber == 9) {
      name = "Sept";
    }
    if (monthNumber == 10) {
      name = "Oct";
    }
    if (monthNumber == 11) {
      name = "Nov";
    }
    if (monthNumber == 12) {
      name = "Dec";
    }

    return name;
  }

  void save() {
    print(DateTime.now().month);
    Month monthExpense = Month(
        month:
            "${monthName((DateTime.now().month == 1) ? 12 : DateTime.now().month - 1)} ${(DateTime.now().month == 1) ? DateTime.now().year - 1 : DateTime.now().year}",
        amount: monthly().toString());
    addNewMonth(monthExpense);
    clearData();
  }

  void addNewMonth(Month monthExpense) {
    monthList.add(monthExpense);
    notifyListeners();
    db2.saveData(monthList);
  }

  final db = HiveDataBase();
  final db2 = HiveDataBase2();

  void prepareData() {
    DateTime dateTime = DateTime.now();
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
    if (db2.readData().isNotEmpty) {
      monthList = db2.readData();
    }
    if (dateTime.day >= 1) {
      if (db.readData().isNotEmpty) {
        if (db.readData()[0].dateTime.month != dateTime.month) {
          save();
        }
      }
    }
  }

  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  void deleteMonth(Month expense) {
    monthList.remove(expense);
    notifyListeners();
    db2.saveData(monthList);
  }

  void clearData() {
    overallExpenseList.clear();
    db.saveData(overallExpenseList);
  }

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  double monthly() {
    double monthlyV = 0;
    for (var expense in overallExpenseList) {
      double amount = double.parse(expense.amount);
      monthlyV += amount;
    }
    return monthlyV;
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
