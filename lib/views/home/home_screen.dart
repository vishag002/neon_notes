///gemini
import 'package:firebase_setup/core/color_const.dart';
import 'package:firebase_setup/data/local_data.dart';
import 'package:firebase_setup/views/home/profile_screen.dart';
import 'package:firebase_setup/views/note/notes_add_screen.dart';
import 'package:firebase_setup/views/note/notes_view_screen.dart';
import 'package:firebase_setup/widgets/category_chip_widget.dart';
import 'package:firebase_setup/widgets/neon_notes_widget.dart';
import 'package:firebase_setup/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  // Store generated gradients to ensure they don't change on rebuilds
  // for existing cards, unless you specifically want them to change.
  // For truly random on each render, you can remove this map.
  final Map<int, LinearGradient> _cardGradients = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primaryBlue, AppColors.primaryPurple],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: const Text(
            'MY NOTES',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // This color is masked by the shader
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_rounded,
              color: AppColors.textLight,
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 10), // Add some spacing after the icon
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: AppData.categories.map((category) {
                return CategoryChipWidget(
                  category: category,
                  isSelected: _selectedCategory == category,
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          //  const SizedBox(height: 5.0),
          const SearchBarWidget(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero, // Remove default listview padding
              itemCount: AppData.notes.length,
              itemBuilder: (context, index) {
                final note = AppData.notes[index]; // Get the note object

                // Generate or retrieve the gradient for this card
                final gradient = _cardGradients.putIfAbsent(
                  index,
                  () => AppColors.generateRandomNeonGradient(),
                );
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteViewScreen(note: note),
                      ),
                    );
                  },
                  child: NoteCardWidget(
                    note: AppData.notes[index],
                    borderGradient: gradient,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotesAddScreen()),
          );
        },
        backgroundColor: Colors.transparent, // Make FAB background transparent
        shape: const CircleBorder(), // Ensure it's circular
        child: Ink(
          // Use Ink for the gradient effect
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryBlue, AppColors.primaryPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 56, // Default FAB size
            height: 56, // Default FAB size
            alignment: Alignment.center,
            child: const Icon(
              Icons.add,
              color: AppColors.textLight,
              size: 30.0,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Position it at bottom right
    );
  }
}
