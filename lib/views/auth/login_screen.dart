// screens/login_screen.dart
import 'package:firebase_setup/core/color_const.dart';
import 'package:firebase_setup/views/home/home_screen.dart';
import 'package:firebase_setup/widgets/neon_notes_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  // Removed onThemeModeChanged and currentThemeMode properties
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late LinearGradient _emailBorderGradient;
  late LinearGradient _passwordBorderGradient;

  @override
  void initState() {
    super.initState();
    _emailBorderGradient = AppColors.generateRandomNeonGradient();
    _passwordBorderGradient = AppColors.generateRandomNeonGradient();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required FocusNode focusNode,
    required LinearGradient borderGradient,
    bool isPassword = false,
  }) {
    const double borderWidth = 2.0;
    const double glowBlurRadius = 20.0;
    const double glowSpreadRadius = 0.0;
    const double glowOpacity = 0.1;

    return AnimatedBuilder(
      animation: focusNode,
      builder: (context, child) {
        final bool isFocused = focusNode.hasFocus;
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.0),
            border: GradientBoxBorder(
              gradient: borderGradient,
              width: borderWidth,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: borderGradient.colors.first.withOpacity(
                        glowOpacity,
                      ),
                      blurRadius: glowBlurRadius,
                      spreadRadius: glowSpreadRadius,
                      offset: Offset.zero,
                    ),
                    BoxShadow(
                      color: borderGradient.colors.last.withOpacity(
                        glowOpacity,
                      ),
                      blurRadius: glowBlurRadius,
                      spreadRadius: glowSpreadRadius,
                      offset: Offset.zero,
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: isPassword,
            style: const TextStyle(color: AppColors.textLight, fontSize: 16.0),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.textDark),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            cursorColor: borderGradient.colors.first,
          ),
        );
      },
    );
  }

  void _handleLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      print('Attempting Login with Email: $email, Password: $password');
      // Navigate to HomeScreen without theme parameters
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
    }
  }

  void _handleLoginWithGoogle() {
    print('Login with Google button tapped!');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Google Login (mock)!')));
  }

  void _handleRegisterHere() {
    print('Register Here tapped!');
    context.go('/create-account');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Register Screen (mock)!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.darkBackground, // Ensure dark background is set here
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primaryBlue, AppColors.primaryPurple],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: const Text(
            'WELCOME',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50.0),
            const Text(
              'Login to your account',
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30.0),
            _buildInputField(
              controller: _emailController,
              hintText: 'Email',
              focusNode: _emailFocusNode,
              borderGradient: _emailBorderGradient,
            ),
            const SizedBox(height: 20.0),
            _buildInputField(
              controller: _passwordController,
              hintText: 'Password',
              focusNode: _passwordFocusNode,
              borderGradient: _passwordBorderGradient,
              isPassword: true,
            ),
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: _handleLogin,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.primaryPurple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPurple.withOpacity(0.4),
                      blurRadius: 15.0,
                      spreadRadius: 2.0,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.0,
                    color: AppColors.textDark.withOpacity(0.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'OR',
                    style: TextStyle(color: AppColors.textDark, fontSize: 16.0),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1.0,
                    color: AppColors.textDark.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _handleLoginWithGoogle,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: GradientBoxBorder(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEA4335), Color(0xFF4285F4)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEA4335).withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.g_mobiledata,
                      color: AppColors.textLight,
                      size: 30,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Login with Google',
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: _handleRegisterHere,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New User? ',
                    style: TextStyle(color: AppColors.textDark, fontSize: 16.0),
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.primaryBlue, AppColors.primaryPurple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: const Text(
                      'Register Here',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
