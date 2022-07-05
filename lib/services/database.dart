import 'package:ad_project/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference userData =
      FirebaseFirestore.instance.collection("UserData");

  //Check if document exist
  Future<bool> isDocExists() async {
    try {
      var doc = await userData.doc(uid).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future userSetup(String? displayName, String? email, String? photoUrl,
      List<String>? job_prefs) async {
    bool docExists = await isDocExists();
    if (docExists) {
      return;
    } else {
      return await userData.doc(uid).set({
        'uid': uid,
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
        "job_prefs": job_prefs
      });
    }
  }

  Future updateUserName(String displayName) async {
    try {
      return await userData.doc(uid).update({'displayName': displayName});
    } catch (e) {
      rethrow;
    }
  }

  Future updateUserPic(String photoUrl) async {
    try {
      return await userData.doc(uid).update({'photoUrl': photoUrl});
    } catch (e) {
      rethrow;
    }
  }

  List<String> getJobList(DocumentSnapshot snapshot) {
    List<String> alldata = [];
    snapshot.get("job_prefs").map((doc) {
      alldata.add(doc);
    }).toList();
    return alldata;
  }

  // //UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    List<String> alldata = getJobList(snapshot);
    getJobList(snapshot);

    return UserData(uid, snapshot["displayName"], snapshot["email"],
        snapshot["photoUrl"], alldata);
  }

  //Get user doc steam
  Stream<UserData> get userDetail {
    return userData.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future updateJobPref(List<String> jobList) async {
    try {
      return await userData.doc(uid).update({'job_prefs': jobList});
    } catch (e) {
      rethrow;
    }
  }

  Future updateEmail(String newEmail) async {
    try {
      return await userData.doc(uid).update({'email': newEmail});
    } catch (e) {
      rethrow;
    }
  }
}
