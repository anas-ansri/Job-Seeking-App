import 'package:ad_project/screen/auth/background.dart';
import 'package:ad_project/screen/auth/sign_up_screen.dart';
import 'package:ad_project/screen/others/loading_screen.dart';
import 'package:ad_project/services/authentication.dart';
import 'package:ad_project/utils/constants.dart';
import 'package:ad_project/utils/helper/already_have_an_account_acheck.dart';
import 'package:ad_project/utils/helper/rounded_button.dart';
import 'package:ad_project/utils/helper/rounded_input_field.dart';
import 'package:ad_project/utils/helper/rounded_password_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();
    return loading
        ? const LoadingScreen()
        : Background(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 50.0),
                      ),
                      const Text(
                        "Please sign in to continue.",
                        style: TextStyle(
                            color: Colors.black26,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                      SizedBox(height: getHeightValue(context) * 10),
                      // SizedBox(height: getHeightValue(context) * 0.03),
                      RoundedInputField(
                        validator: (val) {
                          if (val!.isEmpty || !val.contains("@")) {
                            return "Please enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        hintText: "Your Email",
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      RoundedPasswordField(
                        validator: (value) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                          if (value!.isEmpty) {
                            return "Password is required, password should contain at least 8 letters.";
                          } else if (value.length < 8) {
                            return ("Password Must be more than 8 characters");
                          } else if (!regex.hasMatch(value)) {
                            return ("Password should contain upper,lower and digit.");
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      RoundedButton(
                        fontSize: getWidthValue(context) * 2.5,
                        text: "LOGIN",
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _authService
                                .signInWithEmailAndPassword(email, password);
                            if (result != null) {
                              setState(() {
                                error = result.toString();
                                loading = false;
                              });
                            }
                            setState(() {
                              error = result.toString();
                              loading = false;
                            });
                          } else {
                            const Text("Invalid Credentials");
                          }
                        },
                      ),
                      SizedBox(height: getHeightValue(context) * 0.03),
                      AlreadyHaveAnAccountCheck(
                        login: true,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUpScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
