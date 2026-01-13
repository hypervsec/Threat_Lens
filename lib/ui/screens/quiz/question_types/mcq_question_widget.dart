import 'package:flutter/material.dart';
import '../../../../data/models/quiz_question.dart';

class McqQuestionWidget extends StatelessWidget {
  final QuizQuestion q;
  final Function(int) onAnswer;

  const McqQuestionWidget({super.key, required this.q, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(q.options!.length, (i) {
        return GestureDetector(
          onTap: () => onAnswer(i),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF10182A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Text(
              q.options![i],
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }),
    );
  }
}
