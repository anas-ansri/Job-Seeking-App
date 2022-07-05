import 'package:flutter/material.dart';

//Primary Color: #990011FF
//Secondry Color: #FCF6F5FF
//Primary Font : Source Sans Pro

const primartColor = Colors.red;
const secondryColor = Colors.white;

Widget appTitle = const Text(
  "NEWSWARE",
  style: TextStyle(
      // fontStyle: FontStyle.italic,
      fontFamily: "AbrilFatface",
      // fontStyle: FontStyle.italic,
      // fontWeight: FontWeight.bold,
      color: Colors.white), ////HexColor("#fc6424")
);

getHeightValue(BuildContext context) {
  double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
  return unitHeightValue;
}

getWidthValue(BuildContext context) {
  double unitWidthtValue = MediaQuery.of(context).size.height * 0.01;
  return unitWidthtValue;
}

const List<String> allCountries = [
  "ae",
  "ar",
  "at",
  "au",
  "be",
  "bg",
  "br",
  "ca",
  "ch",
  "cn",
  "co",
  "cu",
  "cz",
  "de",
  "eg",
  "fr",
  "gb",
  "gr",
  "hk",
  "hu",
  "id",
  "ie",
  "il",
  "in",
  "it",
  "jp",
  "kr",
  "lt",
  "lv",
  "ma",
  "mx",
  "my",
  "ng",
  "nl",
  "no",
  "nz",
  "ph",
  "pl",
  "pt",
  "ro",
  "rs",
  "ru",
  "sa",
  "se",
  "sg",
  "si",
  "sk",
  "th",
  "tr",
  "tw",
  "ua",
  "us",
  "ve",
  "za"
];

showErrorAlert(BuildContext context, String error) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.black38, width: 0)),
    title: const Text("Something went wrong!!"),
    content: Text("Error: $error"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog(
    BuildContext context, String title, String content, bool isFeedback) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
      if (isFeedback) {
        Navigator.of(context).pop();
      }
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.black38, width: 0)),
    title: Text(title),
    content: Text(content),
    // title: const Text("Photo not selected"),
    // content: const Text("You haven't selected any picture."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
