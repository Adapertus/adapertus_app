import 'package:flutter/material.dart';
import 'package:adapertus_app/main.dart'; // ← pour accéder à AdapertusApp.of(context)

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = false;
  bool isDarkMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Récupérer le thème actuel pour afficher le bon bouton sélectionné
    final appState = AdapertusApp.of(context);
    if (appState != null) {
      setState(() {
        isDarkMode = appState.isDarkMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF2F3F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Image.asset('assets/logo.png', height: 28),
                  const SizedBox(width: 12),
                  Text(
                    'Adapertus',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: .2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Text(
                'Paramètres',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0B3163),
                ),
              ),
              const SizedBox(height: 20),

              // Notifications
              _buildCard(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.notifications, color: Color(0xFF0B3163)),
                          SizedBox(width: 10),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: notificationsEnabled,
                        activeThumbColor: const Color(0xFF0B3163),
                        onChanged: (val) {
                          setState(() => notificationsEnabled = val);
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Apparence
              _buildCard(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.palette_outlined, color: Color(0xFF0B3163)),
                      SizedBox(width: 10),
                      Text(
                        'Apparence de l’application',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildAppearanceButton('Clair', !isDarkMode),
                      const SizedBox(width: 8),
                      _buildAppearanceButton('Sombre', isDarkMode),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 16),

              // Support
              _buildCard(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFF0B3163)),
                      SizedBox(width: 10),
                      Text(
                        'Support & Aide',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSupportLink('Contacter le support'),
                  _buildSupportLink('FAQ'),
                  _buildSupportLink('Conditions d’utilisation'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildAppearanceButton(String label, bool selected) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? const Color(0xFF0B3163) : const Color(0xFFE6E6E6),
          foregroundColor: selected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          final dark = label == 'Sombre';
          setState(() => isDarkMode = dark);
          AdapertusApp.of(context)?.toggleTheme(dark);
        },
        child: Text(label),
      ),
    );
  }

  Widget _buildSupportLink(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      onTap: () {
        debugPrint("Ouverture de : $title");
      },
    );
  }
}
