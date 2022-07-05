import 'package:ad_project/screen/auth/login_screen.dart';
import 'package:ad_project/screen/home/home.dart';
import 'package:ad_project/screen/others/loading_screen.dart';
import 'package:ad_project/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return showErrorAlert(context, snapshot.error.toString());
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
