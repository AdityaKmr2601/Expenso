import 'package:expenso/components/month_tile.dart';
import 'package:expenso/models/expense_item.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:expenso/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'data/expense_data.dart';

class MonthShow extends StatefulWidget {
  const MonthShow({super.key});

  @override
  State<MonthShow> createState() => _MonthShowState();
}

class _MonthShowState extends State<MonthShow> {
  void deleteMonth(Month month) {
    Provider.of<ExpenseData>(context, listen: false).deleteMonth(month);
    toast("Month Expense Deleted Successfully", context, false);
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
            color: (Hive.box("theme").get(0) == 0)
                ? Colors.blue
                : const Color(0xff0AF2A6),
          ),
          title: const Text(
            "MONTHLY EXPENSE",
            style: TextStyle(fontFamily: "Sans", fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: (value.getAllMonthList().isNotEmpty)
            ? SafeArea(
                child: ListView(
                  children: [
                    const Divider(
                      color: Colors.white24,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.getAllMonthList().length,
                            itemBuilder: (context, index) => MonthTile(
                                  name: value.getAllMonthList()[index].month,
                                  amount: value.getAllMonthList()[index].amount,
                                  deleteTapped: (p0) => deleteMonth(
                                      value.getAllMonthList()[index]),
                                ))),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 80.0, left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: LottieBuilder.asset(
                        "images/empty.json",
                        alignment: Alignment.center,
                      ),
                    ),
                    (Hive.box("theme").get(0) == 0
                        ? GradientText(
                            "Oops! Looks like you don't have a monthly data yet.\nYou'll have one in the next month!\nThank You!",
                            style: const TextStyle(
                                fontFamily: "Sans", fontSize: 20),
                            textAlign: TextAlign.center,
                            colors: const [
                              Colors.purple,
                              Colors.purpleAccent,
                              Colors.blueAccent,
                              Colors.blue
                            ],
                          )
                        : Text(
                            "Oops! Looks like you don't have a monthly data yet.\nYou'll have one in the next month!\nThank You!",
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
      ),
    );
  }
}
