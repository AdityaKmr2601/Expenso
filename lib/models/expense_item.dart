class ExpenseItem {
  String name;
  String amount;
  DateTime dateTime;

  ExpenseItem({
    required this.name,
    required this.amount,
    required this.dateTime,
  });
}

class Month {
  String month;
  String amount;

  Month({required this.month, required this.amount});
}
