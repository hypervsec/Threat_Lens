import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  final int correct;
  final int total;
  final int difficultyBonus;

  const QuizResultScreen({
    super.key,
    required this.correct,
    required this.total,
    required this.difficultyBonus,
  });

  @override
  Widget build(BuildContext context) {
    final baseXP = correct * 10;
    final finalXP = baseXP + difficultyBonus;

    return Scaffold(
      backgroundColor: const Color(0xFF070B1A),
      appBar: AppBar(
        title: const Text("Quiz Sonucu"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$correct / $total Doğru",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "+$finalXP XP",
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  children: [
                    _resultRow("Doğru Cevaplar", "$correct"),
                    _resultRow("Temel XP", "$baseXP XP"),
                    _resultRow("Zorluk Bonusu", "+$difficultyBonus XP"),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Geri Dön"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
