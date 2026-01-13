class QuizProgressService {
  int dailySolved = 0;
  DateTime lastReset = DateTime.now();

  void solvedQuiz() {
    if (!_isSameDay(lastReset, DateTime.now())) {
      dailySolved = 0;
      lastReset = DateTime.now();
    }

    dailySolved++;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
