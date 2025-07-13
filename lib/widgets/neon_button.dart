import 'package:flutter/material.dart';

class NeonButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const NeonButton({
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        side: BorderSide(color: color, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        shadowColor: color,
        elevation: 10,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: color.withOpacity(0.6), blurRadius: 15)],
        ),
      ),
    );
  }
}
