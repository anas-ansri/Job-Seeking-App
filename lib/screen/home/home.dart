import 'package:ad_project/models/user.dart';
import 'package:ad_project/screen/home/info_page.dart';
import 'package:ad_project/screen/others/job_selection_page.dart';
import 'package:ad_project/screen/others/loading_screen.dart';
import 'package:ad_project/screen/others/splash_screen.dart';
import 'package:ad_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  UserData? userData;

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
        stream: DatabaseService(uid: uid).userDetail,
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.hasData) {
            userData = snapshot.data;
            if (userData!.job_prefs.length < 2) {
              return JobSelectionPage();
            } else {
              return InfoPage(
                userData: userData,
              );
            }
          } else {
            return LoadingScreen();
          }
        });
  }
}
