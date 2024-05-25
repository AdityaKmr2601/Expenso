import 'package:expenso/settings%20menu/Theme.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

List buttons = [
  [
    'theme.png',
    "Theme",
    "Dark Mode, Font, Color, Gradient",
    const ThemeSetting()
  ],
  // ['info.png', "About", "Share App, Contact Us", HomePage()],
  // ['theme.png', "Theme", "Dark Mode, Font, Color, Gradient", HomePage()],
];

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Settings"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil((Route<dynamic> route) => route.isFirst);
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, value, child) => SafeArea(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => buttons[index][3]));
                          });
                        },
                        leading: Image.asset('images/${buttons[index][0]}'),
                        title: Text(
                          buttons[index][1],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(buttons[index][2]),
                        subtitleTextStyle: TextStyle(
                            color: ThemeProvider().themeData.splashColor),
                      ),
                    ))),
      ),
    );
  }
}
