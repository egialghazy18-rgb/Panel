import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget { const MyApp({super.key}); @override Widget build(BuildContext c) => MaterialApp(theme: ThemeData.dark(), home: const P()); }
class P extends StatefulWidget { const P({super.key}); @override State<P> createState() => _P(); }
class _P extends State<P> {
  final url = "https://URL-VERCEL-LU.vercel.app/api/toggle";
  Future<void> t(String f, bool v) async { await http.post(Uri.parse(url), body: jsonEncode({"feature": f, "status": v?"on":"off"})); }
  @override Widget build(BuildContext c) => Scaffold(appBar: AppBar(title: const Text("Panel")), body: Column(children: [
    SwitchListTile(title: const Text("AimBot"), onChanged: (v) => t("aimbot", v)),
    SwitchListTile(title: const Text("Wallhack"), onChanged: (v) => t("wallhack", v)),
    ElevatedButton(onPressed: () {}, child: const Text("RUN GAME"))
  ]));
}
