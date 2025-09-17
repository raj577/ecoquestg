class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final String imagePath;
  final String category;
  final int difficulty;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.imagePath,
    required this.category,
    this.difficulty = 1,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
      explanation: json['explanation'],
      imagePath: json['imagePath'],
      category: json['category'],
      difficulty: json['difficulty'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
      'imagePath': imagePath,
      'category': category,
      'difficulty': difficulty,
    };
  }
}

class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final int score;
  final Duration timeTaken;
  final List<bool> answerResults;

  const QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.timeTaken,
    required this.answerResults,
  });

  double get percentage => (correctAnswers / totalQuestions) * 100;
  
  String get grade {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    return 'Try Again!';
  }
}

