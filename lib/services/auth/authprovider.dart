import 'package:my_first_app/services/auth/auth.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({required String email, required String password});
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();
  Future<void> sendEmailVerification();
   Future<void> sendPasswordReset({ required String toEmail});
}
