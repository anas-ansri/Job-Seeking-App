import 'package:ad_project/screen/auth/background.dart';
import 'package:ad_project/screen/auth/login_screen.dart';
import 'package:ad_project/screen/others/loading_screen.dart';
import 'package:ad_project/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:ad_project/utils/constants.dart';
import 'package:ad_project/utils/helper/already_have_an_account_acheck.dart';
import 'package:ad_project/utils/helper/rounded_button.dart';
import 'package:ad_project/utils/helper/rounded_input_field.dart';
import 'package:ad_project/utils/helper/rounded_password_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String name = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
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
                    children: [
                      const Text(
                        "Create Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      SizedBox(height: getHeightValue(context) * 5),
                      RoundedInputField(
                        hintText: "Your Name",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name can not be empty";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
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
                      Text(error),
                      RoundedButton(
                        fontSize: getWidthValue(context) * 2.5,
                        text: "SIGNUP",
                        press: () async {
                          loading = true;
                          try {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });

                              dynamic result = await _auth.registerWithEmail(
                                  email, password, name);
                              if (result == null) {
                                setState(() {
                                  error = "Please enter valid credentials";
                                  loading = false;
                                });
                              }
                            } else {
                              const Text("Please Enter valid credentials");
                            }
                          } catch (e) {
                            print(e.toString());
                            error = e.toString();
                            // TODO
                            showErrorAlert(context, e.toString());
                          }
                        },
                      ),
                      SizedBox(height: getHeightValue(context) * 0.03),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginScreen();
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
