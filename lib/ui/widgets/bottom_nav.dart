import 'package:flutter/material.dart';
import '../screens/home/threatlens_home_screen.dart';
import '../screens/leaderboard/leaderboard_screen.dart';
import '../screens/quiz/quiz_screen.dart';
import '../screens/apt/apt_screen.dart';
import '../screens/lesson/lesson_path_screen.dart'; // Eğitim ekranı import

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int index = 0;

  final screens = const [
    ThreatLensHomeScreen(),
    QuizScreen(),
    APTScreen(),
    LeaderboardScreen(),
    LessonPathScreen(), // Yeni sekme
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF151A2C),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFA06AFF),
        unselectedItemColor: Colors.white54,
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Ana Sayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_rounded),
            label: "Quiz",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield_moon_rounded),
            label: "APT",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_rounded),
            label: "Liderlik",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: "Eğitim",
          ),
        ],
      ),
    );
  }
}
