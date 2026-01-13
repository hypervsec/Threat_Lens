import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Ayarlar",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ───────────── HESAP ─────────────
          const Text(
            "Hesap",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 10),

          _settingsTile(
            icon: Icons.lock_outline,
            text: "Şifre Değiştir",
            onTap: () {},
          ),

          const SizedBox(height: 25),

          // ───────────── UYGULAMA ─────────────
          const Text(
            "Uygulama",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 10),

          _settingsTile(
            icon: Icons.notifications_none,
            text: "Bildirimler",
            onTap: () {},
          ),

          _settingsTile(
            icon: Icons.color_lens_outlined,
            text: "Tema",
            onTap: () {},
          ),

          const SizedBox(height: 25),

          // ───────────── DESTEK ─────────────
          const Text(
            "Destek",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 10),

          _settingsTile(
            icon: Icons.help_outline,
            text: "Yardım & SSS",
            onTap: () {},
          ),

          _settingsTile(
            icon: Icons.mail_outline,
            text: "Destek ile İletişim",
            onTap: () {},
          ),

          const SizedBox(height: 30),

          // ───────────── ÇIKIŞ YAP ─────────────
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Çıkış Yap",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────
  //  REUSABLE SETTINGS TILE
  // ────────────────────────────────
  Widget _settingsTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors.white38, size: 16),
        onTap: onTap,
      ),
    );
  }
}
