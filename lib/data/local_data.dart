import 'package:firebase_setup/data/models/note_model.dart';

class AppData {
  static final List<String> categories = ['All', 'Work', 'Personal', 'Ideas'];

  static final List<Note> notes = [
    Note(
      title: 'Meeting notes',
      description: 'Discuss project milestones and deadlines',
      timestamp: 'July 12, 2025',
    ),
    Note(
      title: 'Grocery List',
      description: 'Milk, eggs, bread, and vegetables',
      timestamp: 'July 11, 2025',
    ),
    Note(
      title: 'Project Plan',
      description: 'Outline app features and timeline',
      timestamp: 'July 10, 2025',
    ),
    Note(
      title: 'Book Recommendations',
      description: 'Check out the latest sci-fi novels',
      timestamp: 'July 9, 2025',
    ),
    Note(
      title: 'Grocery List',
      description: 'Milk, eggs, bread, and vegetables',
      timestamp: 'July 11, 2025',
    ),
    Note(
      title: 'Grocery List',
      description: 'Milk, eggs, bread, and vegetables',
      timestamp: 'July 11, 2025',
    ),
  ];
}
