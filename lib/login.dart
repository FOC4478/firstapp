import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools;

import 'package:my_first_app/routes.dart';
import 'package:my_first_app/utilities.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Enter Your Email"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Enter Your Password"),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false) {
                  // user is verified
                  Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(noteRoute, (route) => false);
                } else {
                  // user is not verified
                  Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
                }

                if (!mounted) return;
              } on FirebaseAuthException catch (e) {
                if (!mounted) return;

                String message;

                switch (e.code) {
                  case 'user-not-found':
                    message = 'User not found';
                    break;
                  case 'wrong-password':
                    message = 'Wrong password';
                    break;
                  
                  default:
                    message = e.message ?? 'Authentication error';
                }

                devtools.log('Error: ${e.code}');

                await showErrorDialog(context, message);
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Not Registered yet? Register here!'),
          ),
        ],
      ),
    );
  }
}
