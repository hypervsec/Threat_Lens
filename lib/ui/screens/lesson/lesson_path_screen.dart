import 'package:flutter/material.dart';
import '../../../data/models/lesson.dart';
import 'lesson_detail_screen.dart';

/// ==============================================
///   DUOLINGO TARZI EĞİTİM YOLU EKRANI
///   - Zigzag görüş
///   - Glow efekti
///   - Seviye rozetleri
///   - Durum chip'i
///   - Progress circle
///   - Aktif derste nefes alma animasyonu
/// ==============================================
class LessonPathScreen extends StatelessWidget {
  const LessonPathScreen({super.key});

  List<Lesson> _buildLessons() {
    return [
      Lesson(
        id: "basic",
        title: "Temel Siber Güvenlik",
        icon: "🔐",
        unlocked: true,
        level: 5,
        progress: 1.0,
      ),
      Lesson(
        id: "phishing",
        title: "Phishing Analizi",
        icon: "🎣",
        unlocked: true,
        level: 1,
        progress: 0.4,
      ),
      Lesson(
        id: "malware",
        title: "Malware Temelleri",
        icon: "🦠",
        unlocked: false,
        level: 0,
        progress: 0.0,
      ),
      Lesson(
        id: "apt",
        title: "APT Tanıma",
        icon: "🎯",
        unlocked: false,
        level: 0,
        progress: 0.0,
      ),
      Lesson(
        id: "soc",
        title: "SOC / Log Analizi",
        icon: "💻",
        unlocked: false,
        level: 0,
        progress: 0.0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final lessons = _buildLessons();

    return Scaffold(
      appBar: AppBar(title: const Text("Eğitim Yolu"), centerTitle: true),
      body: Column(
        children: [
          const _LessonHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lessons.length * 2 - 1,
              itemBuilder: (context, index) {
                // Düğümler arası çizgi
                if (index.isOdd) return const LessonConnector();

                final i = index ~/ 2;
                final lesson = lessons[i];

                final previousDone = i == 0
                    ? true
                    : lessons[i - 1].progress >= 1;

                final unlocked = lesson.unlocked || previousDone;
                final completed = lesson.progress >= 1;
                final current = unlocked && !completed;

                return _LessonNode(
                  lesson: lesson,
                  isUnlocked: unlocked,
                  isCompleted: completed,
                  isCurrent: current,
                  leftAligned: i.isEven,
                  index: i,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ==============================================
///   HEADER – STREAK, XP BAR, DAILY GOAL
/// ==============================================
class _LessonHeader extends StatelessWidget {
  const _LessonHeader();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141A2C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.local_fire_department_rounded,
                color: Colors.orange.shade300,
              ),
              const SizedBox(width: 6),
              const Text(
                "Streak",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                "7 gün",
                style: TextStyle(
                  color: Colors.orange.shade300,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Text(
                "Bugünkü hedef: 20 XP",
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
              Spacer(),
              Text(
                "12 / 20 XP",
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 6,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(primary),
              value: 12 / 20,
            ),
          ),
        ],
      ),
    );
  }
}

/// ==============================================
///   TEK DERS BUBBLE
/// ==============================================
class _LessonNode extends StatelessWidget {
  final Lesson lesson;
  final bool isUnlocked;
  final bool isCompleted;
  final bool isCurrent;
  final bool leftAligned;
  final int index;

  const _LessonNode({
    required this.lesson,
    required this.isUnlocked,
    required this.isCompleted,
    required this.isCurrent,
    required this.leftAligned,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    final bubble = GestureDetector(
      onTap: isUnlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonDetailScreen(lesson: lesson),
                ),
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isUnlocked ? const Color(0xFF151A2C) : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isCompleted
                ? primary
                : (isUnlocked ? Colors.white24 : Colors.white12),
            width: 2,
          ),
          boxShadow: [
            if (isCompleted)
              BoxShadow(
                color: primary.withOpacity(0.25),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            if (isCurrent)
              BoxShadow(
                color: primary.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 0.5,
              ),
          ],
        ),
        child: _LessonBubbleContent(
          lesson: lesson,
          isUnlocked: isUnlocked,
          isCompleted: isCompleted,
        ),
      ),
    );

    final node = _PulsingBubble(active: isCurrent, child: bubble);

    final timelineDot = Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: isCompleted
            ? primary
            : (isUnlocked ? const Color(0xFF2A8CFD) : Colors.grey.shade700),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24, width: 2),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: leftAligned
            ? [
                Expanded(flex: 7, child: node), // Bubble geniş
                const SizedBox(width: 12),
                timelineDot,
                const Spacer(flex: 3),
              ]
            : [
                const Spacer(flex: 3),
                timelineDot,
                const SizedBox(width: 12),
                Expanded(flex: 7, child: node), // Bubble geniş
              ],
      ),
    );
  }
}

/// ==============================================
///   DERS BUBBLE İÇİ – TEXT + STATUS + LEVEL + PROGRESS
/// ==============================================
class _LessonBubbleContent extends StatelessWidget {
  final Lesson lesson;
  final bool isUnlocked;
  final bool isCompleted;

