import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(primaryColor: Colors.redAccent),
    home: const P(),
  );
}

class P extends StatefulWidget {
  const P({super.key});
  @override
  State<P> createState() => _P();
}

class _P extends State<P> {
  // GANTI URL VERCEL LU DI SINI NANTI
  final url = "https://URL-VERCEL-LU.vercel.app/api/toggle";
  
  bool aimbot = false;
  bool wallhack = false;

  Future<void> t(String f, bool v) async {
    try {
      await http.post(Uri.parse(url), body: jsonEncode({"feature": f, "status": v ? "on" : "off"}));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text("Injection Panel")),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.black45,
            child: const Row(
              children: [
                Icon(Icons.phone_android, color: Colors.redAccent),
                SizedBox(width: 10),
                Text("HP Terdeteksi: Android", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text("AimBot"),
            value: aimbot,
            onChanged: (v) {
              setState(() => aimbot = v);
              t("aimbot", v);
            },
          ),
          SwitchListTile(
            title: const Text("Wallhack"),
            value: wallhack,
            onChanged: (v) {
              setState(() => wallhack = v);
              t("wallhack", v);
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            onPressed: () {}, 
            child: const Text("RUN GAME", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          )
        ],
      ),
    ),
  );
}
