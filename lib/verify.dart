import 'package:flutter/material.dart';
import 'package:my_first_app/routes.dart';
import 'package:my_first_app/services/auth/authservice.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text(
            "We've sent you an email verification. Please open it to verify",
          ),
          const Text(
            "If you havent'nt received a verification E mail yet, click the button below",
          ),
          TextButton(
            onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send Email Verififcation'),
          ),

          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
