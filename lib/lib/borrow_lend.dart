import 'package:expenso/theme/theme_provider.dart';
import 'package:expenso/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'components/borrow_lend_tile.dart';
import 'data/expense_data.dart';
import 'models/expense_item.dart';

class BorrowLend extends StatefulWidget {
  const BorrowLend({super.key});

  @override
  State<BorrowLend> createState() => _BorrowLendState();
}

class _BorrowLendState extends State<BorrowLend> {
  final newBorrowNameController = TextEditingController();
  final newBorrowAmountController = TextEditingController();
  final newLendNameController = TextEditingController();
  final newLendAmountController = TextEditingController();
  double amountLend = 0;
  double amountBorrow = 0;

  @override
  void initState() {
    for (var v in Hive.box("borrow").values) {
      for (var c in v) {
        amountBorrow = amountBorrow + double.parse(c[1]);
      }
    }
    for (var v in Hive.box("lend").values) {
      for (var c in v) {
        amountLend = amountLend + double.parse(c[1]);
      }
    }
    Provider.of<ExpenseData>(context, listen: false).prepareData();
    super.initState();
  }

  void deleteBorrow(Borrow borrow) {
    Provider.of<ExpenseData>(context, listen: false).deleteBorrow(borrow);
    toast("Borrowed Expense Deleted Successfully", context, false);
  }

  void deleteLend(Lend lend) {
    Provider.of<ExpenseData>(context, listen: false).deleteLend(lend);
    toast("Lend Expense Deleted Successfully", context, false);
  }

