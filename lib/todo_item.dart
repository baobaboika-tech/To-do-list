class Task {
  String text;
  bool isDone;

  // Constructor
  Task({required this.text, this.isDone = false});

  // Convert Task object to Map (for database storage)
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'is_done': isDone ? 1 : 0, // SQLite stores bool as 0/1
    };
  }

  // Create Task object from Map (when reading from database)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      text: map['text'],
      isDone: map['is_done'] == 1,
    );
  }
}
