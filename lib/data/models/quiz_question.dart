enum QuizQuestionType { multipleChoice, trueFalse, dragMatch }

class QuizQuestion {
  final QuizQuestionType type;
  final String question;

  final List<String>? options;
  final int? correctIndex;

  final Map<String, String>? matchPairs;

  final int timeLimit; // saniye
  final int difficulty; // 1 kolay, 2 orta, 3 zor

  QuizQuestion({
    required this.type,
    required this.question,
    this.options,
    this.correctIndex,
    this.matchPairs,
    this.timeLimit = 0,
    this.difficulty = 1,
  });
}
