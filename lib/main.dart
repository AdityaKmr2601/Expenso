import 'package:expenso/Splash.dart';
import 'package:expenso/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("expense_database");
  await Hive.openBox("month");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ExpenseData(),
        builder: (context, child) => MaterialApp(
            title: 'Expenso',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: const ColorScheme.dark(),
                scaffoldBackgroundColor: Colors.black,
                fontFamily: "Sans",
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.blue)),
            home: const Splash()));
  }
}
