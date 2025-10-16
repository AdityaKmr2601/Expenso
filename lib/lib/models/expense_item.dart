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

class Lend {
  String name;
  String amount;
  DateTime dateTime;
  Lend({required this.name, required this.amount, required this.dateTime});
}

class Borrow {
  String name;
  String amount;
  DateTime dateTime;

  Borrow({required this.name, required this.amount, required this.dateTime});
}
