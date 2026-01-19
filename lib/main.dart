//AI-Assisted
import 'package:flutter/material.dart';
import 'dart:math';
// Replaced "free_map" with the actual working packages
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const AtakApp());
}

// --- 1. DATA MODEL: TACTICAL MARKER ---
class TacticalMarker {
  String id;
  String label;
  String type; // 'Hostile', 'Friendly', 'Neutral'
  LatLng position; // CHANGED: Now uses real geospatial coordinates
  DateTime timestamp;

  TacticalMarker({
    required this.id,
    required this.label,
    required this.type,
    required this.position,
    required this.timestamp,
  });
}

// --- 2. MAIN APP CONFIGURATION ---
class AtakApp extends StatefulWidget {
  const AtakApp({super.key});

  @override
  State<AtakApp> createState() => _AtakAppState();
}

class _AtakAppState extends State<AtakApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATAK-Lite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF00FF41),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FF41),
          secondary: Colors.amber,
          surface: Color(0xFF1E1E1E),
        ),
        fontFamily: 'Courier',
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: const OnboardingScreen(),
      routes: {
        '/home': (context) => HomeScreen(
          toggleTheme: toggleTheme,
          isDark: _themeMode == ThemeMode.dark,
        ),
      },
    );
  }
}

// --- 3. ONBOARDING SCREEN ---
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (int page) => setState(() => _currentPage = page),
            children: const [
              OnboardingPage(
                title: "SYSTEM INITIALIZED",
                description:
                    "Welcome to ATAK-Lite.\nSituational awareness active.",
                color: Color(0xFF0D0D0D),
                icon: Icons.radar,
              ),
              OnboardingPage(
                title: "TARGET TRACKING",
                description: "Deploy markers for Friendlies and Hostiles.",
                color: Color(0xFF1A1A1A),
                icon: Icons.gps_fixed,
              ),
              OnboardingPage(
                title: "READY TO DEPLOY",
                description: "Map data loaded.\nSat-Link established.",
                color: Color(0xFF262626),
                icon: Icons.satellite_alt,
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: _currentPage == 2
                ? Center(
                    child: TacticalButton(
                      text: "ENTER COMMAND",
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/home'),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage > 0)
                        TextButton(
                          onPressed: () => _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          ),
                          child: const Text(
                            "ABORT",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      else
                        const SizedBox(width: 60),
                      IconButton(
                        onPressed: () => _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        ),
                        icon: const Icon(
                          Icons.chevron_right,
                          size: 30,
                          color: Colors.greenAccent,
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

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Colors.greenAccent),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

// --- 4. SETTINGS SCREEN ---
class SettingsScreen extends StatelessWidget {
  final Function(bool) toggleTheme;
  final bool isDark;
  final bool isSatellite;
  final Function(bool) toggleSatellite;

  const SettingsScreen({
    super.key,
    required this.toggleTheme,
    required this.isDark,
    required this.isSatellite,
    required this.toggleSatellite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CONFIGURATION"), centerTitle: true),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.nightlight_round),
            title: const Text("Night Ops Mode (Dark)"),
            trailing: Switch(
              value: isDark,
              activeColor: Colors.greenAccent,
              onChanged: toggleTheme,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.satellite),
            title: const Text("Satellite Imagery"),
            subtitle: const Text("Toggle Topographic vs Satellite"),
            trailing: Switch(
              value: isSatellite,
              activeColor: Colors.greenAccent,
              onChanged: toggleSatellite,
            ),
          ),
        ],
      ),
    );
  }
}

// --- 5. HOME SCREEN (Using Flutter Map) ---
class HomeScreen extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();

  // Center map on Bangkok (User Location Context)
  LatLng _center = const LatLng(13.7563, 100.5018);

  List<TacticalMarker> markers = [
    TacticalMarker(
      id: '1',
      label: 'Alpha Team',
      type: 'Friendly',
      position: const LatLng(13.7563, 100.5018),
      timestamp: DateTime.now(),
    ),
    TacticalMarker(
      id: '2',
      label: 'Target X',
      type: 'Hostile',
      position: const LatLng(13.7600, 100.5100),
      timestamp: DateTime.now(),
    ),
  ];

  bool _isSatellite = false; // Default to topo for clarity

  void _addMarker(TacticalMarker marker) {
    setState(() {
      markers.add(marker);
      _center = marker.position; // Pan to new marker
      _mapController.move(_center, 15);
    });
  }

  void _toggleSatellite(bool val) {
    setState(() {
      _isSatellite = val;
    });
  }

  // Tactical Color Filter for Dark Mode
  // This turns the bright OSM map into a cool green/black radar look
  final matrix = <double>[
    -1,
    0,
    0,
    0,
    255,
    0,
    -1,
    0,
    0,
    255,
    0,
    0,
    -1,
    0,
    255,
    0,
    0,
    0,
    1,
    0,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        title: const Text(
          "ATAK: SECTOR 7",
          style: TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_suggest, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    toggleTheme: widget.toggleTheme,
                    isDark: widget.isDark,
                    isSatellite: _isSatellite,
                    toggleSatellite: _toggleSatellite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // LAYER 1: The Real Map Engine
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: _center, initialZoom: 13.0),
            children: [
              // Tile Layer (The Map Images)
              ColorFiltered(
                // Apply "Negative" filter if in Dark Mode + Topo Mode for tactical look
                colorFilter: widget.isDark && !_isSatellite
                    ? ColorFilter.matrix(
                        matrix,
                      ) // Inverts colors for radar look
                    : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
                child: TileLayer(
                  urlTemplate: _isSatellite
                      ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
                      : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.atak.lite',
                ),
              ),

              // Grid Overlay (Decoration)
              if (widget.isDark)
                Opacity(
                  opacity: 0.1,
                  child: IgnorePointer(
                    child: Image.network(
                      "https://www.transparenttextures.com/patterns/grid-me.png",
                      repeat: ImageRepeat.repeat,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),

              // LAYER 2: Markers
              MarkerLayer(
                markers: markers.map((m) {
                  return Marker(
                    point: m.position,
                    width: 80,
                    height: 80,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "ID: ${m.label} [${m.type}] @ ${m.position.latitude.toStringAsFixed(4)}, ${m.position.longitude.toStringAsFixed(4)}",
                            ),
                            backgroundColor: Colors.black,
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Icon(
                            m.type == 'Hostile'
                                ? Icons.location_on
                                : Icons.shield,
                            color: m.type == 'Hostile'
                                ? Colors.redAccent
                                : Colors.blueAccent,
                            size: 40,
                          ),
                          Container(
                            color: Colors.black87,
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              m.label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // LAYER 3: HUD (Heads Up Display)
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                border: Border.all(color: Colors.greenAccent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LAT: ${_center.latitude.toStringAsFixed(4)}  LNG: ${_center.longitude.toStringAsFixed(4)}",
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    "ALT: 15m // SPD: 0kph",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                  ),
                  const Text(
                    "STS: ONLINE // SAT: CONNECTED",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          // Crosshair
          const Center(
            child: Opacity(
              opacity: 0.3,
              child: Icon(Icons.add, color: Colors.greenAccent, size: 50),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () async {
          // Pass current center to marker screen to simulate dropping near user
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMarkerScreen(center: _center),
            ),
          );
          if (result != null && result is TacticalMarker) {
            _addMarker(result);
          }
        },
        child: const Icon(Icons.add_location_alt, color: Colors.black),
      ),
    );
  }
}

// --- 6. ADD MARKER SCREEN ---
class AddMarkerScreen extends StatefulWidget {
  final LatLng center;
  const AddMarkerScreen({super.key, required this.center});

  @override
  State<AddMarkerScreen> createState() => _AddMarkerScreenState();
}

class _AddMarkerScreenState extends State<AddMarkerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  String _type = 'Friendly';
  final Random _rnd = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DEPLOY MARKER")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.greenAccent.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _labelController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "DESIGNATION / LABEL",
                        labelStyle: TextStyle(color: Colors.greenAccent),
                        border: InputBorder.none,
                        icon: Icon(Icons.tag, color: Colors.grey),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Field Required' : null,
                    ),
                    const Divider(color: Colors.grey),
                    DropdownButtonFormField<String>(
                      value: _type,
                      dropdownColor: const Color(0xFF1E1E1E),
                      style: const TextStyle(color: Colors.white),
                      items: ['Friendly', 'Hostile', 'Neutral']
                          .map(
                            (p) => DropdownMenuItem(value: p, child: Text(p)),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _type = val!),
                      decoration: const InputDecoration(
                        labelText: "IFF STATUS",
                        labelStyle: TextStyle(color: Colors.greenAccent),
                        border: InputBorder.none,
                        icon: Icon(Icons.radar, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "TARGET ZONE: ${widget.center.latitude.toStringAsFixed(3)}, ${widget.center.longitude.toStringAsFixed(3)}",
                style: const TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              TacticalButton(
                text: "CONFIRM DROP",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Simulate a random offset near the current center
                    final double latOffset = (_rnd.nextDouble() - 0.5) * 0.01;
                    final double lngOffset = (_rnd.nextDouble() - 0.5) * 0.01;

                    final newMarker = TacticalMarker(
                      id: DateTime.now().toString(),
                      label: _labelController.text,
                      type: _type,
                      position: LatLng(
                        widget.center.latitude + latOffset,
                        widget.center.longitude + lngOffset,
                      ),
                      timestamp: DateTime.now(),
                    );
                    Navigator.pop(context, newMarker);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 7. CUSTOM WIDGETS ---
class TacticalButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const TacticalButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<TacticalButton> createState() => _TacticalButtonState();
}

class _TacticalButtonState extends State<TacticalButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Colors.greenAccent.withOpacity(0.1),
            border: Border.all(color: Colors.greenAccent, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
