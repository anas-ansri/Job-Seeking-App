import 'package:flutter/material.dart';

//All constant variable and widget used throughout in this project.

//Primary Font : Source Sans Pro

const primartColor = Colors.red;
const secondryColor = Colors.white;

getHeightValue(BuildContext context) {
  double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
  return unitHeightValue;
}

getWidthValue(BuildContext context) {
  double unitWidthtValue = MediaQuery.of(context).size.height * 0.01;
  return unitWidthtValue;
}

const List<String> allJobFunction = [
  "None",
  "Administration / Office",
  "Arts and Culture",
  "Board Member",
  "Business / Corporate Services",
  "Client / Customer Services",
  "Communications",
  "Construction, Works, Engineering",
  "Education, Curriculum and Teaching",
  "Environment, Conservation and NRM",
  "Facility / Grounds Management and Maintenance",
  "Finance Management",
  "Health - Medical and Nursing Management",
  "HR, Training and Organisational Development",
  "Information and Communications Technology",
  "Information Services, Statistics, Records, Archives",
  "Infrastructure Management - Transport, Utilities",
  "Legal Officers and Practitioners",
  "Librarians and Library Management",
  "Management",
  "Marketing",
  "OH&S, Risk Management",
  "Operations Management",
  "Planning, Policy, Strategy",
  "Printing, Design, Publishing, Web",
  "Projects, Programs and Advisors",
  "Property, Assets and Fleet Management",
  "Public Relations and Media",
  "Purchasing and Procurement",
  "Quality Management",
  "Science and Technical Research and Development",
  "Security and Law Enforcement",
  "Service Delivery",
  "Sport and Recreation",
  "Travel, Accommodation, Tourism",
  "Wellbeing, Community / Social Services"
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
