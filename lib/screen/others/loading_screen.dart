import 'package:ad_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: secondryColor,
        width: double.maxFinite,
        height: double.maxFinite,
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 1200),
          child: ListView(
            children: [
              SizedBox(
                height: 60,
              ),
              SizedBox(
                height: 120.0,
                width: 120.0,
                child: Center(child: Image.asset("assets/icons/app_icon.png")),
              ),
              const Padding(padding: EdgeInsets.only(top: 30.0)),
              const Text(
                "AD Project",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    // fontStyle: FontStyle.italic,
                    fontFamily: "AbrilFatface",
                    // fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white), ////HexColor("#fc6424")
              ),
              const Padding(padding: EdgeInsets.only(top: 150.0)),
              LoadingAnimationWidget.flickr(
                leftDotColor: Colors.green,
                rightDotColor: Colors.red,
                size: 60,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Created by Anas Ansari",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
            ],
            // ),
          ),
        ),
      ),
    );
  }
}
