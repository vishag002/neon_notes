import 'package:firebase_setup/views/auth/create_account_screen.dart';
import 'package:firebase_setup/views/auth/login_screen.dart';
import 'package:firebase_setup/views/home/home_screen.dart';
import 'package:firebase_setup/views/home/profile_screen.dart';
import 'package:firebase_setup/views/home/splash_screen.dart'
    hide HomeScreen, LoginScreen;
import 'package:firebase_setup/views/note/notes_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    // Splash screen
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),

    // Home screen
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),

    // Login screen
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),

    // Create account screen
    GoRoute(
      path: '/create-account',
      name: 'createAccount',
      builder: (BuildContext context, GoRouterState state) {
        return const CreateAccountScreen();
      },
    ),

    // Add notes screen
    GoRoute(
      path: '/add-note',
      name: 'addNote',
      builder: (BuildContext context, GoRouterState state) {
        return const NotesAddScreen();
      },
    ),

    // Profile screen
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
  ],
);
