import 'dart:async';

import 'package:expenso/Home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: LottieBuilder.asset(
          'images/expenso.json',
          frameRate: FrameRate(120),
          controller: _controller,
          onLoaded: (composition) {
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller
              ..duration = composition.duration
              ..forward();
          },
        )),
      ),
    );
  }
}
