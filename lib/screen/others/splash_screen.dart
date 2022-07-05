import 'dart:async';
import 'package:ad_project/screen/others/loading_screen.dart';
import 'package:ad_project/utils/wrapper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState() {
    Timer(const Duration(seconds: 4), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return Wrapper();
        }), (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}
