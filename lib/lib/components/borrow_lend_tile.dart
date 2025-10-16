import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BorrowTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  BorrowTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.dateTime,
      this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: deleteTapped,
          icon: Icons.delete,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: Colors.red,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
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
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ThemeProvider().themeData.cardColor),
              child: ListTile(
                tileColor: ThemeProvider().themeData.focusColor,
                title: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    "${dateTime.day.toString().length == 1 ? '0' : ''}${dateTime.day}/${dateTime.month.toString().length == 1 ? '0' : ''}${dateTime.month}/${dateTime.year}    ${dateTime.hour.toString().length == 1 ? '0' : ''}${dateTime.hour}:${dateTime.minute.toString().length == 1 ? '0' : ''}${dateTime.minute}"),
                trailing: Text(
                  "₹${amount.toString().length == 1 ? '0' : ''}$amount",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LendTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  LendTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.dateTime,
      this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: deleteTapped,
          icon: Icons.delete,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: Colors.red,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
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
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ThemeProvider().themeData.cardColor),
              child: ListTile(
                tileColor: ThemeProvider().themeData.focusColor,
                title: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    "${dateTime.day.toString().length == 1 ? '0' : ''}${dateTime.day}/${dateTime.month.toString().length == 1 ? '0' : ''}${dateTime.month}/${dateTime.year}    ${dateTime.hour.toString().length == 1 ? '0' : ''}${dateTime.hour}:${dateTime.minute.toString().length == 1 ? '0' : ''}${dateTime.minute}"),
                trailing: Text(
                  "₹${amount.toString().length == 1 ? '0' : ''}$amount",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
