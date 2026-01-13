import 'package:flutter/material.dart';

class APTDetailScreen extends StatelessWidget {
  final String name;
  final String alias;
  final String country;
  final String description;
  final List<String> attacks;

  const APTDetailScreen({
    super.key,
    required this.name,
    required this.alias,
    required this.country,
    required this.description,
    required this.attacks,
  });

  // 🔥 MITRE ATT&CK Örnek Veri (istersen her gruba ayrı ekleyebiliriz)
  Map<String, List<String>> get mitre => {
    "Initial Access": [
      "Phishing (T1566)",
      "Exploit Public-Facing Applications (T1190)",
    ],
    "Execution": ["PowerShell (T1059.001)", "Command-Line Interface (T1059)"],
    "Persistence": ["Registry Run Keys (T1547)", "Scheduled Task (T1053)"],
    "Privilege Escalation": [
      "Exploitation for Privilege Escalation (T1068)",
      "Token Impersonation (T1134)",
    ],
    "Defense Evasion": [
      "Obfuscated/Encrypted Payloads (T1027)",
      "Deleting Logs (T1070)",
    ],
    "Credential Access": [
      "Keylogging (T1056.001)",
      "Credential Dumping (T1003)",
    ],
    "Lateral Movement": [
      "Remote Services (T1021)",
      "Pass-the-Hash (T1550.002)",
    ],
    "Exfiltration": [
      "Exfiltration Over Web Services (T1567)",
      "Data Encrypted (T1048.002)",
    ],
    "Command & Control": ["HTTPS C2 (T1071.001)", "Custom Protocol (T1095)"],
  };

  @override
  Widget build(BuildContext context) {
    final neon = Colors.cyanAccent;

    return Scaffold(
      backgroundColor: const Color(0xFF050814),
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ───────────── HEADER ─────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [
                    neon.withOpacity(0.18),
                    Colors.purpleAccent.withOpacity(0.18),
                  ],
                ),
                border: Border.all(color: neon.withOpacity(0.55), width: 1.4),
                boxShadow: [
                  BoxShadow(color: neon.withOpacity(0.4), blurRadius: 20),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.visibility, size: 40, color: neon),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _infoRow(Icons.badge, "Alias: $alias"),
            const SizedBox(height: 6),
            _infoRow(Icons.flag, "Menşei: $country"),

            const SizedBox(height: 20),

            // ───────────── GENEL AÇIKLAMA ─────────────
            const Text(
              "Genel Açıklama",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            const SizedBox(height: 25),

            // ───────────── OPERASYONLAR ─────────────
            Text(
              "Bilinen Operasyonlar",
              style: TextStyle(
                color: neon,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),
            ...attacks.map(
              (a) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A1028),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.bolt, color: Colors.amberAccent, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        a,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ───────────── MITRE ATT&CK TAKTİKLERİ ─────────────
            Text(
              "MITRE ATT&CK Taktikleri",
              style: TextStyle(
                color: neon,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 18),

            ...mitre.entries.map(
              (entry) => _mitreCategory(entry.key, entry.value),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────
  //  MITRE Kategorisi Widget
  // ──────────────────────────────────────────────────────────────
  Widget _mitreCategory(String title, List<String> techniques) {
    final neon = Colors.cyanAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1022),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: neon.withOpacity(0.35)),
        boxShadow: [BoxShadow(color: neon.withOpacity(0.2), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Text(
            title,
            style: TextStyle(
              color: neon,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),

          // Teknikler
          ...techniques.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6, color: neon),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      t,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────
  //  ICON + TEXT satırı
  // ──────────────────────────────────────────────────────────────
  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
