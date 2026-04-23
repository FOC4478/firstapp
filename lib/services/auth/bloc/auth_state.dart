import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:my_first_app/services/auth/auth.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;

  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

// INITIAL
class AuthStateUninitialize extends AuthState {
  const AuthStateUninitialize() : super(isLoading: true);
}

// REGISTERING
class AuthStateRegistering extends AuthState {
  final Exception? exception;

  const AuthStateRegistering({this.exception, required bool isLoading}) : super(isLoading: false);
}

//forgot password
class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;

 const  AuthStateForgotPassword({
  required super.isLoading,
   super.loadingText,
    required this.exception, 
    required this.hasSentEmail,
    });
  
}

// LOGGED IN
class AuthStateLoggedIn extends AuthState {
  final AuthUser user;

  const AuthStateLoggedIn(this.user) : super(isLoading: false);
}

// NEED VERIFICATION
class AuthStateNeedVerification extends AuthState {
  const AuthStateNeedVerification() : super(isLoading: false);
}

// LOGGED OUT
class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;

  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(isLoading: isLoading, loadingText: loadingText);

  @override
  List<Object?> get props => [exception, isLoading];
}
