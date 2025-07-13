import 'package:firebase_setup/core/color_const.dart';
import 'package:firebase_setup/widgets/neon_notes_widget.dart';
import 'package:flutter/material.dart';
// Import the GradientBoxBorder

class NotesAddScreen extends StatefulWidget {
  const NotesAddScreen({super.key});

  @override
  State<NotesAddScreen> createState() => _NotesAddScreenState();
}

class _NotesAddScreenState extends State<NotesAddScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode(); // For tracking focus
  final FocusNode _categoryFocusNode = FocusNode(); // For tracking focus
  final FocusNode _descriptionFocusNode = FocusNode(); // For tracking focus

  // Generate random gradients for text field borders
  late LinearGradient _titleBorderGradient;
  late LinearGradient _categoryBorderGradient;
  late LinearGradient _descriptionBorderGradient;

  @override
  void initState() {
    super.initState();
    _titleBorderGradient = AppColors.generateRandomNeonGradient();
    _categoryBorderGradient = AppColors.generateRandomNeonGradient();
    _descriptionBorderGradient = AppColors.generateRandomNeonGradient();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
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
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primaryBlue, AppColors.primaryPurple],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: const Text(
            'ADD NEW NOTE',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // This color is masked by the shader
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Title Input Field
            _buildInputField(
              controller: _titleController,
              hintText: 'Note Title',
              maxLines: 1,
              focusNode: _titleFocusNode,
              borderGradient: _titleBorderGradient,
            ),
            const SizedBox(height: 20.0),
            _buildInputField(
              controller: _categoryController,
              hintText: 'Add Category',
              maxLines: 1,
              focusNode: _categoryFocusNode,
              borderGradient: _categoryBorderGradient,
            ),
            const SizedBox(height: 20.0),
            // Description Input Field
            _buildInputField(
              controller: _descriptionController,
              hintText: 'Note Description',
              maxLines: 8, // Allow multiple lines for description
              focusNode: _descriptionFocusNode,
              borderGradient: _descriptionBorderGradient,
            ),
            const SizedBox(height: 30.0),
            // Add Note Button
            GestureDetector(
              onTap: () {
                final title = _titleController.text;
                final description = _descriptionController.text;
                if (title.isNotEmpty || description.isNotEmpty) {
                  // In a real app, you would save the note here
                  print(
                    'New Note Added: Title: $title, Description: $description',
                  );
                  // Optionally, add a real note to AppData.notes for display
                  // AppData.notes.add(Note(
                  //   title: title,
                  //   description: description,
                  //   timestamp: DateTime.now().toLocal().toString().split(' ')[0], // Simple timestamp
                  // ));
                }
                Navigator.pop(context); // Go back after adding (mock logic)
              },
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
                    'ADD NOTE',
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modified _buildInputField
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required FocusNode focusNode, // Added focus node
    required LinearGradient borderGradient, // Added gradient
    int maxLines = 1,
  }) {
    const double borderWidth = 2.0;
    const double glowBlurRadius = 100.0; // Adjust for desired glow intensity
    const double glowSpreadRadius = 1.0; // Keep at 0 for diffused glow
    const double glowOpacity = 0.1; // Adjust opacity for desired intensity

    return AnimatedBuilder(
      animation: focusNode, // Rebuilds when focus changes
      builder: (context, child) {
        final bool isFocused = focusNode.hasFocus;
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent, // Transparent interior
            borderRadius: BorderRadius.circular(15.0),
            border: GradientBoxBorder(
              // Use GradientBoxBorder
              gradient: borderGradient,
              width: borderWidth,
            ),
            boxShadow:
                isFocused // Only apply glow when focused
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
                : [], // No shadow when not focused
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode, // Assign focus node
            maxLines: maxLines,
            style: const TextStyle(color: AppColors.textLight, fontSize: 16.0),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.textDark),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              border: InputBorder.none, // No default border
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder
                  .none, // Managed by the parent Container's BoxDecoration
            ),
            cursorColor:
                borderGradient.colors.first, // Cursor color from gradient
          ),
        );
      },
    );
  }
}
