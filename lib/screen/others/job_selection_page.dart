import 'package:ad_project/models/user.dart';
import 'package:ad_project/services/database.dart';
import 'package:ad_project/utils/constants.dart';
import 'package:ad_project/utils/helper/list_item.dart';
import 'package:ad_project/utils/helper/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JobSelectionPage extends StatefulWidget {
  final UserData? userData;
  const JobSelectionPage({Key? key, this.userData}) : super(key: key);

  @override
  State<JobSelectionPage> createState() => _JobSelectionPageState();
}

class _JobSelectionPageState extends State<JobSelectionPage> {
  String? selectedItem = "None";
  final listKey = GlobalKey<AnimatedListState>();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  List<String> jobList = [];

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService(uid: uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: primartColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 24),
          Text(
            "Please select between 2 to 5 job functions",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 24),
          AnimatedList(
            key: listKey,
            shrinkWrap: true,
            initialItemCount: jobList.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return ListItemWidget(
                text: jobList[index],
                animation: animation,
                onClicked: () {
                  final removedItem = jobList[index];
                  jobList.removeAt(index);

                  listKey.currentState!.removeItem(
                      index,
                      (context, animation) => ListItemWidget(
                          text: removedItem, animation: animation));
                },
              );
            },
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              FittedBox(
                fit: BoxFit.fitHeight,
                child: DropdownButton<String>(
                  value: selectedItem,
                  items: allJobFunction
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            // style: TextStyle(fontSize: 10),
                          )))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedItem = val;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                  onPressed: () {
                    final newIndex = jobList.length;
                    if (selectedItem == "None") {
                      showAlertDialog(
                          context, "", "Please select a job preference", false);
                    } else {
                      jobList.insert(newIndex, selectedItem!);
                      listKey.currentState!.insertItem(newIndex);
                    }
                  },
                  child: Text("Add"))
            ],
          ),
          const SizedBox(height: 24),
          RoundedButton(
              fontSize: getWidthValue(context) * 2.5,
              text: "Done",
              press: () async {
                if (jobList.length > 5 || jobList.length < 2) {
                  showErrorAlert(
                      context, "Please select between 2 to 5 job functions");
                } else {
                  await db.updateJobPref(jobList);
                  showAlertDialog(context, "Thank you",
                      "Your details are updated successfully.", true);
                  Navigator.of(context, rootNavigator: true).pop();
                }
              })
        ],
      ),
    );
  }
}
