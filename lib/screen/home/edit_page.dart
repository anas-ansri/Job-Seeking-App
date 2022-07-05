import 'package:ad_project/models/user.dart';
import 'package:ad_project/services/database.dart';
import 'package:ad_project/utils/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
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
              onChanged: (email) {},
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   "You can not modify email",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: Colors.red[300]),
            // ),
            const SizedBox(height: 24),
            TextFieldWidget(
              readOnly: true,
              label: 'Edit job preferences',
              text: widget.userData!.email,
              onChanged: (email) {},
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
                  Navigator.of(context).pop();
                })
          ],
        ));
  }
}
