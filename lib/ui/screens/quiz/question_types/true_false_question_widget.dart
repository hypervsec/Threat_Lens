import 'package:flutter/material.dart';

class TrueFalseWidget extends StatelessWidget {
  final String question;
  final Function(bool) onAnswer;

  const TrueFalseWidget({
    super.key,
    required this.question,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => onAnswer(true),
          child: const Text("Doğru"),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => onAnswer(false),
          child: const Text("Yanlış"),
        ),
      ],
    );
  }
}
