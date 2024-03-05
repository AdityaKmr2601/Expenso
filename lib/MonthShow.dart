import 'package:expenso/components/month_tile.dart';
import 'package:expenso/models/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  void deleteMonth(Month expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteMonth(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.back),
                color: Colors.blue,
              ),
              centerTitle: true,
              title: Text(
                "Monthly Expense",
                style: TextStyle(fontFamily: "Sans", fontSize: 20),
              ),
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  const Divider(
                    color: Colors.white24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: (value.getAllMonthList().isNotEmpty)
                        ? ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.getAllMonthList().length,
                            itemBuilder: (context, index) => MonthTile(
                                  name: value.getAllMonthList()[index].month,
                                  amount: value.getAllMonthList()[index].amount,
                                  deleteTapped: (p0) => deleteMonth(
                                      value.getAllMonthList()[index]),
                                ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              LottieBuilder.asset(
                                'images/empty.json',
                                fit: BoxFit.cover,
                              ),
                              GradientText(
                                "Oops! Looks like you don't have a monthly data yet.\nYou'll have one in the next month !\nThank You!",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: "Sans",
                                ),
                                colors: const [
                                  Colors.purpleAccent,
                                  Colors.blue
                                ],
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            )));
  }
}
