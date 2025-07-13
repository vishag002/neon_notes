import 'package:firebase_setup/core/color_const.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: AppColors.searchBarBackground,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: AppColors.searchBarBorder, width: 2.0),
      ),
      child: const TextField(
        style: TextStyle(color: AppColors.textLight, fontSize: 16.0),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColors.textDark),
          prefixIcon: Icon(Icons.search, color: AppColors.textDark),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
        ),
      ),
    );
  }
}
