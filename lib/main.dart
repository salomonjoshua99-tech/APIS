import 'package:flutter/material.dart';

import 'package:api/ui/pages/home_page.dart';

void main() {
  runApp(const PlanetWatchApp());
}

class PlanetWatchApp extends StatelessWidget {
  const PlanetWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planet Watch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F7A6D)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
