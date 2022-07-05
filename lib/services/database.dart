import 'package:ad_project/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // User? user = FirebaseAuth.instance.currentUser;
  //Collection Refrance
  final CollectionReference userData =
      FirebaseFirestore.instance.collection("UserData");

  // await ref.set({
  //   "name": "John",
  //   "age": 18,
  //   "address": {
  //     "line1": "100 Mountain View"
  //   }
  // });

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

  Future setCountry(String country) async {
    try {
      return await userData.doc(uid).update({'country': country});
    } catch (e) {
      rethrow;
    }
  }

  Future getCountry() async {
    try {
      // Stream documentStream = userData.doc(uid).snapshots();
      // final docRef = userData.doc(uid);
      userData.doc(uid).snapshots().listen(
        (event) {
          // print("current data: ${event.data()}");
          // dat
          // return data["country"];
          // var jsonData = jsonDecode(data);
          // data.foreach(()=>)
        },
        // onError: (error) => print("Listen failed: $error"),
      );
      // await userData.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      //   // print(documentSnapshot["country"]);
      //   country = documentSnapshot["country"];
      //   // return country;
      // });
      // print(country);
      // return country;
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
}
