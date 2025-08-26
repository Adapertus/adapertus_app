import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF2F3F5);
    final cardColor = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[700];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Row(
                children: [
                  Image.asset('assets/logo.png', height: 28),
                  const SizedBox(width: 12),
                  Text(
                    'Adapertus',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: .2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Photo et nom
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/avatar.jpg'), // à remplacer par la vraie image utilisateur
              ),
              const SizedBox(height: 16),
              Text(
                'Flavie Dupont',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'flavie.dupont@email.com',
                style: TextStyle(
                  fontSize: 14,
                  color: subtitleColor,
                ),
              ),

              const SizedBox(height: 32),

              // Menu
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Informations personnelles'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        debugPrint("Infos personnelles");
                      },
                    ),
                    const Divider(height: 0),
                    ListTile(
                      title: const Text('Changer mot de passe'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        debugPrint("Changer mot de passe");
                      },
                    ),
                    const Divider(height: 0),
                    ListTile(
                      title: const Text('Déconnexion'),
                      trailing: const Icon(Icons.logout),
                      onTap: () {
                        debugPrint("Deconnexion");
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
