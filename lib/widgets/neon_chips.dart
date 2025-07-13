import 'package:flutter/material.dart';

class NeonChips extends StatelessWidget {
  final List<Map<String, dynamic>> chipData = [
    {'label': 'All', 'color': Colors.cyanAccent},
    {'label': 'Work', 'color': Colors.purpleAccent},
    {'label': 'Personal', 'color': Colors.pinkAccent},
    {'label': 'Ideas', 'color': Colors.deepPurpleAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: chipData.length,
        itemBuilder: (context, index) {
          final item = chipData[index];
          final color = item['color'] as Color;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: color, width: 1.8),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
              gradient: LinearGradient(
                colors: [Colors.black, Colors.black.withOpacity(0.9)],
              ),
            ),
            child: Center(
              child: Text(
                item['label'],
                style: TextStyle(color: color, fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }
}