  void addNewBorrowExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: ThemeProvider().themeData.focusColor,
              surfaceTintColor:
                  Hive.box("theme").get(0) == 0 || ThemeProvider().isDarkMode
                      ? const ColorScheme.dark().surfaceTint
                      : ThemeProvider().themeData.focusColor,
              title: const Text(
                "ADD NEW BORROW EXPENSE",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontFamily: "Sans"),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: (Hive.box("theme").get(0) == 0)
                              ? [
                                  Color(Hive.box("theme").get("gradient")[0]),
                                  Color(Hive.box("theme").get("gradient")[1]),
                                ]
                              : (ThemeProvider().isDarkMode)
                                  ? [
                                      Colors.green,
                                      const Color(0xff43EA82),
                                      const Color(0xff0AF2A6),
                                    ]
                                  : [
                                      Colors.blue.shade400,
                                      Colors.blueAccent.shade400,
                                      Colors.blueAccent.shade700,
                                    ],
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ThemeProvider().themeData.cardColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            autofocus: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Lender's Name",
                                hintStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontFamily: "Sans")),
                            controller: newBorrowNameController,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: (Hive.box("theme").get(0) == 0)
                              ? [
                                  Color(Hive.box("theme").get("gradient")[0]),
                                  Color(Hive.box("theme").get("gradient")[1]),
                                ]
                              : (ThemeProvider().isDarkMode)
                                  ? [
                                      Colors.green,
                                      const Color(0xff43EA82),
                                      const Color(0xff0AF2A6),
                                    ]
                                  : [
                                      Colors.blue.shade400,
                                      Colors.blueAccent.shade400,
                                      Colors.blueAccent.shade700,
                                    ],
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ThemeProvider().themeData.cardColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            onSubmitted: (value) {
                              saveBorrow();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Amount",
                                prefixText: "₹  ",
                                prefixStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontSize: 20),
                                hintStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontFamily: "Sans")),
                            controller: newBorrowAmountController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: saveBorrow,
                  child: const Text("SAVE"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("CANCEL"),
                ),
              ],
            ));
  }

  void saveBorrow() {
    int i, f = 0;
    for (i = 0; i <= newBorrowAmountController.text.length.toInt() - 1; i++) {
      String n = newBorrowAmountController.text[i];
      if (n == "1" ||
          n == "2" ||
          n == "3" ||
          n == "4" ||
          n == "5" ||
          n == "6" ||
          n == "7" ||
          n == "8" ||
          n == "9" ||
          n == "0" ||
          n == ".") {
      } else {
        f = 1;
      }
    }
    if (newBorrowNameController.text.isNotEmpty &&
        newBorrowAmountController.text.isNotEmpty &&
        f == 0) {
      Borrow newExpense = Borrow(
          name: newBorrowNameController.text,
          amount: newBorrowAmountController.text,
          dateTime: DateTime.now());
      setState(() {
        Provider.of<ExpenseData>(context, listen: false)
            .addNewBorrow(newExpense);
      });
      Navigator.pop(context);
      clear();
      toast("Borrowed Expense Added Successfully", context, true);
    }
  }

  void addNewLendExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: ThemeProvider().themeData.focusColor,
              surfaceTintColor:
                  Hive.box("theme").get(0) == 0 || ThemeProvider().isDarkMode
                      ? const ColorScheme.dark().surfaceTint
                      : ThemeProvider().themeData.focusColor,
              title: const Text(
                "ADD NEW LEND EXPENSE",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontFamily: "Sans"),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: (Hive.box("theme").get(0) == 0)
                              ? [
                                  Color(Hive.box("theme").get("gradient")[0]),
                                  Color(Hive.box("theme").get("gradient")[1]),
                                ]
                              : (ThemeProvider().isDarkMode)
                                  ? [
                                      Colors.green,
                                      const Color(0xff43EA82),
                                      const Color(0xff0AF2A6),
                                    ]
                                  : [
                                      Colors.blue.shade400,
                                      Colors.blueAccent.shade400,
                                      Colors.blueAccent.shade700,
                                    ],
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ThemeProvider().themeData.cardColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            autofocus: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Borrower's Name",
                                hintStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontFamily: "Sans")),
                            controller: newLendNameController,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: (Hive.box("theme").get(0) == 0)
                              ? [
                                  Color(Hive.box("theme").get("gradient")[0]),
                                  Color(Hive.box("theme").get("gradient")[1]),
                                ]
                              : (ThemeProvider().isDarkMode)
                                  ? [
                                      Colors.green,
                                      const Color(0xff43EA82),
                                      const Color(0xff0AF2A6),
                                    ]
                                  : [
                                      Colors.blue.shade400,
                                      Colors.blueAccent.shade400,
                                      Colors.blueAccent.shade700,
                                    ],
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ThemeProvider().themeData.cardColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            onSubmitted: (value) {
                              saveLend();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Amount",
                                prefixText: "₹  ",
                                prefixStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontSize: 20),
                                hintStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontFamily: "Sans")),
                            controller: newLendAmountController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: saveLend,
                  child: const Text("SAVE"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("CANCEL"),
                ),
              ],
            ));
  }

  void saveLend() {
    int i, f = 0;
    for (i = 0; i <= newLendAmountController.text.length.toInt() - 1; i++) {
      String n = newLendAmountController.text[i];
      if (n == "1" ||
          n == "2" ||
          n == "3" ||
          n == "4" ||
          n == "5" ||
          n == "6" ||
          n == "7" ||
          n == "8" ||
          n == "9" ||
          n == "0" ||
          n == ".") {
      } else {
        f = 1;
      }
    }
    if (newLendNameController.text.isNotEmpty &&
        newLendAmountController.text.isNotEmpty &&
        f == 0) {
      Lend newExpense = Lend(
          name: newLendNameController.text,
          amount: newLendAmountController.text,
          dateTime: DateTime.now());
      setState(() {
        Provider.of<ExpenseData>(context, listen: false).addNewLend(newExpense);
      });
      Navigator.pop(context);
      clear();
      toast("Lent Expense Added Successfully", context, true);
    }
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newBorrowNameController.clear();
    newBorrowAmountController.clear();
    newLendAmountController.clear();
    newLendNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back),
            color: Hive.box("theme").get(0) != 0 && ThemeProvider().isDarkMode
                ? Colors.green
                : Hive.box("theme").get(0) != 0 && !ThemeProvider().isDarkMode
                    ? Colors.blueAccent
                    : Color(Hive.box("theme").get("gradient")[0]),
          ),
          title: const Text(
            "BORROW / LEND",
            style: TextStyle(fontFamily: "Sans", fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: TabBar(
                dividerHeight: 0.1,
                labelColor: Hive.box("theme").get(0) == 0
                    ? Color(Hive.box("theme").get("gradient")[0])
                    : ThemeProvider().themeData.secondaryHeaderColor,
                indicatorColor: Hive.box("theme").get(0) == 0
                    ? Color(Hive.box("theme").get("gradient")[0])
                    : ThemeProvider().themeData.secondaryHeaderColor,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/borrow.png'),
                        const Text("Borrow")
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/lend.png'),
                        const Text("Lend")
                      ],
                    ),
                  ),
                ]),
            body: TabBarView(children: [
              (value.getAllBorrowList().isNotEmpty)
                  ? SafeArea(
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  "Total Amount Borrowed: ${value.borrowAmt()}"),
                              ElevatedButton(
                                  onPressed: addNewBorrowExpense,
                                  child: Icon(CupertinoIcons.add,
                                      color: Hive.box("theme").get(0) == 0
                                          ? Color(Hive.box("theme")
                                              .get("gradient")[0])
                                          : ThemeProvider()
                                              .themeData
                                              .secondaryHeaderColor)),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.getAllBorrowList().length,
                                  itemBuilder: (context, index) => BorrowTile(
                                        name: value
                                            .getAllBorrowList()[index]
                                            .name,
                                        amount: value
                                            .getAllBorrowList()[index]
                                            .amount,
                                        dateTime: value
                                            .getAllBorrowList()[index]
                                            .dateTime,
                                        deleteTapped: (p0) => deleteBorrow(
                                            value.getAllBorrowList()[index]),
                                      ))),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          bottom: 80.0, left: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                              onPressed: addNewBorrowExpense,
                              child: Icon(CupertinoIcons.add,
                                  color: Hive.box("theme").get(0) == 0
                                      ? Color(
                                          Hive.box("theme").get("gradient")[0])
                                      : ThemeProvider()
                                          .themeData
                                          .secondaryHeaderColor)),
                          // Flexible(
                          //   child: LottieBuilder.asset(
                          //     "images/empty.json",
                          //     alignment: Alignment.center,
                          //   ),
                          // ),
                          (Hive.box("theme").get(0) == 0
                              ? GradientText(
                                  "Looks like you haven't borrowed any money yet.",
                                  style: const TextStyle(
                                      fontFamily: "Sans", fontSize: 20),
                                  textAlign: TextAlign.center,
                                  colors: [
                                    Color(Hive.box("theme").get("gradient")[0]),
                                    Color(Hive.box("theme").get("gradient")[1]),
                                  ],
                                )
                              : Text(
                                  "Looks like you haven't borrowed any money yet.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Sans",
                                      color: (ThemeProvider().isDarkMode)
                                          ? const Color(0xff0AF2A6)
                                          : Colors.blueAccent.shade200),
                                ))
                        ],
                      ),
                    ),
              (value.getAllLendList().isNotEmpty)
                  ? SafeArea(
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Total Amount Lent: ${value.lendAmt()}"),
                              ElevatedButton(
                                  onPressed: addNewLendExpense,
                                  child: Icon(CupertinoIcons.add,
                                      color: Hive.box("theme").get(0) == 0
                                          ? Color(Hive.box("theme")
                                              .get("gradient")[0])
                                          : ThemeProvider()
                                              .themeData
                                              .secondaryHeaderColor)),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.getAllLendList().length,
                                  itemBuilder: (context, index) => LendTile(
                                        name:
                                            value.getAllLendList()[index].name,
                                        amount: value
                                            .getAllLendList()[index]
                                            .amount,
                                        dateTime: value
                                            .getAllLendList()[index]
                                            .dateTime,
                                        deleteTapped: (p0) => deleteLend(
                                            value.getAllLendList()[index]),
                                      ))),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          bottom: 80.0, left: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                              onPressed: addNewLendExpense,
                              child: Icon(CupertinoIcons.add,
                                  color: Hive.box("theme").get(0) == 0
                                      ? Color(
                                          Hive.box("theme").get("gradient")[0])
                                      : ThemeProvider()
                                          .themeData
                                          .secondaryHeaderColor)),
                          // Flexible(
                          //   child: LottieBuilder.asset(
                          //     "images/empty.json",
                          //     alignment: Alignment.center,
                          //   ),
                          // ),
                          (Hive.box("theme").get(0) == 0
                              ? GradientText(
                                  "Looks like you haven't lent any money yet.",
                                  style: const TextStyle(
                                      fontFamily: "Sans", fontSize: 20),
                                  textAlign: TextAlign.center,
                                  colors: [
                                    Color(Hive.box("theme").get("gradient")[0]),
                                    Color(Hive.box("theme").get("gradient")[1]),
                                  ],
                                )
                              : Text(
                                  "Looks like you haven't lent any money yet.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Sans",
                                      color: (ThemeProvider().isDarkMode)
                                          ? const Color(0xff0AF2A6)
                                          : Colors.blueAccent.shade200),
                                ))
                        ],
                      ),
                    ),
            ]),
          ),
        ),
      ),
    );
  }
}
