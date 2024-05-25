import 'package:expenso/components/month_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/expense_data.dart';

class MonthShow extends StatefulWidget {
  const MonthShow({super.key});

  @override
  State<MonthShow> createState() => _MonthShowState();
}

class _MonthShowState extends State<MonthShow> {
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
                color: Colors.blue,
              ),
              title: Text(
                "MONTHLY EXPENSE",
                style: TextStyle(fontFamily: "Sans"),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
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
                            )),
                  ),
                ],
              ),
            )));
  }
}
