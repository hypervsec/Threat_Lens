import 'package:flutter/material.dart';

import '../lesson/lesson_path_screen.dart';
import '../quiz/quiz_screen.dart';
import '../leaderboard/leaderboard_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';

/// ThreatLens'e özel, benzersiz ana sayfa (Mission Control)
class ThreatLensHomeScreen extends StatelessWidget {
  const ThreatLensHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color bgTop = const Color(0xFF050814);
    final Color bgBottom = const Color(0xFF080F24);

    return Scaffold(
      backgroundColor: bgTop,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bgTop, bgBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HomeAppBar(),
                const SizedBox(height: 16),
                const _SummaryCard(),
                const SizedBox(height: 18),
                const _QuickActionsRow(),
                const SizedBox(height: 18),
                const _DailyMissionsSection(),
                const SizedBox(height: 10),
                const Expanded(child: _RecentActivitySection()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
///  ÜST BAR – Logo + Kullanıcı + Ayarlar
/// ─────────────────────────────────────────────
class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ───────────── LOGO ─────────────
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.cyanAccent.withOpacity(0.7)),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.3),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
            gradient: const LinearGradient(
              colors: [Color(0xFF0AF3FF), Color(0xFF1B9CFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(
            Icons.admin_panel_settings,
            color: Colors.black,
            size: 22,
          ),
        ),

        const SizedBox(width: 12),

        // ───────────── TITLE ─────────────
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "ThreatLens",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Mission Control",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),

        const Spacer(),

        // ───────────── SETTINGS BUTTON (YENİ) ─────────────
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
          },
        ),

        // ───────────── PROFİL BUTTON ─────────────
        IconButton(
          icon: const Icon(Icons.person, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
        ),
      ],
    );
  }
}

/// ─────────────────────────────────────────────
///  ÖZET KARTI – XP, Lig, Streak
/// ─────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    final Color cardColor = const Color(0xFF10162A);
    final Color accent = Colors.cyanAccent;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.18),
            blurRadius: 22,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Bugünkü ilerlemen",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.orangeAccent.withOpacity(0.15),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      color: Colors.orangeAccent.shade200,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "7 gün streak",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _SummaryStat(
                label: "Toplam XP",
                value: "1.250",
                icon: Icons.star_rounded,
                color: Colors.amberAccent,
              ),
              const SizedBox(width: 10),
              _SummaryStat(
                label: "Lig",
                value: "SILVER",
                icon: Icons.shield_rounded,
                color: accent,
              ),
              const SizedBox(width: 10),
              _SummaryStat(
                label: "Bugün",
                value: "+30 XP",
                icon: Icons.bolt_rounded,
                color: Colors.purpleAccent,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Günlük hedef: 40 XP",
              style: TextStyle(
                color: Colors.white70.withOpacity(0.9),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: 30 / 40,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(accent),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(color: Colors.white60, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
///  HIZLI AKSIYONLAR – 3 BUYUK BUTON
/// ─────────────────────────────────────────────
class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _QuickActionCard(
            title: "Eğitim Yolu",
            subtitle: "Temel → İleri",
            icon: Icons.route_rounded,
            color: Colors.cyanAccent,
            target: _QuickTarget.lesson,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _QuickActionCard(
            title: "Hızlı Quiz",
            subtitle: "XP kazan",
            icon: Icons.quiz_rounded,
            color: Colors.purpleAccent,
            target: _QuickTarget.quiz,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _QuickActionCard(
            title: "Ligler",
            subtitle: "Sıralamaya gir",
            icon: Icons.leaderboard_rounded,
            color: Colors.amberAccent,
            target: _QuickTarget.league,
          ),
        ),
      ],
    );
  }
}

enum _QuickTarget { lesson, quiz, league }

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final _QuickTarget target;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.target,
  });

  void _navigate(BuildContext context) {
    Widget page;
    switch (target) {
      case _QuickTarget.lesson:
        page = const LessonPathScreen();
        break;
      case _QuickTarget.quiz:
        page = const QuizScreen();
        break;
      case _QuickTarget.league:
        page = const LeaderboardScreen();
        break;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _navigate(context),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF10172A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.7), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
///  GÜNLÜK GÖREVLER
/// ─────────────────────────────────────────────
class _DailyMissionsSection extends StatelessWidget {
  const _DailyMissionsSection();

  @override
  Widget build(BuildContext context) {
    final missions = [
      _Mission("20 XP kazan", true),
      _Mission("1 yeni dersi tamamla", false),
      _Mission("2 quiz çöz", false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bugünkü görevler",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        Column(children: missions.map((m) => _MissionRow(mission: m)).toList()),
      ],
    );
  }
}

class _Mission {
  final String title;
  final bool done;
  const _Mission(this.title, this.done);
}

class _MissionRow extends StatelessWidget {
  final _Mission mission;

  const _MissionRow({required this.mission});

  @override
  Widget build(BuildContext context) {
    final Color color = mission.done ? Colors.greenAccent : Colors.white70;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            mission.done
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              mission.title,
              style: TextStyle(color: color, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────
///  SON AKTIVITELER PANELI
/// ─────────────────────────────────────────────
class _RecentActivitySection extends StatelessWidget {
  const _RecentActivitySection();

  @override
  Widget build(BuildContext context) {
    final activities = [
      "Temel Siber Güvenlik dersini tamamladın (+15 XP)",
      "Phishing quizinde 3/3 yaptın (+10 XP)",
      "Silver liginde #5 sıraya çıktın",
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF10162A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Son aktivitelerin",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final text = activities[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.brightness_1,
                        size: 6,
                        color: Colors.white54,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          text,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
