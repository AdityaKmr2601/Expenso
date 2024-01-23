import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MonthTile extends StatefulWidget {
  final String name;
  final String amount;
  void Function(BuildContext)? deleteTapped;

  MonthTile(
      {super.key, required this.name, required this.amount, this.deleteTapped});

  @override
  State<MonthTile> createState() => _MonthTileState();
}

class _MonthTileState extends State<MonthTile> {
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
              gradient: const LinearGradient(
                  colors: [Colors.purpleAccent, Colors.blueAccent])),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.black87),
              child: ListTile(
                tileColor: Colors.black,
                title: Text(
                  widget.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
