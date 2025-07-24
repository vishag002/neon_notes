import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///controller
class SignupViewModelNotifier extends StateNotifier<SignUpState> {
  SignupViewModelNotifier() : super(SignUpState());

  //set email
  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  //set password
  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  //set confirmPassword
  void setConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value);
  }

  //sign-up function
  Future<bool> signUp() async {
    //check if textfields contain values
    if (state.email.isEmpty ||
        state.password.isEmpty ||
        state.confirmPassword.isEmpty) {
      state = state.copyWith(
        errorMessage: "Email and password cannot be empty",
      );
      return false;
    }
    //check password = confirmpassword
    if (state.password != state.confirmPassword) {
      state = state.copyWith(errorMessage: "Passwords do not match");
      return false;
    }

    //set the loading true
    state = state.copyWith(isLoading: true, errorMessage: null);

    //pass email and password to sign up
    try {
      // TODO: Replace with actual login logic (Firebase )

      await Future.delayed(const Duration(seconds: 2));
      // Example success (you can set errorMessage if login fails)
      print(
        "the email is ${state.email} ,the password is ${state.password},the Confirmpassword is ${state.confirmPassword}",
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
      return false;
    }
  }

  //signup with google
  void googleSignUpFunction({context}) {
    print('Login with Google button tapped!');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Google Login (mock)!')));
  }

  //reset value
  void resetState() {
    state = SignUpState(); // resets to initial state with empty fields
  }
}

//provider for signup controller
final signUpProvider =
    StateNotifierProvider<SignupViewModelNotifier, SignUpState>((ref) {
      return SignupViewModelNotifier();
    });

//simple class to hold user state

class SignUpState {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final String? errorMessage;

  SignUpState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.errorMessage,
  });

  SignUpState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
