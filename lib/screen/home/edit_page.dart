import 'package:ad_project/models/user.dart';
import 'package:ad_project/services/database.dart';
import 'package:ad_project/utils/constants.dart';
import 'package:ad_project/utils/helper/list_item.dart';
import 'package:ad_project/utils/helper/profile_widget.dart';
import 'package:ad_project/utils/helper/rounded_button.dart';
import 'package:ad_project/utils/helper/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  final UserData? userData;
  const EditPage({Key? key, this.userData}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String _newName = "";
  String _newPhotoUrl = "";
  String? selectedItem = "None";
  String _newEmail = "";
  final listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseService db = DatabaseService(uid: uid);
    List<String> jobList = widget.userData!.job_prefs;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          centerTitle: true,
          backgroundColor: primartColor,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 60,
            ),
            EditProfileWidget(
              imagePath: (_newPhotoUrl == ""
                  ? widget.userData!.photoUrl
                  : _newPhotoUrl),
              isEdit: true,
              onClicked: () async {
                String downloadURL;

                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 10,
                );
                if (pickedFile == null) {
                  return showAlertDialog(context, "Photo not selected",
                      "Please select a picture.", false);
                } else {
                  File image = File(pickedFile.path);

                  var reference = FirebaseStorage.instance.ref().child(
                      'UserData/$uid/profile_pic.jpg'); // Modify this path/string as your need
                  UploadTask uploadTask = reference.putFile(image);
                  downloadURL = await (await uploadTask).ref.getDownloadURL();
                  if (!mounted) return;
                  setState(() {
                    _newPhotoUrl = downloadURL;
                    // print(downloadURL);
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: widget.userData!.displayName,
              onChanged: (name) {
                setState(() {
                  _newName = name;
                });
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              readOnly: false,
              label: 'Email',
              text: widget.userData!.email,
              onChanged: (email) {
                setState(() {
                  _newEmail = email;
                });
              },
            ),
            const SizedBox(height: 24),
            Text(
              "Edit job preferences",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 24),
            AnimatedList(
              key: listKey,
              shrinkWrap: true,
              initialItemCount: jobList.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
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
                        showAlertDialog(context, "",
                            "Please select a job preference", false);
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
                  if (_newName != "") {
                    await db.updateUserName(_newName);
                  }
                  if (_newPhotoUrl != "") {
                    await db.updateUserPic(_newPhotoUrl);
                  }
                  if (_newEmail != "") {
                    await db.updateEmail(_newEmail);
                  }
                  if (jobList.length > 5 || jobList.length < 2) {
                    showErrorAlert(
                        context, "Please select between 2 to 5 job functions");
                  } else {
                    await db.updateJobPref(jobList);
                    showAlertDialog(context, "Thank you",
                        "Your details are updated successfully.", true);
                  }
                })
          ],
        ));
  }
}
