import "package:expenso/Home.dart";
import "package:expenso/theme/theme_provider.dart";
import "package:flutter/material.dart";
import "package:hive_flutter/adapters.dart";

final mybox = Hive.box("name");

class Name extends StatefulWidget {
  const Name({super.key});

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  String name = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/logo2.png'),
                filterQuality: FilterQuality.high,
                alignment: Alignment.center)),
        child: Scaffold(
          backgroundColor: Colors.black87,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expenso",
                  style: TextStyle(
                    color: Colors.purpleAccent.shade200,
                    fontSize: 60,
                    fontFamily: "Madimi",
                  ),
                ),
                Text(
                  "Expense",
                  style: TextStyle(
                    color: Colors.blue.shade400,
                    fontSize: 60,
                    fontFamily: "Madimi",
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      "Tracker",
                      style: TextStyle(
                        fontSize: 60,
                        fontFamily: "Madimi",
                      ),
                    ),
                    Text(
                      ".",
                      style: TextStyle(
                        color: Color(0xff1DE7B0),
                        fontSize: 60,
                        fontFamily: "Madimi",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                              colors: [Colors.purpleAccent, Colors.blue])),
                      child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ThemeProvider().themeData.cardColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: TextField(
                              onChanged: (value) {
                                name = value;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.purpleAccent,
                                ),
                                border: InputBorder.none,
                                hintText: "Enter Your Name",
                                hintStyle: TextStyle(
                                    color:
                                        ThemeProvider().themeData.canvasColor,
                                    fontFamily: "Sans"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (name.isNotEmpty) {
                            save(name);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                                colors: [Colors.purpleAccent, Colors.blue])),
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              color: ThemeProvider().themeData.cardColor,
                              fontFamily: "Madimi",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Disclaimer: We respect your privacy more than anything else. All of your data is stored locally on your device only.",
                      style: TextStyle(color: Colors.grey.withOpacity(0.7)),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void save(String name2) {
  mybox.put(1, name2);
}
