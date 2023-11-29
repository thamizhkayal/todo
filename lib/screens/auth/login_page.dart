import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: passwordController,
          ),
          ElevatedButton(
              onPressed: () async {
                final auth = FirebaseAuth.instance;
                try {
                  await auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                } on FirebaseAuthException catch (e) {
                  print(e.message);
                }

                emailController.clear();
                passwordController.clear();
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
                }

                emailController.clear();
                passwordController.clear();
              },
              child: const Text("Signup"))
        ],
      ),
    );
  }
}
