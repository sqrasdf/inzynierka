import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikacja edukacyjna',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Lista 5 przykładowych modułów – treść uzupełnisz samodzielnie
  final List<ModuleData> modules = const [
    ModuleData(
      title: 'Moduł Sensory pojazdu',
      shortDescription:
      'Przedstawia działanie czujników pojazdu (Radar, LIDAR, Kamera, Ultradźwięki) oraz ich dane w symulacji.',
      icon: Icons.sensors,
      backgroundColor: Color(0xFFE3F2FD),
    ),
    ModuleData(
      title: 'Moduł Strategie jazdy autonomicznej',
      shortDescription:
      'Omawia algorytmy podejmowania decyzji przez pojazd autonomiczny i pozwala testować scenariusze zachowań AI.',
      icon: Icons.route,
      backgroundColor: Color(0xFFF3E5F5),
    ),
    ModuleData(
      title: 'Moduł Fuzja danych',
      shortDescription:
      'Pokazuje, jak system łączy dane z różnych czujników w celu dokładniejszego rozpoznawania obiektów.',
      icon: Icons.join_full,
      backgroundColor: Color(0xFFFFF3E0),
    ),
    ModuleData(
      title: 'Moduł Tryby poziomu autonomii',
      shortDescription:
      'Wyjaśnia poziomy automatyzacji jazdy (0–5) z przykładami i quizem rozpoznawania poziomu.',
      icon: Icons.speed,
      backgroundColor: Color(0xFFE8F5E9),
    ),
    ModuleData(
      title: 'Tryb Symulacji sytuacji drogowych',
      shortDescription:
      'Umożliwia analizę i podejmowanie decyzji w realistycznych scenariuszach ruchu drogowego z udziałem AI.',
      icon: Icons.traffic,
      backgroundColor: Color(0xFFFFEBEE),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autosense'),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          return ModuleBlock(module: module);
        },
      ),
    );
  }
}

class ModuleData {
  final String title;
  final String shortDescription;
  final IconData icon;
  final Color backgroundColor;

  const ModuleData({
    required this.title,
    required this.shortDescription,
    required this.icon,
    required this.backgroundColor,
  });
}

class ModuleBlock extends StatelessWidget {
  final ModuleData module;

  const ModuleBlock({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: module.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ikona w kółku
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              module.icon,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          // Tekst
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  module.shortDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Strzałka wskazująca przejście
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[600],
            size: 20,
          ),
        ],
      ),
    );
  }
}