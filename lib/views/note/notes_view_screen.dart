import 'package:firebase_setup/core/color_const.dart';
import 'package:firebase_setup/data/models/note_model.dart';
import 'package:firebase_setup/widgets/neon_notes_widget.dart';
import 'package:flutter/material.dart';

class NoteViewScreen extends StatelessWidget {
  final Note note; // The note to be displayed

  const NoteViewScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    // These values for blur, spread, and opacity are consistent with the home screen note cards
    const double glowBlurRadius = 25.0;
    const double glowSpreadRadius = 0.0;
    const double glowOpacity = 0.1;
    final BorderRadius contentBorderRadius = BorderRadius.circular(15.0);

    // Re-generate a gradient for this view, or you could pass the original card's gradient
    // For consistency with the random border on cards, let's generate a new one.
    // If you want it to match the *specific* gradient of the card that was tapped,
    // you would need to pass that gradient from HomeScreen to NoteViewScreen.
    final LinearGradient viewScreenGradient =
        AppColors.generateRandomNeonGradient();

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
            'VIEW NOTE',
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
        child: Container(
          padding: const EdgeInsets.all(20.0), // Padding for the content
          decoration: BoxDecoration(
            color: Colors.transparent, // Transparent interior
            borderRadius: contentBorderRadius,
            border: GradientBoxBorder(
              // Reusing the GradientBoxBorder
              gradient: viewScreenGradient,
              width: 2.0, // Consistent border width
            ),
            boxShadow: [
              // Subtle diffused glow around the entire content area
              BoxShadow(
                color: viewScreenGradient.colors.first.withOpacity(glowOpacity),
                blurRadius: glowBlurRadius,
                spreadRadius: glowSpreadRadius,
                offset: Offset.zero,
              ),
              BoxShadow(
                color: viewScreenGradient.colors.last.withOpacity(glowOpacity),
                blurRadius: glowBlurRadius,
                spreadRadius: glowSpreadRadius,
                offset: Offset.zero,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 28.0, // Larger font for title
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              Expanded(
                // Allow description to take available space
                child: SingleChildScrollView(
                  // Allow scrolling for long descriptions
                  child: Text(
                    note.description,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 17.0,
                      height: 1.5, // Line height for readability
                    ),
                  ),
                ),
              ),
              if (note.timestamp != null) ...[
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    note.timestamp!,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
