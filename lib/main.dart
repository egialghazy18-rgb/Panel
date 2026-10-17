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
    body: Column(
      children: [
        SwitchListTile(
          title: const Text("AimBot"),
          value: aimbot, // <-- INI YANG KURANG TADI
          onChanged: (v) {
            setState(() => aimbot = v);
            t("aimbot", v);
          },
        ),
        SwitchListTile(
          title: const Text("Wallhack"),
          value: wallhack, // <-- INI JUGA
          onChanged: (v) {
            setState(() => wallhack = v);
            t("wallhack", v);
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {}, 
          child: const Text("RUN GAME")
        )
      ],
    ),
  );
}
