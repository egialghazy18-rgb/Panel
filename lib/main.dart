import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(primaryColor: Colors.redAccent),
    home: const MainMenu(),
  );
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String? _selectedGame;
  bool _isInstalled = false;
  bool _isProcessing = false;

  final List<Map<String, String>> _games = [
    {"name": "Free Fire", "package": "com.dts.freefireth"},
    {"name": "Free Fire Max", "package": "com.dts.freefiremax"},
    {"name": "Mobile Legends", "package": "com.mobile.legends"},
  ];

  void _startProcess() async {
    if (_selectedGame == null) return;
    
    setState(() => _isProcessing = true);
    
    // Simulasi proses Install Config
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isInstalled = true;
      _isProcessing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Config Cheat Berhasil Diinstall!"), backgroundColor: Colors.green),
    );
  }

  void _runGameAndOverlay() async {
    // 1. Minta izin buat nampilin Floating Menu di atas game
    if (!await FlutterOverlayWindow.isPermissionGranted()) {
      await FlutterOverlayWindow.requestPermission();
    }
    
    // 2. Munculin Floating Menu
    await FlutterOverlayWindow.showOverlay(
      enableDrag: true,
      overlayTitle: "Cheat Menu",
      overlayContent: "Floating Menu Aktif",
      flag: OverlayFlag.defaultFlag,
      visibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      height: 100,
      width: 100,
    );

    // 3. Di sini lu nanti masukin kode buat nge-launch aplikasi Free Fire
    // package: launch_app_from_package(_selectedGame)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Injection Panel")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Pilih Game:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.black26,
              ),
              items: _games.map((g) => DropdownMenuItem(
                value: g["package"],
                child: Text(g["name"]!),
              )).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedGame = val;
                  _isInstalled = false;
                });
              },
            ),
            
            const SizedBox(height: 30),
            
            // TOMBOL INSTALL
            ElevatedButton(
              onPressed: _selectedGame == null || _isInstalled || _isProcessing ? null : _startProcess,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isInstalled ? Colors.green : Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: _isProcessing 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(_isInstalled ? "✓ TERINSTALL" : "INSTALL CONFIG", style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            
            const SizedBox(height: 15),
            
            // TOMBOL RUN
            ElevatedButton(
              onPressed: _isInstalled ? _runGameAndOverlay : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text("RUN GAME + OVERLAY", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            
            const SizedBox(height: 30),
            const Text(
              "*Floating Menu akan muncul di atas game setelah lu klik RUN.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