  const _LessonBubbleContent({
    required this.lesson,
    required this.isUnlocked,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = isUnlocked
        ? Colors.white
        : Colors.white.withOpacity(0.4);

    return Row(
      children: [
        Text(lesson.icon, style: const TextStyle(fontSize: 30)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lesson.title,
                maxLines: 2,
                overflow: TextOverflow.fade,
                softWrap: true,
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _StatusChip.fromLesson(
                          isUnlocked: isUnlocked,
                          isCompleted: isCompleted,
                        ),
                        if (lesson.level > 0 || isCompleted)
                          LevelBadge(level: isCompleted ? 5 : lesson.level),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        _LessonProgressIndicator(
          progress: lesson.progress,
          isUnlocked: isUnlocked,
          isCompleted: isCompleted,
        ),
      ],
    );
  }
}

/// ==============================================
///   BAŞLIK ÇİZGİSİ
/// ==============================================
class LessonConnector extends StatelessWidget {
  const LessonConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 4,
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xFF232B3E),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

/// ==============================================
///   LEVEL BADGE – LVL 1–5
/// ==============================================
class LevelBadge extends StatelessWidget {
  final int level;
  const LevelBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (level) {
      case 1:
        color = Colors.deepPurpleAccent;
        break;
      case 2:
        color = Colors.purpleAccent;
        break;
      case 3:
        color = Colors.greenAccent;
        break;
      case 4:
        color = Colors.amberAccent;
        break;
      case 5:
        color = Colors.orangeAccent;
        break;
      default:
        color = Colors.white30;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 1.3),
      ),
      child: Text(
        "LVL $level",
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 10.5,
        ),
      ),
    );
  }
}

/// ==============================================
///   STATUS CHIP
/// ==============================================
class _StatusChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _StatusChip({required this.label, required this.icon});

  factory _StatusChip.fromLesson({
    required bool isUnlocked,
    required bool isCompleted,
  }) {
    if (isCompleted) {
      return const _StatusChip(
        label: "Tamamlandı",
        icon: Icons.check_circle_rounded,
      );
    } else if (!isUnlocked) {
      return const _StatusChip(label: "Kilitli", icon: Icons.lock_rounded);
    } else {
      return const _StatusChip(
        label: "Devam Et",
        icon: Icons.play_arrow_rounded,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white70),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

/// ==============================================
///   PROGRESS CIRCLE
/// ==============================================
class _LessonProgressIndicator extends StatelessWidget {
  final double progress;
  final bool isUnlocked;
  final bool isCompleted;

  const _LessonProgressIndicator({
    required this.progress,
    required this.isUnlocked,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final p = progress.clamp(0.0, 1.0);

    if (!isUnlocked) {
      return const Icon(Icons.lock_rounded, color: Colors.white38, size: 24);
    }

    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: isCompleted ? 1.0 : p,
            strokeWidth: 4,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation(primary),
          ),
          isCompleted
              ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
              : Text(
                  "${(p * 100).toInt()}%",
                  style: const TextStyle(fontSize: 10),
                ),
        ],
      ),
    );
  }
}

/// ==============================================
///   AKTİF BUBBLE ANİMASYONU
/// ==============================================
class _PulsingBubble extends StatefulWidget {
  final Widget child;
  final bool active;
  const _PulsingBubble({required this.child, required this.active});

  @override
  State<_PulsingBubble> createState() => _PulsingBubbleState();
}

class _PulsingBubbleState extends State<_PulsingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );
  late final Animation<double> _scale = Tween<double>(
    begin: 0.98,
    end: 1.02,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();
    if (widget.active) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant _PulsingBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.active && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.active
        ? ScaleTransition(scale: _scale, child: widget.child)
        : widget.child;
  }
}
