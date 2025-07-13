import 'package:firebase_setup/core/color_const.dart';
import 'package:firebase_setup/data/models/note_model.dart';
import 'package:flutter/material.dart';

class NoteCardWidget extends StatelessWidget {
  final Note note;
  final LinearGradient borderGradient; // Property for random gradient

  const NoteCardWidget({
    super.key,
    required this.note,
    required this.borderGradient,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius cardBorderRadius = BorderRadius.circular(15.0);
    const double borderWidth = 2.0; // Thickness of the glowing border

    // *** Tuned Shadow Parameters for Full Border Glow (like image_809139.png) ***
    const double glowBlurRadius =
        100.0; // Increased blur for a softer, wider glow
    const double glowSpreadRadius =
        1.0; // Keep spread at 0 to avoid "block" fill
    const double glowOpacity = 0.1; // Adjust opacity for desired intensity

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.all(
        20.0,
      ), // Padding for the content inside the border
      decoration: BoxDecoration(
        // IMPORTANT: No 'color' property here for transparent interior
        borderRadius: cardBorderRadius,
        border: GradientBoxBorder(
          gradient: borderGradient,
          width: borderWidth,
        ), // Custom gradient border
        boxShadow: [
          // First shadow, using the start color of the gradient
          BoxShadow(
            color: borderGradient.colors.first.withOpacity(glowOpacity),
            blurRadius: glowBlurRadius,
            spreadRadius: glowSpreadRadius,
            offset: Offset.zero, // Centered shadow for full border glow
          ),
          // Second shadow, using the end color of the gradient
          // This creates a nice blend effect for the overall glow
          BoxShadow(
            color: borderGradient.colors.last.withOpacity(glowOpacity),
            blurRadius: glowBlurRadius,
            spreadRadius: glowSpreadRadius,
            offset: Offset.zero, // Centered shadow for full border glow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: const TextStyle(
              color: AppColors.textLight, // Text color for contrast
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            note.description,
            style: const TextStyle(
              color: AppColors.textDark, // Slightly muted for description
              fontSize: 15.0,
            ),
          ),
          if (note.timestamp != null) ...[
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                note.timestamp!,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// --- Helper for Gradient Border ---
// (GradientBoxBorder class remains exactly the same as before)
// Ensure this class is included in the same file or imported correctly.

class GradientBoxBorder extends BoxBorder {
  const GradientBoxBorder({required this.gradient, this.width = 1.0});

  final Gradient gradient;
  final double width;

  @override
  BorderSide get bottom => BorderSide.none;
  @override
  BorderSide get top => BorderSide.none;

  @override
  bool get isUniform => true;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    if (borderRadius == null) {
      final Paint paint = Paint()
        ..shader = gradient.createShader(rect)
        ..strokeWidth = width
        ..style = PaintingStyle.stroke;
      canvas.drawRect(rect, paint);
    } else {
      final RRect outer = borderRadius.toRRect(rect);
      final RRect inner = outer.deflate(width);
      final Paint paint = Paint()..shader = gradient.createShader(rect);

      canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRRect(outer),
          Path()..addRRect(inner),
        ),
        paint,
      );
    }
  }

  @override
  ShapeBorder scale(double t) {
    return GradientBoxBorder(gradient: gradient, width: width * t);
  }
}
