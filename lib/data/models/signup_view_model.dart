import 'package:firebase_auth/firebase_auth.dart';
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
    // Check if textfields contain values
    if (state.email.isEmpty ||
        state.password.isEmpty ||
        state.confirmPassword.isEmpty) {
      state = state.copyWith(
        errorMessage: "Email and password cannot be empty",
      );
      return false; // Returning false if the fields are empty
    }

    // Check if password equals confirm password
    if (state.password != state.confirmPassword) {
      state = state.copyWith(errorMessage: "Passwords do not match");
      return false; // Returning false if passwords don't match
    }

    // Set loading to true
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Firebase sign-up logic
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: state.email,
            password: state.confirmPassword,
          );

      // Example success, you can use credential.user to access the user
      print("User created: ${credential.user?.email}");

      state = state.copyWith(isLoading: false);

      return true; // Return true if successful
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      if (e.code == 'weak-password') {
        state = state.copyWith(
          errorMessage: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        state = state.copyWith(
          errorMessage: 'The account already exists for that email.',
        );
      } else {
        state = state.copyWith(errorMessage: e.message ?? "Signup failed.");
      }

      state = state.copyWith(isLoading: false);
      return false; // Return false on error
    } catch (error) {
      // Catch any general errors
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
      return false; // Return false for unknown errors
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
