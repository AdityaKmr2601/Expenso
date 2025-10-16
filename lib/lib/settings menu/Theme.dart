import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

class ThemeSetting extends StatefulWidget {
  const ThemeSetting({super.key});

  @override
  State<ThemeSetting> createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSetting> {
  @override
  void initState() {
    super.initState();
  }

  var db = Hive.box("theme");

  void restartAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeProvider().themeData.focusColor,
        content: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [Text("Restart the app for the changes to take affect.")],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Restart Later",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    Restart.restartApp();
                  },
                  child: const Text(
                    "Restart Now",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Theme"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .popUntil((Route<dynamic> route) => route.isFirst);
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Dark Mode",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false)
                          .isDarkMode,
                      onChanged: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                        (Hive.box("theme").get(0) != 0) ? restartAlert() : null;
                      }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Greeting",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoSwitch(
                      value: db.get(3) == 0 ? false : true,
                      onChanged: (value) async {
                        setState(() {
                          if (db.get(3) == 0) {
                            db.put(3, 1);
                          } else {
                            db.put(3, 0);
                          }
                          restartAlert();
                          // Restart.restartApp();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mono Color",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoSwitch(
                      value: db.get(0) == 0 ? false : true,
                      onChanged: (value) async {
                        setState(() {
                          if (db.get(0) == 0) {
                            db.put(0, 1);
                          } else {
                            db.put(0, 0);
                          }
                          restartAlert();
                          // Restart.restartApp();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              Hive.box("theme").get(0) == 0
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Gradient Color:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  var gradlist = [0xFFE040FB, 0xFF448AFF];
                                  db.put("gradient", gradlist);
                                  print(db.get("gradient"));
                                  restartAlert();
                                });
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: db.get("gradient")[0] == 4292886779 &&
                                          db.get("gradient")[1] == 4282682111
                                      ? const BoxBorder.fromBorderSide(
                                          BorderSide(
                                              width: 1, color: Colors.blue))
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFE040FB),
                                        Color(0xFF448AFF),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  var gradlist = [0xFF00FF5B, 0xFF0024FF];
                                  db.put("gradient", gradlist);
                                  print(db.get("gradient"));
                                  restartAlert();
                                });
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: db.get("gradient")[0] == 4278255451 &&
                                          db.get("gradient")[1] == 4278199551
                                      ? const BoxBorder.fromBorderSide(
                                          BorderSide(
                                              width: 1, color: Colors.blue))
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF00FF5B),
                                        Color(0xFF0024FF),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  var gradlist = [0xFFFFE53B, 0xFFFF2525];
                                  db.put("gradient", gradlist);
                                  print(db.get("gradient"));
                                  restartAlert();
                                });
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: db.get("gradient")[0] == 4294960443 &&
                                          db.get("gradient")[1] == 4294911269
                                      ? const BoxBorder.fromBorderSide(
                                          BorderSide(
                                              width: 1, color: Colors.blue))
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFFE53B),
                                        Color(0xFFFF2525),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  var gradlist = [0xFF00E1FD, 0xFFFC007A];
                                  db.put("gradient", gradlist);
                                  print(db.get("gradient"));
                                  restartAlert();
                                });
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: db.get("gradient")[0] == 4278247933 &&
                                          db.get("gradient")[1] == 4294705274
                                      ? const BoxBorder.fromBorderSide(
                                          BorderSide(
                                              width: 1, color: Colors.blue))
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF00E1FD),
                                        Color(0xFFFC007A),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  var gradlist = [0xFFc31432, 0xFF242b66];
                                  db.put("gradient", gradlist);
                                  print(db.get("gradient"));
                                  restartAlert();
                                });
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: db.get("gradient")[0] == 4290974770 &&
                                          db.get("gradient")[1] == 4280560486
                                      ? const BoxBorder.fromBorderSide(
                                          BorderSide(
                                              width: 1, color: Colors.blue))
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFc31432),
                                        Color(0xFF242b46),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filter Chips",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoSwitch(
                      value: db.get(2) == 0 ? false : true,
                      onChanged: (value) async {
                        setState(() {
                          if (db.get(2) == 0) {
                            db.put(2, 1);
                          } else {
                            db.put(2, 0);
                          }
                          restartAlert();
                          // Restart.restartApp();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
