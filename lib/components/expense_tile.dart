import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseTile extends StatefulWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  ExpenseTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.dateTime,
      this.deleteTapped});

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: widget.deleteTapped,
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
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ThemeProvider().themeData.cardColor),
              child: ListTile(
                tileColor: ThemeProvider().themeData.focusColor,
                title: Text(
                  widget.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    "${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}    ${widget.dateTime.hour}:${widget.dateTime.minute}"),
                trailing: Text(
                  "₹${widget.amount}",
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
