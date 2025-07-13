import 'package:firebase_setup/core/color_const.dart';
import 'package:flutter/material.dart';

class NeonTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const NeonTextField({
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black,
        prefixIcon: Icon(icon, color: AppColors.primaryBlue),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryBlue, width: 2.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
