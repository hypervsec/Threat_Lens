import 'dart:async';
import '../../../data/models/quiz_question.dart';
import 'package:flutter/material.dart';

class QuizEngine extends ChangeNotifier {
  final List<QuizQuestion> questions;

  int current = 0;
  int correct = 0;

  int remainingTime = 0;
  Timer? timer;

  QuizEngine(this.questions) {
    _startQuestion();
  }

  QuizQuestion get q => questions[current];

  void _startQuestion() {
    remainingTime = q.timeLimit;

    timer?.cancel();

    if (remainingTime > 0) {
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        remainingTime--;

        if (remainingTime <= 0) {
          t.cancel();
          next();
        }

        notifyListeners();
      });
    }
  }

  void answer(int index) {
    if (q.correctIndex == index) {
      correct++;
    }
    next();
  }

  void matchSolved() {
    correct++;
    next();
  }

  void next() {
    timer?.cancel();

    if (current + 1 < questions.length) {
      current++;
      _startQuestion();
      notifyListeners();
    } else {
      notifyListeners(); // finished
    }
  }

  bool get isFinished => current + 1 == questions.length;
}
