import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/helpers/loading/loading_screen.dart';
import 'package:my_first_app/login.dart';
import 'package:my_first_app/notes/update_note_view.dart';
import 'package:my_first_app/notes/note.dart';
import 'package:my_first_app/register.dart';
import 'package:my_first_app/routes.dart';
import 'package:my_first_app/services/auth/bloc/auth_bloc.dart';
import 'package:my_first_app/services/auth/bloc/auth_event.dart';
import 'package:my_first_app/services/auth/bloc/auth_state.dart';
import 'package:my_first_app/services/auth/firebaseauthprovider.dart';
import 'package:my_first_app/utilities/forgotpassword.dart';
import 'package:my_first_app/verify.dart';
// import 'firebase_options.dart';
// import 'dart:developer' as devtools show log;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {updateNewNoteRoute: (context) => const CreateUpdateNoteView()},
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NoteView();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }
}
