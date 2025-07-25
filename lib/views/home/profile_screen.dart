// screens/profile_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup/core/color_const.dart';
import 'package:firebase_setup/widgets/neon_notes_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Placeholder for user name. In a real app, this would come from user data.
const String _userName = "John Doe";

class ProfileScreen extends StatefulWidget {
  // Callbacks to communicate with main.dart for theme changes
  // final ValueChanged<ThemeMode> onThemeModeChanged;
  // final ThemeMode currentThemeMode;

  const ProfileScreen({
    super.key,
    // required this.onThemeModeChanged,
    // required this.currentThemeMode,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Helper widget to build consistent looking profile options (buttons/tabs)
  Widget _buildProfileOption({
    required String title,
    required VoidCallback onTap,
    IconData? icon,
    LinearGradient? gradient, // Optional custom gradient for specific options
    Color? textColor, // Optional custom text color
  }) {
    // Default gradient if none is provided
    gradient ??= const LinearGradient(
      colors: [AppColors.primaryBlue, AppColors.primaryPurple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: Colors.transparent, // Transparent interior
          borderRadius: BorderRadius.circular(12.0),
          border: GradientBoxBorder(
            gradient: gradient,
            width: 1.5,
          ), // Gradient border
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.1), // Subtle glow
              blurRadius: 10,
              spreadRadius: 0.1,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor ?? AppColors.textLight),
              const SizedBox(width: 15.0),
            ],
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor ?? AppColors.textLight,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textDark,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  // --- Placeholder methods for various actions ---
  void _handleChangePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Change Password tapped! (Implementation needed)'),
      ),
    );
    // In a real app, navigate to a password change screen or show a dialog
  }

  void _handleClearAllNotes() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              AppColors.searchBarBackground, // Dark background for dialog
          title: const Text(
            'Clear All Notes?',
            style: TextStyle(color: AppColors.textLight),
          ),
          content: const Text(
            'Are you sure you want to clear all your notes? This action cannot be undone.',
            style: TextStyle(color: AppColors.textDark),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(color: AppColors.primaryBlue),
              ),
            ),
            TextButton(
              onPressed: () {
                // In a real app, clear notes from your actual data source (e.g., database, provider)
                // AppData.notes.clear(); // Uncomment and implement if AppData.notes is mutable and represents your data
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All notes cleared (mock)!')),
                );
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: const Text(
                'CLEAR',
                style: TextStyle(color: AppColors.primaryPurple),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.searchBarBackground,
          title: const Text(
            'Delete Account?',
            style: TextStyle(color: AppColors.textLight),
          ),
          content: const Text(
            'Are you sure you want to delete your account? This action is permanent.',
            style: TextStyle(color: AppColors.textDark),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(color: AppColors.primaryBlue),
              ),
            ),
            TextButton(
              onPressed: () {
                // Implement actual account deletion logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account deleted (mock)!')),
                );
                Navigator.of(context).pop();
                // After deletion, typically navigate to login/onboarding screen
              },
              child: const Text(
                'DELETE',
                style: TextStyle(color: Colors.red),
              ), // Red for danger
            ),
          ],
        );
      },
    );
  }

  void _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    context.go('/login');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Logged out (mock)!')));
    // Implement actual logout logic (e.g., clear session, navigate to login screen)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textLight,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primaryBlue, AppColors.primaryPurple],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: const Text(
            'PROFILE',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // This color is masked by the shader
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Icon
            Container(
              padding: const EdgeInsets.all(20.0), // Padding inside the circle
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Make it circular
                border: GradientBoxBorder(
                  // Gradient border for the icon
                  gradient:
                      AppColors.generateRandomNeonGradient(), // Random gradient for icon border
                  width: 3.0,
                ),
                boxShadow: [
                  // Subtle glow around the icon
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.5),
                    blurRadius: 25.0,
                    spreadRadius: 0.0,
                    offset: Offset.zero,
                  ),
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.5),
                    blurRadius: 25.0,
                    spreadRadius: 0.0,
                    offset: Offset.zero,
                  ),
                ],
              ),
              child: const Icon(
                Icons.person, // The profile icon
                size: 80.0, // Size of the icon
                color: AppColors.textLight, // Color of the icon
              ),
            ),
            const SizedBox(height: 15.0),
            // User Name
            const Text(
              _userName,
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30.0),

            // --- Profile Options ---
            _buildProfileOption(
              title: 'Change Password',
              icon: Icons.lock,
              onTap: _handleChangePassword,
            ),
            _buildProfileOption(
              title: 'Clear All Notes',
              icon: Icons.clear_all,
              onTap: _handleClearAllNotes,
            ),
            _buildProfileOption(
              title: 'Delete Account',
              icon: Icons.delete_forever,
              onTap: _handleDeleteAccount,
              textColor: Colors.redAccent, // Highlight text in red
              gradient: const LinearGradient(
                // Use a red-themed gradient for danger
                colors: [Colors.red, Color.fromARGB(255, 187, 30, 20)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            _buildProfileOption(
              title: 'Logout',
              icon: Icons.logout,
              onTap: _handleLogout,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
