import 'package:ad_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:news_ware/models/user.dart';
// import 'package:news_ware/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //auth change user steam
  // Continue from here
  // Stream<MyUser?> get user {
  //   return _auth
  //       .authStateChanges()
  //       .map((User? user) => _userFromFirebaseUser(user!));
  // }

  Future registerWithEmail(
      String email, String password, String displayName) async {
    // try {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;

      await DatabaseService(uid: user!.uid).userSetup(
          displayName,
          user.email,
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
          []);

      return result;
    } on Exception catch (e) {
      // TODO
      print(e.toString());
      return null;
    }
    // } catch (e) {
    //   print(e.toString());
    // }
  }

//sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // print(email);
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null;
    } catch (e) {
      // print(e.toString());
      return e;
    }
  }

//sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      return e;
    }
  }
}
