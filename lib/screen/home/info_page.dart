import 'package:ad_project/models/user.dart';
import 'package:ad_project/screen/home/edit_page.dart';
import 'package:ad_project/screen/others/loading_screen.dart';
import 'package:ad_project/screen/others/user_page.dart';
import 'package:ad_project/services/authentication.dart';
import 'package:ad_project/utils/constants.dart';
import 'package:ad_project/utils/helper/list_item.dart';
import 'package:ad_project/utils/helper/profile_widget.dart';
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
                const SizedBox(height: 30),
                Divider(
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text(
                  "Job Preferences",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: AnimatedList(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                ),
                SizedBox(
                  height: 30,
                )
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
}
