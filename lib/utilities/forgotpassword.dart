import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/services/auth/bloc/auth_bloc.dart';
import 'package:my_first_app/services/auth/bloc/auth_event.dart';
import 'package:my_first_app/services/auth/bloc/auth_state.dart';
import 'package:my_first_app/utilities/genericerrordialogue.dart';
import 'package:my_first_app/utilities/passwordresetdialogue.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialogue(context);
          }
          if (state.exception != null) {
            await showErrorDialogue(
              context,
              'We could not process. please make sure you have reistered',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Enter your Email to Reset Your Password'),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller:_controller,
                decoration: const InputDecoration(
                  hintText: 'Your Enail Address' 
                ),
              ),
              TextButton(
                onPressed: () {
                final email = _controller.text;
                context.read<AuthBloc>().add(
                  AuthEventForgotPassword(email: email));
                },
                 child: const Text('Send me reset password link'),
                 ),

                  TextButton(
                onPressed: () => {
                context.read<AuthBloc>().add(const AuthEventLogOut())
                },
                 child: const Text('Back to login page'),
                 )
            ],
          ),
        ),
      ),
    );
  }
}
