import 'dart:async';


import 'package:covid_tracker_app/View/world_status.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../AppStrings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {


  //Controller For Rotating the Splash Screen Image
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();


  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();

  }

  @override
  void initState() {
    super.initState();

    //Navigate to next Screen
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorldStatesScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _animationController,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Center(
                    child: Image(image: AssetImage('images/virus.png')),
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _animationController.value * 2.0 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                AppStrings.splashScreenText,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
