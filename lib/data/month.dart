import 'package:expenso/models/expense_item.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataBase2 {
  final _myBox = Hive.box("month");

  void saveData(List<Month> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.month,
        expense.amount,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put("Month_EXPENSES", allExpensesFormatted);
  }

  List<Month> readData() {
    List savedExpenses = _myBox.get("Month_EXPENSES") ?? [];
    List<Month> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String month = savedExpenses[i][0];
      String amount = savedExpenses[i][1];

      Month expense = Month(
        month: month,
        amount: amount,
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
