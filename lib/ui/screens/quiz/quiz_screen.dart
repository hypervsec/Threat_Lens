import 'package:flutter/material.dart';
import 'quiz_question_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      QuizCategory("Temel Siber Güvenlik", Icons.shield, Colors.cyanAccent, 15),
      QuizCategory("Phishing", Icons.phishing, Colors.blueAccent, 10),
      QuizCategory("Malware", Icons.bug_report, Colors.greenAccent, 20),
      QuizCategory("APT", Icons.track_changes, Colors.orangeAccent, 25),
      QuizCategory("SOC Analizi", Icons.monitor_heart, Colors.purpleAccent, 15),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF070B1A),
      appBar: AppBar(
        title: const Text("Quiz"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return _NeonQuizCard(category: cat);
        },
      ),
    );
  }
}

/// ===============================================================
///  NEON QUIZ CARD WIDGET (Animasyonlu)
/// ===============================================================
class _NeonQuizCard extends StatefulWidget {
  final QuizCategory category;

  const _NeonQuizCard({required this.category});

  @override
  State<_NeonQuizCard> createState() => _NeonQuizCardState();
}

class _NeonQuizCardState extends State<_NeonQuizCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _scale = Tween(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _goToQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizQuestionScreen(category: widget.category.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.category;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapCancel: () => _controller.reverse(),
      onTapUp: (_) {
        _controller.reverse();
        Future.delayed(const Duration(milliseconds: 120), _goToQuiz);
      },
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, _) {
          return Transform.scale(
            scale: _scale.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F162B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: c.color.withOpacity(0.7), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: c.color.withOpacity(0.35),
                    blurRadius: 25,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: c.color, width: 2),
                    ),
                    child: Icon(c.icon, color: c.color, size: 30),
                  ),
                  const SizedBox(width: 20),

                  // Title
                  Expanded(
                    child: Text(
                      c.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // XP reward
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: c.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: c.color, width: 1),
                    ),
                    child: Text(
                      "+${c.rewardXP} XP",
                      style: TextStyle(
                        color: c.color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ===============================================================
///  QUIZ CATEGORY MODEL
/// ===============================================================
class QuizCategory {
  final String title;
  final IconData icon;
  final Color color;
  final int rewardXP;

  QuizCategory(this.title, this.icon, this.color, this.rewardXP);
}
