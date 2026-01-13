import 'package:flutter/material.dart';
import '../../../../data/models/quiz_question.dart';

class DragMatchWidget extends StatefulWidget {
  final QuizQuestion q;
  final Function() onSuccess;

  const DragMatchWidget({super.key, required this.q, required this.onSuccess});

  @override
  State<DragMatchWidget> createState() => _DragMatchWidgetState();
}

class _DragMatchWidgetState extends State<DragMatchWidget> {
  Map<String, String?> answers = {};

  @override
  void initState() {
    super.initState();
    widget.q.matchPairs!.forEach((k, v) => answers[k] = null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.q.matchPairs!.keys.map((left) {
          return DragTarget<String>(
            onAccept: (right) {
              setState(() => answers[left] = right);
              if (_isAllCorrect()) widget.onSuccess();
            },
            builder: (context, _, __) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyanAccent),
                ),
                child: Text(
                  "$left → ${answers[left] ?? '...'}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }),
        Wrap(
          spacing: 12,
          children: widget.q.matchPairs!.values.map((right) {
            return Draggable<String>(
              data: right,
              feedback: Material(
                color: Colors.transparent,
                child: Text(
                  right,
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 18,
                  ),
                ),
              ),
              child: Chip(
                label: Text(right),
                backgroundColor: Colors.greenAccent.withOpacity(0.2),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  bool _isAllCorrect() {
    for (var e in widget.q.matchPairs!.entries) {
      if (answers[e.key] != e.value) return false;
    }
    return true;
  }
}
