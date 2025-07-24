// screens/register_screen.dart
import 'package:firebase_setup/core/color_const.dart';
import 'package:firebase_setup/data/models/signup_view_model.dart';
import 'package:firebase_setup/widgets/neon_notes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});
  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // New field
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode(); // New focus node

  // Gradients for input field borders
  late LinearGradient _emailBorderGradient;
  late LinearGradient _passwordBorderGradient;
  late LinearGradient _confirmPasswordBorderGradient; // New gradient

  @override
  void initState() {
    super.initState();
    _emailBorderGradient = AppColors.generateRandomNeonGradient();
    _passwordBorderGradient = AppColors.generateRandomNeonGradient();
    _confirmPasswordBorderGradient =
        AppColors.generateRandomNeonGradient(); // Initialize new gradient
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose(); // Dispose new controller
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose(); // Dispose new focus node
    super.dispose();
  }

  // Helper method for transparent input fields with gradient border and glow
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required FocusNode focusNode,
    required LinearGradient borderGradient,
    required void Function(String) onChanged,
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
            color: Colors.transparent, // Transparent interior
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
            onChanged: onChanged,
            controller: controller,
            focusNode: focusNode,
            obscureText: isPassword, // Hide text for password fields
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpProvider);
    final notifier = ref.read(signUpProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
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
            'REGISTER',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Masked by shader
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
            // Registration Title
            const Text(
              'Create your new account',
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30.0),

            // Email Input
            _buildInputField(
              onChanged: (value) => notifier.setEmail(value),
              controller: _emailController,
              hintText: 'Email',
              focusNode: _emailFocusNode,
              borderGradient: _emailBorderGradient,
            ),
            const SizedBox(height: 20.0),

            // Password Input
            _buildInputField(
              onChanged: (value) => notifier.setPassword(value),
              controller: _passwordController,
              hintText: 'Password',
              focusNode: _passwordFocusNode,
              borderGradient: _passwordBorderGradient,
              isPassword: true,
            ),
            const SizedBox(height: 20.0),

            // Confirm Password Input
            _buildInputField(
              onChanged: (value) => notifier.setConfirmPassword(value),
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
              focusNode: _confirmPasswordFocusNode,
              borderGradient: _confirmPasswordBorderGradient,
              isPassword: true,
            ),
            const SizedBox(height: 30.0),

            // Register Button
            GestureDetector(
              onTap: () async {
                final success = await notifier.signUp();
                if (!context.mounted) return;
                if (success) {
                  context.go('/home');
                  notifier.resetState();
                } else {
                  final error = ref.read(signUpProvider).errorMessage;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error ?? "Unknown error")),
                  );
                }
              },
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryBlue,
                            AppColors.primaryPurple,
                          ],
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
                          'REGISTER',
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

            // OR Divider
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

            // Sign Up with Google Button
            GestureDetector(
              onTap: () {
                //
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: GradientBoxBorder(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFEA4335),
                        Color(0xFF4285F4),
                      ], // Google colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEA4335).withOpacity(0.3),
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
                    ), // Placeholder Google icon
                    SizedBox(width: 10.0),
                    Text(
                      'Sign Up with Google',
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

            // Already existing user? Login Here text
            GestureDetector(
              onTap: () {
                //
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already existing user? ',
                    style: TextStyle(color: AppColors.textDark, fontSize: 16.0),
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.primaryBlue, AppColors.primaryPurple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: const Text(
                      'Login Here',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Masked by shader
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
