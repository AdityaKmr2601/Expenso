import 'package:expenso/models/expense_item.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataBase3 {
  final _myBox = Hive.box("Lend");

  void saveData(List<Lend> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put("Lend_EXPENSES", allExpensesFormatted);
  }

  List<Lend> readData() {
    List savedExpenses = _myBox.get("Lend_EXPENSES") ?? [];
    List<Lend> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      Lend expense = Lend(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}

class HiveDataBase4 {
  final _myBox = Hive.box("Borrow");

  void saveData(List<Borrow> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put("Borrow_EXPENSES", allExpensesFormatted);
  }

  List<Borrow> readData() {
    List savedExpenses = _myBox.get("Borrow_EXPENSES") ?? [];
    List<Borrow> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      Borrow expense = Borrow(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
