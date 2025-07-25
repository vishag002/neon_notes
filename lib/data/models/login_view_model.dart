import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// ViewModel using StateNotifier to manage LoginState
class LoginViewModelNotifier extends StateNotifier<LoginState> {
  LoginViewModelNotifier() : super(const LoginState());

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  Future<bool> login() async {
    if (state.email.isEmpty || state.password.isEmpty) {
      state = state.copyWith(
        errorMessage: "Email and password cannot be empty",
      );
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      print("Logged in: ${credential.user?.uid}");
      print(
        "the email is ${state.email} and the password is ${state.password}",
      );

      state = state.copyWith(isLoading: false);
      return true;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);

      if (e.code == 'user-not-found') {
        state = state.copyWith(errorMessage: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        state = state.copyWith(errorMessage: "Wrong password provided.");
      } else {
        state = state.copyWith(
          errorMessage: e.message ?? "Authentication error.",
        );
      }

      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Login failed. Try again.",
      );
      return false;
    }
  }

  ///
  void googleSignUpFunction({context}) {
    print('Login with Google button tapped!');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Google Login (mock)!')));
  }

  void newUserNavigationFunction({required BuildContext context}) {
    context.go('/create-account');
    // ScaffoldMessenger.of(context).showSnackBar(

    //   const SnackBar(content: Text('Navigate to Register Screen (mock)!')),
    // );
  }

  //
  void resetState() {
    state = const LoginState(); // resets to initial state with empty fields
  }
}

/// Riverpod provider
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModelNotifier, LoginState>((ref) {
      return LoginViewModelNotifier();
    });

/////
///
/// A simple class to hold login form state
class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,

    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
