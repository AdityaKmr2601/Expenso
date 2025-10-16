import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:toastification/toastification.dart';

void toast(String msg, context, bool type) {
  toastification.show(
      context: context,
      title: Text(
        msg,
        style: const TextStyle(fontFamily: "Sans", fontWeight: FontWeight.bold),
      ),
      style: ToastificationStyle.flatColored,
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.none,
      foregroundColor: ThemeProvider().themeData.dividerColor,
      backgroundColor: ThemeProvider().themeData.scaffoldBackgroundColor,
      primaryColor: (Hive.box("theme").get(0) == 0)
          ? Color(Hive.box("theme").get("gradient")[0])
          : ThemeProvider().themeData.secondaryHeaderColor,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      icon: Icon(
        (type == true) ? Icons.check : Icons.delete,
        color: (type == true) ? Colors.green : Colors.red.withOpacity(0.7),
      ),
      alignment: Alignment.topCenter,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 200),
      autoCloseDuration: const Duration(seconds: 2));
}
