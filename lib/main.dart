import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(AdapertusApp());
}

class AdapertusApp extends StatefulWidget {
  const AdapertusApp({super.key});

  // Pour accéder à l’état depuis d’autres widgets (ex: SettingsScreen)
  static _AdapertusAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AdapertusAppState>();

  static const Color brandBlue = Color(0xFF0B3163); // Couleur principale
  static const Color brandBg = Color(0xFFF2F3F5);   // Couleur de fond

  @override
  State<AdapertusApp> createState() => _AdapertusAppState();
}

class _AdapertusAppState extends State<AdapertusApp> {
  bool isDarkMode = false;

  void toggleTheme(bool dark) {
    setState(() {
      isDarkMode = dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adapertus',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AdapertusApp.brandBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AdapertusApp.brandBlue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AdapertusApp.brandBlue,
          brightness: Brightness.dark,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
