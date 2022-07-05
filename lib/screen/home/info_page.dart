import 'package:ad_project/models/user.dart';
import 'package:ad_project/screen/home/edit_page.dart';
import 'package:ad_project/screen/others/loading_screen.dart';
import 'package:ad_project/screen/others/user_page.dart';
import 'package:ad_project/services/authentication.dart';
import 'package:ad_project/utils/constants.dart';
import 'package:ad_project/utils/helper/list_item.dart';
import 'package:ad_project/utils/helper/profile_widget.dart';
import 'package:ad_project/utils/helper/rounded_button.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  final UserData? userData;
  const InfoPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool loading = false;
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    List<String> jobList = widget.userData!.job_prefs;
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "AD Project",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _authService.signOut();
                    if (result == null) {
                      setState(() {
                        loading = false;
                      });
                    } else {
                      setState(() {
                        loading = false;
                      });
                      showErrorAlert(context, result.toString());
                    }
                  },
                  icon: Icon(Icons.logout)),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => EditPage(
                                userData: widget.userData,
                              )),
                    );
                  },
                  icon: Icon(Icons.edit),
                )
              ],
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                // Spacer(),
                const SizedBox(
                  height: 40,
                ),
                ProfileWidget(
                  onClick: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserPage(
                        name: widget.userData!.displayName,
                        urlImage: widget.userData!.photoUrl,
                      ),
                    ));
                  },
                  imagePath: widget.userData!.photoUrl,
                ),
                const SizedBox(height: 24),
                buildName(widget.userData!),
                const SizedBox(height: 24),
                Divider(
                  color: Colors.grey,
                ),
                Text(
                  "Job Preferences",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                AnimatedList(
                  shrinkWrap: true,
                  initialItemCount: jobList.length,
                  itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) {
                    return ListItemWidget(
                      editable: false,
                      text: jobList[index],
                      animation: animation,
                    );
                  },
                ),
              ],
            ));
  }

  Widget buildName(UserData userData) => Column(
        children: [
          Text(
            "Name : ${userData.displayName}",
            // userData.displayName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            "Email : ${userData.email}",
            style: TextStyle(color: Colors.grey[800], fontSize: 16),
          )
        ],
      );

  // buildCard(List<String> job_prefs) {
  //   return Card(
  //     color: Colors.red,
  //     shadowColor: Colors.black54,
  //     margin: const EdgeInsets.all(10),
  //     shape: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(15),
  //         borderSide: const BorderSide(color: Colors.black38, width: 0)),
  //     child: Column(
  //       children: [
  //         // SizedBox(
  //         //   height: 20,
  //         // ),
  //         // Text(
  //         //   "Job Preferences",
  //         //   style: const TextStyle(
  //         //       color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
  //         // ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         ListView.builder(
  //           shrinkWrap: true,
  //           physics: const BouncingScrollPhysics(),
  //           itemCount: job_prefs.length,
  //           itemBuilder: (context, index) {
  //             return listItem(job_prefs[index]);
  //           },
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget listItem(String text) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 20),
  //     margin: const EdgeInsets.symmetric(vertical: 4),
  //     child: ElevatedButton(
  //       child: Text(
  //         text,
  //         style: TextStyle(color: Colors.black, fontSize: 20),
  //       ),
  //       onPressed: () {},
  //       style: ElevatedButton.styleFrom(
  //           primary: Colors.white,
  //           textStyle: TextStyle(
  //               color: Colors.white,
  //               fontSize: 14,
  //               fontWeight: FontWeight.w500)),
  //     ),
  //   );
  // }
}
