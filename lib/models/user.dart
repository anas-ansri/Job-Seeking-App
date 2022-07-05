class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
  final List<String> job_prefs;

  UserData(
      this.uid, this.displayName, this.email, this.photoUrl, this.job_prefs);
}
