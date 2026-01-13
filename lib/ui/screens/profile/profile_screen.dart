import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF050814);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Profil", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _userCard(),
            const SizedBox(height: 22),

            _statsRow(),
            const SizedBox(height: 22),

            _badgesSection(),
            const SizedBox(height: 22),

            _completedLessons(),
            const SizedBox(height: 22),

            _settingsButton(),
          ],
        ),
      ),
    );
  }

  // 🟣 USER CARD --------------------------------------------------
  Widget _userCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
        color: const Color(0xFF0A0F22).withOpacity(0.85),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.22),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.cyanAccent, width: 2),
            ),
            child: const Icon(Icons.person, size: 40, color: Colors.cyanAccent),
          ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Kingo 👑",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Seviye 3 • 1,540 XP",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              SizedBox(height: 3),
              Text(
                "Streak: 7 gün",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 📊 STATS -------------------------------------------------------
  Widget _statsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statBox(Icons.school_rounded, "Dersler", "12"),
        _statBox(Icons.quiz_rounded, "Quizler", "31"),
        _statBox(Icons.shield_rounded, "APT", "8"),
      ],
    );
  }

  Widget _statBox(IconData icon, String label, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D132A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.cyanAccent, size: 30),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 🏅 BADGES -----------------------------------------------------
  Widget _badgesSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF0D0F22),
        border: Border.all(color: Colors.purpleAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rozetler",
            style: TextStyle(
              color: Colors.purpleAccent,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              _badge("XP Ustası", Icons.bolt),
              _badge("APT Analyst", Icons.safety_check),
              _badge("Quiz Champion", Icons.emoji_events),
              _badge("Streak 7 Gün", Icons.local_fire_department),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _badge(String name, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white10,
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.amberAccent, size: 20),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // 📚 COMPLETED LESSONS ------------------------------------------
  Widget _completedLessons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1024),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tamamlanan Dersler",
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 14),

          _lessonItem("Temel Siber Güvenlik", 100),
          _lessonItem("Phishing Analizi", 100),
          _lessonItem("SOC Log Analizi", 80),
        ],
      ),
    );
  }

  static Widget _lessonItem(String title, int progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20),
          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),

          Text(
            "$progress%",
            style: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ⚙ SETTINGS ----------------------------------------------------
  Widget _settingsButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white10,
          border: Border.all(color: Colors.white24),
        ),
        child: const Center(
          child: Text(
            "Ayarlar",
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
