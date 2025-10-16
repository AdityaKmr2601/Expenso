import 'package:expenso/bar%20graph/bar_graph.dart';
import 'package:expenso/data/expense_data.dart';
import 'package:expenso/datetime/date_time_helper.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ExpenseSummary extends StatefulWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  @override
  State<ExpenseSummary> createState() => _ExpenseSummaryState();
}

class _ExpenseSummaryState extends State<ExpenseSummary> {
  double calculateMax(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    double? max = 100;
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    values.sort();

    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  int dayGetter() {
    if (ExpenseData().db.readData().isNotEmpty) {
      return ExpenseData().db.readData()[0].dateTime.day;
    } else {
      return dateTime.day;
    }
  }

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String sunday = convertDateTimeToString(
        widget.startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTimeToString(
        widget.startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTimeToString(
        widget.startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimeToString(
        widget.startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimeToString(
        widget.startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTimeToString(
        widget.startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimeToString(
        widget.startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 25.0, right: 25, bottom: 25),
                  child: Column(
                    children: [
                      (dateTime.day == dayGetter())
                          ? (Hive.box("theme").get(0) == 0
                              ? GradientText(
                                  "Starting Today",
                                  style: const TextStyle(fontFamily: "Sans"),
                                  colors: [
                                    Color(Hive.box("theme").get("gradient")[0]),
                                    Color(Hive.box("theme").get("gradient")[1]),
                                  ],
                                )
                              : Text(
                                  "Starting Today",
                                  style: TextStyle(
                                      fontFamily: "Sans",
                                      color: (ThemeProvider().isDarkMode)
                                          ? const Color(0xff0AF2A6)
                                          : Colors.blueAccent.shade200),
                                ))
                          : (Hive.box("theme").get(0) == 0
                              ? GradientText(
                                  "Fr: ${dayGetter().toString().length == 1 ? '0' : ''}${dayGetter()}/${dateTime.month.toString().length == 1 ? '0' : ''}${dateTime.month}/${dateTime.year.toString()[2]}${dateTime.year.toString()[3]}  To: ${dateTime.day.toString().length == 1 ? '0' : ''}${dateTime.day}/${dateTime.month.toString().length == 1 ? '0' : ''}${dateTime.month}/${dateTime.year.toString()[2]}${dateTime.year.toString()[3]}",
                                  style: const TextStyle(fontFamily: "Sans"),
                                  colors: [
                                    Color(Hive.box("theme").get("gradient")[0]),
                                    Color(Hive.box("theme").get("gradient")[1]),
                                  ],
                                )
                              : Text(
                                  "Fr: ${dayGetter().toString().length == 1 ? '0' : ''}${dayGetter()}/${dateTime.month.toString().length == 1 ? '0' : ''}${dateTime.month}/${dateTime.year.toString()[2]}${dateTime.year.toString()[3]}  To: ${dateTime.day.toString().length == 1 ? '0' : ''}${dateTime.day}/${dateTime.month.toString().length == 1 ? '0' : ''}${dateTime.month}/${dateTime.year.toString()[2]}${dateTime.year.toString()[3]}",
                                  style: TextStyle(
                                    fontFamily: "Sans",
                                    color: (ThemeProvider().isDarkMode)
                                        ? const Color(0xff0AF2A6)
                                        : Colors.blueAccent.shade200,
                                  ),
                                )),
                      (dateTime.day != dayGetter())
                          ? Text(
                              "(${(dateTime.day - dayGetter()).toString().length == 1 ? '0' : ''}${dateTime.day - dayGetter()} ${dateTime.day - dayGetter() == 1 ? 'day' : 'days'})",
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  color: ThemeProvider().themeData.canvasColor,
                                  fontSize: 13),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text("Week Total: "),
                              Text(
                                  "₹${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}"),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Month Total: "),
                              Text("₹${value.monthly()}"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (Hive.box("budget").get(1) == '' ||
                                    Hive.box("budget").values.isEmpty ||
                                    double.parse(Hive.box("budget").get(1)) ==
                                        0)
                                ? const SizedBox()
                                : Text("Budget: ₹${Hive.box("budget").get(1)}"),
                            (Hive.box("budget").get(1) == '' ||
                                    Hive.box("budget").values.isEmpty ||
                                    double.parse(Hive.box("budget").get(1)) ==
                                        0)
                                ? const SizedBox()
                                : Text(
                                    "Budget Left: ₹${double.parse(Hive.box("budget").get(1)) - value.monthly()}",
                                    style: TextStyle(
                                        color: (double.parse(Hive.box("budget")
                                                        .get(1)) -
                                                    value.monthly() <
                                                0)
                                            ? Colors.red
                                            : ThemeProvider()
                                                .themeData
                                                .dividerColor),
                                  ),
                          ])
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: Hive.box("theme").get(2) == 0 ? 200 : 170,
                  child: MyBarGraph(
                      maxY: calculateMax(value, sunday, monday, tuesday,
                          wednesday, thursday, friday, saturday),
                      sunAmount:
                          value.calculateDailyExpenseSummary()[sunday] ?? 0,
                      monAmount:
                          value.calculateDailyExpenseSummary()[monday] ?? 0,
                      tueAmount:
                          value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                      wedAmount:
                          value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                      thurAmount:
                          value.calculateDailyExpenseSummary()[thursday] ?? 0,
                      friAmount:
                          value.calculateDailyExpenseSummary()[friday] ?? 0,
                      satAmount:
                          value.calculateDailyExpenseSummary()[saturday] ?? 0),
                ),
              ],
            ));
  }
}
