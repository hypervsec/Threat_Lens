import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'ui/widgets/bottom_nav.dart';

void main() {
  runApp(const ThreatLensApp());
}

class ThreatLensApp extends StatelessWidget {
  const ThreatLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const BottomNav(), // Alt bar ile açıyoruz
    );
  }
}
