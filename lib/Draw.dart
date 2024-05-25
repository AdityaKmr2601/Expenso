import 'package:expenso/Home.dart';
import 'package:expenso/Settings.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Draw extends StatefulWidget {
  const Draw({super.key});

  @override
  State<Draw> createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  final List _pages = [const HomePage(), const Setting()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) => Scaffold(
        drawer: Drawer(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('images/logo.png'))),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // Text("Good Morning, ${Hive.box("name").get(1)}"),
                Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 60),
                    child: Column(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Expense ",
                              style: TextStyle(color: Colors.purpleAccent),
                            ),
                            Text(
                              "Tracker",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text(
                          "Home",
                          style: (index == 0)
                              ? const TextStyle(
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)
                              : const TextStyle(color: Colors.blueAccent),
                        ),
                        leading: Icon(
                          Icons.home,
                          size: (index == 0) ? 30 : 25,
                          color:
                              (index == 0) ? Colors.purpleAccent : Colors.blue,
                        ),
                        onTap: () {
                          setState(() {
                            index = 0;
                            Navigator.pop(context);
                          });
                        },
                      ),
                      ListTile(
                        title: Text(
                          "Settings",
                          style: (index == 1)
                              ? const TextStyle(
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)
                              : const TextStyle(color: Colors.blueAccent),
                        ),
                        leading: Icon(
                          Icons.settings,
                          size: (index == 1) ? 30 : 25,
                          color:
                              (index == 1) ? Colors.purpleAccent : Colors.blue,
                        ),
                        onTap: () {
                          setState(() {
                            index = 1;
                            Navigator.pop(context);
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              const Text("Hello There, "),
              GradientText("${Hive.box("name").get(1)}", colors: [
                Colors.purple.shade600,
                Colors.purpleAccent,
                Colors.blueAccent
              ]),
            ],
          ),
        ),
        body: _pages[index],
      ),
    );
  }
}
