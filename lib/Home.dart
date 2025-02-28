import 'dart:collection';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expenso/MonthShow.dart';
import 'package:expenso/Settings.dart';
import 'package:expenso/borrow_lend.dart';
import 'package:expenso/components/expense_summary.dart';
import 'package:expenso/components/expense_tile.dart';
import 'package:expenso/data/expense_data.dart';
import 'package:expenso/models/expense_item.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:expenso/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  double price = 0;
  int filt = 0;
  late List<dynamic> filters = [];
  List<dynamic> result = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // print(Hive.box("theme").get(1).toString());
    if (Hive.box("theme").get(1).toString() == 'null') {
      Hive.box("theme").put(1, "darkMode");
    }
    // print(Hive.box("theme").get(3).toString());
    if (Hive.box("theme").get(3).toString() == 'null') {
      Hive.box("theme").put(3, 1);
    }
    // print(Hive.box("theme").get(2).toString());
    if (Hive.box("theme").get(2).toString() == 'null') {
      Hive.box("theme").put(2, 1);
    }
    // print(Hive.box("theme").get(0).toString());
    if (Hive.box("theme").get(0).toString() == 'null') {
      Hive.box("theme").put(0, 0);
    }
    _controller = AnimationController(
        duration: const Duration(milliseconds: 900),
        vsync: this,
        upperBound: 0.5,
        value: (ThemeProvider().isDarkMode) ? 1 : 0);
    Provider.of<ExpenseData>(context, listen: false).prepareData();
    addFilt();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addFilt() {
    var dates;
    filters = [];
    result = [];
    var count = Provider.of<ExpenseData>(context, listen: false)
        .getAllExpenseList()
        .length;
    int i;
    for (i = 0; i < count; i++) {
      // print(Provider.of<ExpenseData>(context, listen: false)
      //     .getAllExpenseList()[i]
      //     .dateTime);
      dates = Provider.of<ExpenseData>(context, listen: false)
          .getAllExpenseList()[i]
          .dateTime;
      filters.add(dates.day);
    }
    result = LinkedHashSet<int>.from(filters).toList();
  }

  void addBudget() {
    final budgetController =
        TextEditingController(text: Hive.box("budget").get(1));
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor:
                  ThemeProvider().themeData.scaffoldBackgroundColor,
              surfaceTintColor:
                  Hive.box("theme").get(0) == 0 || ThemeProvider().isDarkMode
                      ? const ColorScheme.dark().surfaceTint
                      : ThemeProvider().themeData.focusColor,
              title: Text(
                (Hive.box("budget").get(1) == '' ||
                        Hive.box("budget").values.isEmpty)
                    ? "Add Budget"
                    : "Edit Budget",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Sans"),
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
                              ? [Colors.purpleAccent, Colors.blueAccent]
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
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.words,
                            autofocus: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Budget",
                                hintStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontFamily: "Sans")),
                            controller: budgetController,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      Hive.box("budget").put(1, budgetController.text);
                      Navigator.pop(context);
                    });
                    toast("Budget Saved", context, true);
                  },
                  child: const Text("SAVE"),
                ),
                MaterialButton(
                  onPressed: () {
                    budgetController.value = const TextEditingValue(text: "");
                  },
                  child: const Text("CLEAR"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("CANCEL"),
                ),
              ],
            ));
  }

  void editName() {
    final nameController = TextEditingController(text: Hive.box("name").get(1));
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              surfaceTintColor:
                  Hive.box("theme").get(0) == 0 || ThemeProvider().isDarkMode
                      ? const ColorScheme.dark().surfaceTint
                      : ThemeProvider().themeData.focusColor,
              backgroundColor: ThemeProvider().themeData.focusColor,
              title: const Text(
                "EDIT NAME",
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
                              ? [Colors.purpleAccent, Colors.blueAccent]
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
                                hintText: "Expense Name",
                                hintStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontFamily: "Sans")),
                            controller: nameController,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      Hive.box("name").put(1, nameController.text);
                      Navigator.pop(context);
                    });
                    toast("Name Changed", context, true);
                  },
                  child: const Text("SAVE"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("CANCEL"),
                ),
              ],
            ));
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: ThemeProvider().themeData.focusColor,
              surfaceTintColor:
                  Hive.box("theme").get(0) == 0 || ThemeProvider().isDarkMode
                      ? const ColorScheme.dark().surfaceTint
                      : ThemeProvider().themeData.focusColor,
              title: const Text(
                "ADD NEW EXPENSE",
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
                              ? [Colors.purpleAccent, Colors.blueAccent]
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
                                hintText: "Expense Name",
                                hintStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontFamily: "Sans")),
                            controller: newExpenseNameController,
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
                              ? [Colors.purpleAccent, Colors.blueAccent]
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
                              save();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Price",
                                prefixText: "₹  ",
                                prefixStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontSize: 20),
                                hintStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontFamily: "Sans")),
                            controller: newExpenseAmountController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              newExpenseNameController.value =
                                  const TextEditingValue(text: "Snacks");
                            });
                          },
                          child: Image.asset('images/chai.png'),
                        ),
                      ),
                      // MaterialButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       price = 60;
                      //       newExpenseNameController.value =
                      //           const TextEditingValue(text: "Tiffin");
                      //       newExpenseAmountController.value =
                      //           TextEditingValue(text: '$price');
                      //     });
                      //   },
                      //   child: Image.asset('images/tiffin.png'),
                      // ),
                      Flexible(
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              newExpenseNameController.value =
                                  const TextEditingValue(text: "Vegetables");
                              newExpenseAmountController.clear();
                            });
                          },
                          child: Image.asset('images/vegetables.png'),
                        ),
                      ),
                      Flexible(
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              newExpenseNameController.value =
                                  const TextEditingValue(text: "Medicine");
                            });
                          },
                          child: Image.asset('images/medicine.png'),
                        ),
                      ),
                      // MaterialButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       price = 7;
                      //       newExpenseNameController.value =
                      //           const TextEditingValue(text: "Egg");
                      //       newExpenseAmountController.value =
                      //           TextEditingValue(text: '$price');
                      //     });
                      //   },
                      //   child: Image.asset('images/egg.png'),
                      // ),
                      // MaterialButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       newExpenseNameController.value =
                      //           const TextEditingValue(text: "Spicey");
                      //       newExpenseAmountController.clear();
                      //     });
                      //   },
                      //   child: Image.asset('images/spicey.png'),
                      // ),
                    ],
                  )
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: const Text("SAVE"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("CANCEL"),
                ),
              ],
            ));
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
    toast("Expense Deleted Successfully", context, false);
    addFilt();
  }

  void save() {
    int i, f = 0;
    for (i = 0; i <= newExpenseAmountController.text.length.toInt() - 1; i++) {
      String n = newExpenseAmountController.text[i];
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
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty &&
        f == 0) {
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: newExpenseAmountController.text,
          dateTime: DateTime.now());
      setState(() {
        Provider.of<ExpenseData>(context, listen: false)
            .addNewExpense(newExpense);
      });
      Navigator.pop(context);
      clear();
      toast("Expense Added Successfully", context, true);
      addFilt();
    }
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  final _key = GlobalKey<ExpandableFabState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: ExpandableFab(
              key: _key,
              distance: 90,
              type: ExpandableFabType.fan,
              overlayStyle: const ExpandableFabOverlayStyle(blur: 2),
              openButtonBuilder: RotateFloatingActionButtonBuilder(
                child: const Icon(EvaIcons.menu),
                fabSize: ExpandableFabSize.regular,
                foregroundColor: Colors.white70,
                backgroundColor: Hive.box("theme").get(0) == 0
                    ? Colors.blueAccent
                    : ThemeProvider().themeData.secondaryHeaderColor,
              ),
              closeButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const Icon(EvaIcons.close),
                  fabSize: ExpandableFabSize.regular,
                  foregroundColor: Colors.white70,
                  backgroundColor: Hive.box("theme").get(0) == 0
                      ? Colors.blueAccent
                      : ThemeProvider().themeData.secondaryHeaderColor),
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Hive.box("theme").get(0) != 0 &&
                          ThemeProvider().isDarkMode
                      ? Colors.green
                      : Colors.blueAccent,
                  child: const Icon(
                    EvaIcons.calendarOutline,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    final state = _key.currentState;
                    if (state != null) {
                      debugPrint('isOpen:${state.isOpen}');
                      state.toggle();
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MonthShow()));
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Hive.box("theme").get(0) != 0 &&
                          ThemeProvider().isDarkMode
                      ? Colors.green
                      : Colors.blueAccent,
                  child: const Icon(
                    CupertinoIcons.arrow_2_circlepath_circle,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    final state = _key.currentState;
                    if (state != null) {
                      debugPrint('isOpen:${state.isOpen}');
                      state.toggle();
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BorrowLend()));
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Hive.box("theme").get(0) != 0 &&
                          ThemeProvider().isDarkMode
                      ? Colors.green
                      : Colors.blueAccent,
                  child: const Icon(
                    EvaIcons.plus,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      final state = _key.currentState;
                      if (state != null) {
                        debugPrint('isOpen:${state.isOpen}');
                        state.toggle();
                      }
                      addNewExpense();
                    });
                  },
                ),
              ],
            ),
            drawer: Drawer(
              child: Container(
                decoration: BoxDecoration(
                    color: ThemeProvider().themeData.cardColor,
                    image: DecorationImage(
                        image: (ThemeProvider().isDarkMode)
                            ? const AssetImage('images/drawer.jpg')
                            : const AssetImage('images/drawer_light.jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                  color: (ThemeProvider().isDarkMode)
                      ? Colors.black38
                      : Colors.white24,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Text("Good Morning, ${Hive.box("name").get(1)}"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  GradientText(
                                    "EXPENSO",
                                    colors: const [
                                      Colors.purpleAccent,
                                      Colors.blueAccent
                                    ],
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 50,
                                        fontFamily: "Madimi"),
                                  ),
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Expense ",
                                        style: TextStyle(
                                            color: Colors.purpleAccent),
                                      ),
                                      Text(
                                        "Tracker",
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListTile(
                              title: const Text("Home",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              leading: const Icon(
                                Icons.home,
                                color: Colors.blueAccent,
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            ListTile(
                              title: Text(
                                  (Hive.box("budget").get(1) == '' ||
                                          Hive.box("budget").values.isEmpty)
                                      ? "Add Budget"
                                      : "Edit Budget",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                  )),
                              leading: Icon(
                                CupertinoIcons.plus,
                                color: ThemeProvider().themeData.canvasColor,
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.pop(context);
                                  addBudget();
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            ListTile(
                              title: Text(
                                "Settings",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: ThemeProvider().themeData.canvasColor,
                                ),
                              ),
                              leading: Icon(
                                Icons.settings,
                                color: ThemeProvider().themeData.canvasColor,
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Setting()));
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawerButton(
                          style: ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(
                                  ThemeProvider().themeData.canvasColor)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (ThemeProvider().isDarkMode) {
                                  _controller.reverse(from: 1.7);
                                } else {
                                  _controller.forward(from: 0.2);
                                }
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .toggleTheme();
                                (Hive.box("theme").get(0) != 0)
                                    ? Restart.restartApp()
                                    : null;
                              });
                            },
                            child: LottieBuilder.asset(
                              'images/switch.json',
                              height: 40,
                              width: 60,
                              fit: BoxFit.contain,
                              controller: _controller,
                            ),
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       Provider.of<ThemeProvider>(context, listen: false)
                        //           .toggleTheme();
                        //       (Hive.box("theme").get(0) != 0)
                        //           ? Restart.restartApp()
                        //           : null;
                        //     });
                        //   },
                        //   color: Hive.box("theme").get(0) != 0 &&
                        //           ThemeProvider().isDarkMode
                        //       ? Colors.green
                        //       : Colors.blueAccent,
                        //   icon: Icon(ThemeProvider().isDarkMode
                        //       ? CupertinoIcons.moon_stars
                        //       : EvaIcons.sun),
                        // )
                      ],
                    ),
                  ),
                  Hive.box("theme").get(3) != 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello There,",
                                style: TextStyle(
                                    fontFamily: "Madimi",
                                    fontSize: 20,
                                    color:
                                        ThemeProvider().themeData.canvasColor),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editName();
                                  });
                                },
                                child: Hive.box("theme").get(0) == 0
                                    ? GradientText(
                                        "${Hive.box("name").get(1)}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                        colors: const [
                                          Colors.purpleAccent,
                                          Colors.blueAccent
                                        ],
                                      )
                                    : Text(
                                        "${Hive.box("name").get(1)}",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: (ThemeProvider().isDarkMode)
                                              ? const Color(0xff0AF2A6)
                                              : Colors.blueAccent.shade200,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  ExpenseSummary(
                    startOfWeek: value.startOfWeekDate(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: ThemeProvider().themeData.splashColor,
                  ),
                  (Hive.box("theme").get(2) != 0 && result.isNotEmpty)
                      ? Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: result.length,
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.all(1),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                gradient: LinearGradient(
                                  colors: (Hive.box("theme").get(0) == 0)
                                      ? [Colors.purpleAccent, Colors.blueAccent]
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
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (result[index] == filt) {
                                      filt = 0;
                                    } else {
                                      filt = result[index];
                                    }
                                  });
                                },
                                style: ButtonStyle(
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10)),
                                  backgroundColor: WidgetStatePropertyAll(
                                      (result[index] != filt)
                                          ? ThemeProvider().themeData.cardColor
                                          : Colors.transparent),
                                ),
                                child: Text(
                                  "${result[index]}/${value.getAllExpenseList()[index].dateTime.month}/${value.getAllExpenseList()[index].dateTime.year} ",
                                  style: TextStyle(
                                    color: ThemeProvider().isDarkMode
                                        ? Colors.white
                                        : (result[index] != filt)
                                            ? Colors.black
                                            : Colors.white,
                                    fontWeight: (result[index] != filt)
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.getAllExpenseList().length,
                      itemBuilder: (context, index) => (filt == 0)
                          ? ExpenseTile(
                              name: value.getAllExpenseList()[index].name,
                              amount: value.getAllExpenseList()[index].amount,
                              dateTime:
                                  value.getAllExpenseList()[index].dateTime,
                              deleteTapped: (p0) => deleteExpense(
                                  value.getAllExpenseList()[index]),
                            )
                          : (filt ==
                                  value.getAllExpenseList()[index].dateTime.day)
                              ? ExpenseTile(
                                  name: value.getAllExpenseList()[index].name,
                                  amount:
                                      value.getAllExpenseList()[index].amount,
                                  dateTime:
                                      value.getAllExpenseList()[index].dateTime,
                                  deleteTapped: (p0) => deleteExpense(
                                      value.getAllExpenseList()[index]),
                                )
                              : const SizedBox(),
                    ),
                  ),
                ],
              ),
            )));
  }
}
