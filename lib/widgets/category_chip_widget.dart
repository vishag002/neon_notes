import 'package:firebase_setup/core/color_const.dart';
import 'package:flutter/material.dart';

class CategoryChipWidget extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChipWidget({
    super.key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: AppColors.chipBackground,
          borderRadius: BorderRadius.circular(20.0),
          border: isSelected
              ? Border.all(color: AppColors.selectedChipBackground, width: 2.0)
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.selectedChipBackground.withOpacity(0.5),
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                  ),
                ]
              : null,
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? AppColors.textLight : AppColors.textDark,
            fontSize: 16.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
