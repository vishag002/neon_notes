import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

/// ViewModel using StateNotifier to manage LoginState
class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel() : super(const LoginState());

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
      // TODO: Replace with actual login logic (Firebase or API)
      await Future.delayed(const Duration(seconds: 2));
      // Example success (you can set errorMessage if login fails)
      print(
        "the email is ${state.email} and the password is ${state.password}",
      );

      state = state.copyWith(isLoading: false);

      return true;
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
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
      return LoginViewModel();
    });
