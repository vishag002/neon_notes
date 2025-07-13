// import 'package:flutter/material.dart';

// class HomeScreen2 extends StatelessWidget {
//   const HomeScreen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text(
//           'MY NOTES',
//           style: TextStyle(
//             color: Colors.cyan,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             shadows: [
//               Shadow(
//                 blurRadius: 10.0,
//                 color: Colors.cyan,
//                 offset: Offset(0, 0),
//               ),
//             ],
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SearchBarWidget(),
//             const SizedBox(height: 16),
//             const CategoryChipWidget(),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: const [
//                   NoteCardWidget(
//                     title: 'Meeting notes',
//                     description: 'Discuss project milestones and deadlines',
//                     color: Colors.cyan,
//                   ),
//                   NoteCardWidget(
//                     title: 'Grocery List',
//                     description: 'Milk, eggs, bread, and vegetables',
//                     color: Colors.pinkAccent,
//                   ),
//                   NoteCardWidget(
//                     title: 'Project Plan',
//                     description: 'Outline app features and timeline',
//                     color: Colors.purpleAccent,
//                   ),
//                   NoteCardWidget(
//                     title: 'Book Recommendations',
//                     description: 'Check out the latest sci-fi novels',
//                     color: Colors.greenAccent,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ////
// ///
// ///import 'package:flutter/material.dart';

// class SearchBarWidget extends StatelessWidget {
//   const SearchBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.cyan.withOpacity(0.3),
//             blurRadius: 8,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: TextField(
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           hintText: 'Search',
//           hintStyle: TextStyle(color: Colors.grey[400]),
//           prefixIcon: Icon(Icons.search, color: Colors.cyan[200]),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: Colors.grey[900],
//           contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
//         ),
//       ),
//     );
//   }
// }

// ///
// ///
// ///import 'package:flutter/material.dart';

// class CategoryChipWidget extends StatelessWidget {
//   const CategoryChipWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           _buildChip('All', isSelected: true, color: Colors.cyan),
//           _buildChip('Work', color: Colors.pinkAccent),
//           _buildChip('Personal', color: Colors.purpleAccent),
//           _buildChip('Ideas', color: Colors.greenAccent),
//         ],
//       ),
//     );
//   }

//   Widget _buildChip(
//     String label, {
//     bool isSelected = false,
//     required Color color,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.0),
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: color.withOpacity(0.7),
//                     blurRadius: 8,
//                     spreadRadius: 1,
//                   ),
//                 ]
//               : null,
//         ),
//         child: ChoiceChip(
//           label: Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? Colors.black : color,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           selected: isSelected,
//           onSelected: (bool selected) {},
//           selectedColor: color,
//           backgroundColor: Colors.grey[900],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.0),
//             side: BorderSide(color: color.withOpacity(0.5), width: 1),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ////
// ///
// ///import 'package:flutter/material.dart';

// class NoteCardWidget extends StatelessWidget {
//   final String title;
//   final String description;
//   final Color color;

//   const NoteCardWidget({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.3),
//             blurRadius: 10,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Card(
//         color: Colors.grey[900],
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           side: BorderSide(color: color.withOpacity(0.3), width: 1),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                   shadows: [
//                     Shadow(
//                       blurRadius: 5.0,
//                       color: color.withOpacity(0.5),
//                       offset: const Offset(0, 0),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 description,
//                 style: TextStyle(fontSize: 14, color: Colors.grey[400]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
