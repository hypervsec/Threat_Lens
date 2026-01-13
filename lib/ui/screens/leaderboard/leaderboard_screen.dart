import 'package:flutter/material.dart';

/// ==============================================
///  LIG TIPLERI
/// ==============================================
enum LeagueType {
  bronze,
  silver,
  gold,
  sapphire,
  ruby,
  emerald,
  amethyst,
  diamond,
}

Color leagueColor(LeagueType league) {
  switch (league) {
    case LeagueType.bronze:
      return Colors.brown.shade400;
    case LeagueType.silver:
      return Colors.blueGrey.shade200;
    case LeagueType.gold:
      return Colors.amberAccent;
    case LeagueType.sapphire:
      return Colors.blueAccent;
    case LeagueType.ruby:
      return Colors.redAccent;
    case LeagueType.emerald:
      return Colors.greenAccent;
    case LeagueType.amethyst:
      return Colors.purpleAccent;
    case LeagueType.diamond:
      return Colors.cyanAccent;
  }
}

/// ==============================================
///   HAFTALIK RESET TIMER HELPERS
/// ==============================================
Duration timeUntilMonday() {
  final now = DateTime.now();

  // Haftanın 1. günü Pazartesi (weekday = 1)
  final daysUntilMonday = (8 - now.weekday) % 7;
  final monday = now.add(Duration(days: daysUntilMonday));

  final nextMonday = DateTime(monday.year, monday.month, monday.day);
  return nextMonday.difference(now);
}

String formatDuration(Duration d) {
  final days = d.inDays;
  final hours = d.inHours % 24;
  final mins = d.inMinutes % 60;
  final secs = d.inSeconds % 60;

  return "${days}g ${hours}sa ${mins}dk ${secs}sn";
}

/// ==============================================
///   ANA LIDERLIK EKRANI
/// ==============================================
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sahte oyuncu listesi
    final players = [
      Player(rank: 1, name: "HexHunter", xp: 480, trend: 2),
      Player(rank: 2, name: "BurakSec", xp: 540, trend: 1),
      Player(rank: 3, name: "CyberNinja", xp: 430, trend: 0),
      Player(rank: 4, name: "RedWolf", xp: 320, trend: 1),
      Player(rank: 5, name: "Kingo", xp: 300, trend: 0, isYou: true),
      Player(rank: 6, name: "SilentRoot", xp: 260, trend: -2),
      Player(rank: 7, name: "ZeroTrace", xp: 220, trend: 1),
      Player(rank: 8, name: "DarkSignal", xp: 190, trend: 0),
    ];

    const currentLeague = LeagueType.silver;
    const yourRank = 5;

    return Scaffold(
      backgroundColor: const Color(0xFF070B1A),
      appBar: AppBar(
        title: const Text("Liderlik Tablosu"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF050A18), Color(0xFF0A1126)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // LIG PANELI + RESET TIMER
            const LeagueHeader(league: currentLeague, yourRank: yourRank),
            const SizedBox(height: 20),

            // TOP 3 KARTLAR
            _TopThree(players: players.take(3).toList()),
            const SizedBox(height: 20),

            // UST LIGE CİZİGİ
            const PromotionLine(league: currentLeague),
            const SizedBox(height: 10),

            // LISTE
            ...players.skip(3).map((p) => _LeaderboardRow(player: p)),
          ],
        ),
      ),
    );
  }
}

/// ==============================================
///   MODEL
/// ==============================================
class Player {
  final int rank;
  final String name;
  final int xp;
  final int trend;
  final bool isYou;

  Player({
    required this.rank,
    required this.name,
    required this.xp,
    required this.trend,
    this.isYou = false,
  });
}

/// ==============================================
///   LIG HEADER + RESET TIMER
/// ==============================================
class LeagueHeader extends StatelessWidget {
  final LeagueType league;
  final int yourRank;

