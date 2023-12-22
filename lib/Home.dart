import 'package:expenso/components/expense_summary.dart';
import 'package:expenso/components/expense_tile.dart';
import 'package:expenso/data/expense_data.dart';
import 'package:expenso/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  double price = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
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
                        gradient: const LinearGradient(
                            colors: [Colors.purpleAccent, Colors.blue])),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Expense Name",
                                hintStyle: TextStyle(
                                    color: Colors.white54, fontFamily: "Sans")),
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
                        gradient: const LinearGradient(
                            colors: [Colors.purpleAccent, Colors.blue])),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Price",
                                prefixText: "₹  ",
                                prefixStyle: TextStyle(
                                    color: Colors.white54, fontSize: 20),
                                hintStyle: TextStyle(
                                    color: Colors.white54, fontFamily: "Sans")),
                            controller: newExpenseAmountController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              newExpenseNameController.value =
                                  const TextEditingValue(text: "Bunty Bhaiya");
                            });
                          },
                          child: Image.asset('images/chai.png'),
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

                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              newExpenseNameController.value =
                                  const TextEditingValue(text: "Vegetables");
                              newExpenseAmountController.clear();
                            });
                          },
                          child: Image.asset('images/vegetables.png'),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              newExpenseNameController.value =
                                  const TextEditingValue(text: "Medicine");
                            });
                          },
                          child: Image.asset('images/medicine.png'),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              price = 7;
                              newExpenseNameController.value =
                                  const TextEditingValue(text: "Egg");
                              newExpenseAmountController.value =
                                  TextEditingValue(text: '$price');
                            });
                          },
                          child: Image.asset('images/egg.png'),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              newExpenseNameController.value =
                                  const TextEditingValue(text: "Spicey");
                              newExpenseAmountController.clear();
                            });
                          },
                          child: Image.asset('images/spicey.png'),
                        ),
                      ],
                    ),
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
  }

  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: newExpenseAmountController.text,
          dateTime: DateTime.now());
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      Navigator.pop(context);
      clear();
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

  bool cond = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            floatingActionButton: InkWell(
              onLongPress: () {
                setState(() {
                  cond = !cond;
                });
              },
              child: FloatingActionButton(
                onPressed: addNewExpense,
                backgroundColor: cond == true ? Colors.white24 : Colors.blue,
                child: Icon(
                  Icons.add,
                  color: cond == true ? Colors.white24 : Colors.black,
                ),
              ),
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  const SizedBox(height: 5),
                  ExpenseSummary(
                    startOfWeek: value.startOfWeekDate(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.white24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.getAllExpenseList().length,
                        itemBuilder: (context, index) => ExpenseTile(
                              name: value.getAllExpenseList()[index].name,
                              amount: value.getAllExpenseList()[index].amount,
                              dateTime:
                                  value.getAllExpenseList()[index].dateTime,
                              deleteTapped: (p0) => deleteExpense(
                                  value.getAllExpenseList()[index]),
                            )),
                  ),
                ],
              ),
            )));
  }
}
