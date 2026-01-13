import 'package:flutter/material.dart';
import 'quiz_result_screen.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String category;

  const QuizQuestionScreen({super.key, required this.category});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int score = 0;
  int timeLeft = 15;

  late AnimationController _controller;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Güçlü şifre kullanmanın adı nedir?",
      "options": ["HardPass", "Strong Password", "SecureWord"],
      "answer": 1,
    },
    {
      "question": "Phishing saldırıları genelde hangi yöntemle yapılır?",
      "options": ["E-posta", "Bluetooth", "Donanımsal Saldırı"],
      "answer": 0,
    },
  ];

  @override
  void initState() {
    super.initState();

    // 15 saniyelik geri sayım animasyonu
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..forward();

    startTimer();
  }

  void startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return false;

      setState(() => timeLeft--);

      if (timeLeft <= 0) {
        nextQuestion();
        return false;
      }

      return true;
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        timeLeft = 15;
        _controller.reset();
        _controller.forward();
        startTimer();
      });
    } else {
      // QUIZ BİTİNCE SENİN RESULT EKRANINA GÖNDERİYORUM
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            correct: score,
            total: questions.length,
            difficultyBonus: 0, // Şimdilik 0, istersen bonus sistemi eklerim
          ),
        ),
      );
    }
  }

  void selectAnswer(int index) {
    final correctIndex = questions[currentIndex]["answer"];

    if (index == correctIndex) {
      setState(() => score++);
    }

    Future.delayed(const Duration(milliseconds: 300), nextQuestion);
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];
    final neon = Colors.cyanAccent;

    return Scaffold(
      backgroundColor: const Color(0xFF060B18),
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ════════════ ZAMAN ÇUBUĞU (NEON) ════════════
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: _controller.value,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.redAccent, Colors.orangeAccent],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.7),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            Text(
              "$timeLeft saniye",
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 30),

            // ════════════ SORU KARTI ════════════
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.purple.withOpacity(0.2),
                  ],
                ),
                border: Border.all(color: neon.withOpacity(0.6), width: 1.4),
                boxShadow: [
                  BoxShadow(color: neon.withOpacity(0.4), blurRadius: 20),
                ],
              ),
              child: Text(
                q["question"],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ════════════ SEÇENEKLER ════════════
            ...List.generate(
              q["options"].length,
              (i) => GestureDetector(
                onTap: () => selectAnswer(i),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1326),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      q["options"][i],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
