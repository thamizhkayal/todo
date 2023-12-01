import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/common_widgets/my_text_field.dart';
import 'package:todo/constants/my_firebase_exceptions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool emailValid = true;
  bool passwordValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        reverse: false,
        children: [
          SizedBox(height: 10),
          MyTextField(
            controller: emailController,
            hintText: 'Email',
            isError: !emailValid,
            onChange: (value) {
              emailValid = true;
              setState(() {});
            },
          ),
          SizedBox(height: 10),
          MyTextField(
            controller: passwordController,
            hintText: "Password",
            isError: !passwordValid,
            onChange: (value) {
              passwordValid = true;
              setState(() {});
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final auth = FirebaseAuth.instance;
                    try {
                      await auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                      print(e.code);
                      if (e.code == MyFirebaseException.invalidEmail) {
                        emailValid = false;
                        setState(() {});
                      }
                      if (e.code == MyFirebaseException.weakPassword) {
                        passwordValid = false;
                        setState(() {});
                      }
                      if (e.code == MyFirebaseException.invalidCredential) {
                        Fluttertoast.showToast(
                            msg:
                                "${MyFirebaseException.invalidCredential} either Email or Password",
                            timeInSecForIosWeb: 5);
                      }
                    }

                    // emailController.clear();
                    // passwordController.clear();
                  },
                  child: const Text("Login")),
              ElevatedButton(
                  onPressed: () async {
                    final auth = FirebaseAuth.instance;
                    try {
                      await auth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                      print(e.code);
                      if (e.code == MyFirebaseException.invalidEmail) {
                        emailValid = false;
                        setState(() {});
                      }
                      if (e.code == MyFirebaseException.weakPassword) {
                        passwordValid = false;
                        setState(() {});
                      }
                      if (e.code == MyFirebaseException.emailExist) {
                        Fluttertoast.showToast(
                            msg: "This email is Already exist");
                      }
                    }

                    // emailController.clear();
                    // passwordController.clear();
                  },
                  child: const Text("Signup"))
            ],
          )
        ],
      ),
    );
  }
}
