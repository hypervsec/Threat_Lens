import 'package:flutter/material.dart';
import 'apt_detail_screen.dart';

class APTScreen extends StatelessWidget {
  const APTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> aptGroups = [
      {
        "name": "APT28 (Fancy Bear)",
        "alias": "Sofacy, Sednit, STRONTIUM",
        "country": "Rusya",
        "description":
            "Rusya merkezli devlet destekli bir tehdit grubu. Genellikle askeri, politik ve stratejik kurumları hedef alır.",
        "attacks": [
          "2016 US Election Hack",
          "WADA Anti-Doping saldırısı",
          "NATO kurumlarına spear-phishing",
        ],
      },
      {
        "name": "APT29 (Cozy Bear)",
        "alias": "Dukes, Nobelium",
        "country": "Rusya",
        "description":
            "Siber casusluk faaliyetleriyle bilinen APT29, özellikle devlet kurumları ve araştırma merkezlerini hedef alır.",
        "attacks": [
          "SolarWinds Supply Chain Attack",
          "COVID-19 araştırma kurumlarına saldırı",
        ],
      },
      {
        "name": "Lazarus Group",
        "alias": "Hidden Cobra, Guardians of Peace",
        "country": "Kuzey Kore",
        "description":
            "Kuzey Kore destekli siber tehdit aktörü. Siber sabotaj, finansal saldırılar ve veri hırsızlığıyla bilinir.",
        "attacks": [
          "Sony Pictures Hack",
          "WannaCry Ransomware",
          "SWIFT Bank saldırıları",
        ],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF050814),
      appBar: AppBar(
        title: const Text("APT Grupları"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // ────────────────────────────────────────────────
            // 🔥 APT Nedir? – Neon Cyberpunk Info Bar
            // ────────────────────────────────────────────────
            _aptInfoCard(),

            // ────────────────────────────────────────────────
            // 🔥 APT GRUP KARTLARI
            // ────────────────────────────────────────────────
            ...aptGroups.map((apt) {
              return APTGroupCard(
                name: apt["name"],
                alias: apt["alias"],
                country: apt["country"],
                description: apt["description"],
                attacks: apt["attacks"],
              );
            }),
          ],
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────
  // 🔥 Neon Cyberpunk APT Info Card
  // ────────────────────────────────────────────────
  Widget _aptInfoCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F22).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.cyanAccent.withOpacity(0.45),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.35),
            blurRadius: 22,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: Colors.cyanAccent, size: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "APT Nedir?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "APT (Advanced Persistent Threat), devlet destekli veya çok organize siber saldırı gruplarının yaptığı uzun süreli, hedef odaklı siber casusluk operasyonlarıdır.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class APTGroupCard extends StatelessWidget {
  final String name;
  final String alias;
  final String country;
  final String description;
  final List<String> attacks;

  const APTGroupCard({
    super.key,
    required this.name,
    required this.alias,
    required this.country,
    required this.description,
    required this.attacks,
  });

  @override
  Widget build(BuildContext context) {
    final neon = Colors.cyanAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: neon.withOpacity(0.4), width: 1.3),
        boxShadow: [
          BoxShadow(
            color: neon.withOpacity(0.22),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
        color: const Color(0xFF0A0F23),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.visibility, color: neon, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: neon,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text("Alias: $alias", style: const TextStyle(color: Colors.white70)),
          Text("Ülke: $country", style: const TextStyle(color: Colors.white70)),

          const SizedBox(height: 12),
          const Text(
            "Bilinen Operasyonlar:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),

          ...attacks.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 6, color: Colors.white70),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      a,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => APTDetailScreen(
                      name: name,
                      alias: alias,
                      country: country,
                      description: description,
                      attacks: attacks,
                    ),
                  ),
                );
              },
              child: Text(
                "Detaylar >",
                style: TextStyle(
                  color: neon,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
