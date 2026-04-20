import 'package:flutter/material.dart';
import 'package:my_first_app/routes.dart';
import 'package:my_first_app/services/auth/authexception.dart';
import 'package:my_first_app/services/auth/authservice.dart';
import 'package:my_first_app/utilities/genericerrordialogue.dart';

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
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );

                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
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

              } on UserNotFoundAuthException {
                await showErrorDialogue(context, 'User Not Found');
              } on WrongPasswordAuthException {
                await showErrorDialogue(context, 'Wrong Credentials');
              } on GenericAuthException {
                await showErrorDialogue(context, 'Authentication Error');
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