  const LeagueHeader({super.key, required this.league, required this.yourRank});

  @override
  Widget build(BuildContext context) {
    final color = leagueColor(league);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1427),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          LeagueBadge(league: league),
          const SizedBox(height: 10),

          Text(
            "Bu hafta ${league.name.toUpperCase()} ligindesin",
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 4),

          Text(
            "Sıran: #$yourRank",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 12),

          /// RESET TIMER – BURASI EKLENDİ
          StreamBuilder(
            stream: Stream.periodic(
              const Duration(seconds: 1),
              (_) => timeUntilMonday(),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox();

              final d = snapshot.data as Duration;

              return Text(
                "Lig resetine kalan süre: ${formatDuration(d)}",
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              );
            },
          ),

          const SizedBox(height: 12),

          Text(
            "İlk 3'e girersen bir üst lige yükseleceksin.",
            style: TextStyle(
              color: Colors.white70.withOpacity(0.9),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class LeagueBadge extends StatelessWidget {
  final LeagueType league;

  const LeagueBadge({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    final color = leagueColor(league);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
        gradient: LinearGradient(
          colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield_rounded, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            league.name.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

/// ==============================================
///   UST LIGE KAYIT CIZGISI
/// ==============================================
class PromotionLine extends StatelessWidget {
  final LeagueType league;

  const PromotionLine({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    final color = leagueColor(league);

    return Row(
      children: [
        Expanded(child: Divider(color: color.withOpacity(0.4))),
        const SizedBox(width: 8),
        Text(
          "Üst lige yükselme sınırı",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: color.withOpacity(0.4))),
      ],
    );
  }
}

/// ==============================================
///   TOP 3 – NEON KARTLAR
/// ==============================================
class _TopThree extends StatelessWidget {
  final List<Player> players;

  const _TopThree({required this.players});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _NeonRankCard(player: players[1], color: Colors.blueAccent),
        ),
        Expanded(
          child: _NeonRankCard(player: players[0], color: Colors.amberAccent),
        ),
        Expanded(
          child: _NeonRankCard(player: players[2], color: Colors.purpleAccent),
        ),
      ],
    );
  }
}

class _NeonRankCard extends StatelessWidget {
  final Player player;
  final Color color;

  const _NeonRankCard({required this.player, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withOpacity(0.7), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.45),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
        gradient: LinearGradient(
          colors: [color.withOpacity(0.12), color.withOpacity(0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            "#${player.rank}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.4),
            child: Text(
              player.name[0],
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            player.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "${player.xp} XP",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

/// ==============================================
///   NORMAL SATIR – KULLANICI LISTESI
/// ==============================================
class _LeaderboardRow extends StatelessWidget {
  final Player player;

  const _LeaderboardRow({required this.player});

  @override
  Widget build(BuildContext context) {
    final neon = player.isYou ? Colors.purpleAccent : Colors.blueGrey;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F162B),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: player.isYou ? neon : Colors.white10,
          width: player.isYou ? 2 : 1,
        ),
        boxShadow: [
          if (player.isYou)
            BoxShadow(
              color: neon.withOpacity(0.35),
              blurRadius: 16,
              spreadRadius: 1,
            ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "#${player.rank}",
            style: TextStyle(
              color: neon,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 10),

          CircleAvatar(
            radius: 18,
            backgroundColor: neon.withOpacity(0.3),
            child: Text(
              player.name[0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Text(
              player.name,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),

          Text(
            "${player.xp} XP",
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),

          const SizedBox(width: 10),

          Icon(
            player.trend > 0
                ? Icons.arrow_upward_rounded
                : player.trend < 0
                ? Icons.arrow_downward_rounded
                : Icons.remove_rounded,
            size: 18,
            color: player.trend > 0
                ? Colors.greenAccent
                : player.trend < 0
                ? Colors.redAccent
                : Colors.grey,
          ),
        ],
      ),
    );
  }
}
