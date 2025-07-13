//claude
// main.dart
import 'package:flutter/material.dart';

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({Key? key}) : super(key: key);

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'Work', 'Personal', 'Ideas'];

  final List<Map<String, dynamic>> notes = [
    {
      'title': 'Meeting notes',
      'description': 'Discuss project milestones and deadlines',
      'category': 'Work',
      'color': const Color(0xFF00FFFF),
    },
    {
      'title': 'Grocery List',
      'description': 'Milk, eggs, bread, and vegetables',
      'category': 'Personal',
      'color': const Color(0xFFFF00FF),
    },
    {
      'title': 'Project Plan',
      'description': 'Outline app features and timeline',
      'category': 'Work',
      'color': const Color(0xFF4A4AFF),
    },
    {
      'title': 'Book Recommendations',
      'description': 'Check out the latest sci-fi novels',
      'category': 'Ideas',
      'color': const Color(0xFF00FFAA),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [Color(0xFF1A0A2E), Color(0xFF0A0A1A)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFF00FFFF),
                      width: 2,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF00FFFF).withOpacity(0.1),
                        const Color(0xFF4A4AFF).withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: const Text(
                    'MY NOTES',
                    style: TextStyle(
                      color: Color(0xFF00FFFF),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Category chips
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: CategoryChipWidget(
                          label: categories[index],
                          isSelected: selectedCategory == categories[index],
                          onTap: () {
                            setState(() {
                              selectedCategory = categories[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // Search bar
                const SearchBarWidget(),

                const SizedBox(height: 30),

                // Notes list
                Expanded(
                  child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: NoteCardWidget(
                          title: notes[index]['title'],
                          description: notes[index]['description'],
                          accentColor: notes[index]['color'],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// search_bar_widget.dart

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFF00FFFF), width: 2),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF00FFFF).withOpacity(0.05),
            const Color(0xFF4A4AFF).withOpacity(0.05),
          ],
        ),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xFF00FFFF),
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

// category_chip_widget.dart

class CategoryChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChipWidget({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? const Color(0xFF00FFFF) : Colors.transparent,
            width: 2,
          ),
          gradient: LinearGradient(
            colors: isSelected
                ? [
                    const Color(0xFF00FFFF).withOpacity(0.2),
                    const Color(0xFF4A4AFF).withOpacity(0.2),
                  ]
                : [
                    const Color(0xFF2A2A4A).withOpacity(0.3),
                    const Color(0xFF1A1A3A).withOpacity(0.3),
                  ],
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF00FFFF) : Colors.white70,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// note_card_widget.dart

class NoteCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final Color accentColor;

  const NoteCardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor, width: 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withOpacity(0.1),
            accentColor.withOpacity(0.05),
            const Color(0xFF0A0A1A).withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: accentColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
