import 'package:flutter/material.dart';

// void main() {
//   runApp(AutoSenseApp());
// }

class AutoSenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoSense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: const Color(0xFFf0f4f9),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey.shade900,
          elevation: 4,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // cardTheme: CardTheme(
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //   elevation: 6,
        //   shadowColor: Colors.blueGrey.withOpacity(0.3),
        //   margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        //   color: Colors.white,
        // ),
        // textTheme: TextTheme(
        //   headline6: TextStyle(
        //       color: Colors.blueGrey.shade900,
        //       fontWeight: FontWeight.w700,
        //       fontSize: 20),
        //   subtitle1:
        //       TextStyle(color: Colors.blueGrey.shade700, fontSize: 15.5),
        //   bodyText2:
        //       TextStyle(color: Colors.blueGrey.shade800, fontSize: 16, height: 1.5),
        // ),
      ),
      home: HomeScreen(),
      routes: {'/sensors': (_) => SensorsModule()},
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<_ModuleItem> modules = [
    _ModuleItem(
      title: 'Sensory pojazdu',
      description: 'Radar, LIDAR, Kamera, Ultradźwięki',
      icon: Icons.sensors,
      route: '/sensors',
      color: Colors.blueGrey.shade700,
      gradient: const LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF455A64)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('AutoSense'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey.shade900,
                      Colors.blueGrey.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Text(
                      'Edukacja o ADAS i Autonomii',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final module = modules[index];
                return _ModuleCard(module: module);
              }, childCount: modules.length),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatefulWidget {
  final _ModuleItem module;
  const _ModuleCard({Key? key, required this.module}) : super(key: key);

  @override
  State<_ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<_ModuleCard>
    with SingleTickerProviderStateMixin {
  double elevation = 6;

  @override
  Widget build(BuildContext context) {
    final module = widget.module;
    return MouseRegion(
      onEnter: (_) => setState(() => elevation = 14),
      onExit: (_) => setState(() => elevation = 6),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, module.route),
        child: Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          clipBehavior: Clip.antiAlias,
          child: Ink(
            decoration: BoxDecoration(gradient: module.gradient),
            child: Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Icon(module.icon, size: 42, color: Colors.white),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          module.description,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14.5,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white70),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModuleItem {
  final String title;
  final String description;
  final IconData icon;
  final String route;
  final Color color;
  final Gradient gradient;
  _ModuleItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
    required this.color,
    required this.gradient,
  });
}

class SensorsModule extends StatelessWidget {
  final List<_SensorItem> sensors = [
    _SensorItem(
      name: 'Radar',
      description:
          'Detekcja obiektów z przodu, pomiar prędkości pojazdów.\n\n'
          'Radar wykorzystuje fale radiowe do identyfikacji przeszkód i pomiaru ich prędkości.',
      icon: Icons.radar,
      color: Colors.blue.shade700,
    ),
    _SensorItem(
      name: 'LIDAR',
      description:
          'Skan 3D otoczenia oraz wykrywanie pieszych i przeszkód.\n\n'
          'LIDAR używa wiązek laserowych do tworzenia mapy przestrzennej.',
      icon: Icons.scatter_plot,
      color: Colors.deepPurple.shade600,
    ),
    _SensorItem(
      name: 'Kamera',
      description:
          'Rozpoznawanie pasów ruchu i znaków drogowych.\n\n'
          'Kamery analizują obraz w czasie rzeczywistym.',
      icon: Icons.camera_alt,
      color: Colors.orange.shade700,
    ),
    _SensorItem(
      name: 'Ultradźwięki',
      description:
          'Systemy parkowania i wykrywanie przeszkód w bezpośrednim otoczeniu pojazdu.',
      icon: Icons.surround_sound,
      color: Colors.teal.shade700,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moduł Sensory pojazdu'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Container(
        color: const Color(0xFFf0f4f9),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          itemCount: sensors.length,
          itemBuilder: (context, index) {
            final sensor = sensors[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(sensor.icon, color: sensor.color, size: 28),
                              const SizedBox(width: 12),
                              Text(
                                sensor.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey.shade900,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            sensor.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey.shade800,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                backgroundColor: sensor.color.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Zamknij',
                                style: TextStyle(
                                  color: sensor.color,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        sensor.color.withOpacity(0.85),
                        sensor.color.withOpacity(0.65),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Icon(sensor.icon, size: 36, color: Colors.white),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Text(
                          sensor.name,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.info_outline,
                        color: Colors.white70,
                        size: 26,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SensorItem {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  _SensorItem({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}
