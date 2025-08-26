import 'package:adapertus_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'settings_screen.dart';
//import 'profile_screen.dart';

void main() => runApp(const AdapertusApp());

// configuration de l'application : thème (couleurs, styles), page d'accueil
class AdapertusApp extends StatelessWidget {
  const AdapertusApp({super.key});

  // Couleurs de la marque
  static const Color brandBlue = Color(0xFF0B3163);
  static const Color brandBg = Color(0xFFF2F3F5);

  @override
  // configuration de la page d'accueil
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adapertus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: brandBg,
        // configuration des cartes
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0, // pas d'ombres
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardTheme: CardThemeData(
          color: const Color(0xFF1F2125),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const LoginScreen(), // configuration de la première page de l'appli
    );
  }
}

// modèle de données qui représente un service
class ServiceItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool locked;
  // constructeur
  const ServiceItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.locked = false,
  });
}

// écran principal qui change en fonction de l’onglet sélectionné dans la barre de navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // création de l'état de la page home_screen
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 1; // permet de savoir sur quel onglet on est : 0 = Paramètres, 1 = Services, 2 = Profil.

  //------------------------------------------n'a rien à voir avec la disposition de la page----------------//
  // liste provisoire des services (à récupérer via Supabase)
  final List<ServiceItem> services = const [
    ServiceItem(
      id: 'manager',
      title: 'Assistant du Manager',
      subtitle: "L’assistant vocal/texte pour managers disponible 24/7",
      icon: Icons.my_location_outlined,
    ),
    ServiceItem(
      id: 'rh_cvs',
      title: 'Assistant RH – CVs',
      subtitle: "Analyse des CVs et interrogation vocale",
      icon: Icons.engineering_outlined,
    ),
    ServiceItem(
      id: 'verif',
      title: 'Vérificateur de conformité',
      subtitle: "Vérification de documents officiels",
      icon: Icons.verified_user_outlined,
    ),
    ServiceItem(
      id: 'kb',
      title: 'Base de connaissances',
      subtitle: "Chatbot pour interroger sa base de fichiers",
      icon: Icons.hub_outlined,
    ),
    ServiceItem(
      id: 'service_locked',
      title: 'Service supplémentaire',
      subtitle: "Réservé — contactez votre administrateur",
      icon: Icons.extension_outlined,
      locked: true,
    ),
  ];

  // méthode qui renvoie l’écran à afficher selon l’onglet sélectionné
  Widget _buildBody() {
    switch (_tabIndex) {
      case 0:
        return const SettingsScreen();
      case 1:
        return _buildServices();
      case 2:
        return const ProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }
  //------------------------------------------fin de n'a rien à voir avec la disposition de la page----------------//

  //-----------------------------méthode qui construit l'écran des services------------------------------------//
  Widget _buildServices() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AdapertusApp.brandBlue,
          pinned: true,
          expandedHeight: 160,
          automaticallyImplyLeading: false,
          titleSpacing: 16,
          title: Row(
            children: [
              Image.asset('assets/logo.png', height: 28),
              const SizedBox(width: 12),
              const Text(
                'Adapertus',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .2,
                ),
              ),
            ],
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 26,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF121212) : AdapertusApp.brandBg,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
            child: Text(
              'Bienvenue, Floriane 👋',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                  ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = services[index];
                return ServiceCard(
                  item: item,
                  // action qui se produit quand on clique sur un service (à modifier par les bonnes actions)
                  onTap: item.locked
                      ? null
                      : () => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Ouverture : ${item.title}')),
                          ),
                );
              },
              childCount: services.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 210,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
          ),
        ),
      ],
    );
  }
  //-----------------------------fin méthode qui construit l'écran des services------------------------------------//

  // suite de la construction de l'écran principal
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: _buildBody(), // l'écran sélectionné
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BottomNavigationBar(
            currentIndex: _tabIndex,
            onTap: (i) => setState(() => _tabIndex = i),
            backgroundColor: isDark ? const Color(0xFF121212) : AdapertusApp.brandBg,
            selectedItemColor: AdapertusApp.brandBlue,
            unselectedItemColor: Colors.black54,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
              BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Services'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
            ],
          ),
        ),
      ),
    );
  }
}

// carte de service individuelle
class ServiceCard extends StatelessWidget {
  final ServiceItem item;
  final VoidCallback? onTap;

  const ServiceCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isLocked = item.locked;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark ? const Color(0xFF1F2125) : Colors.white;
    final titleColor = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);
    final subtitleColor = isDark ? const Color(0xFFCBD5E1) : const Color(0xFF6B7280);

    final card = Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icône dans un cercle bleu
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AdapertusApp.brandBlue,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                isLocked ? Icons.lock_outline : item.icon,
                color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                  height: 1.2,
                  color: titleColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.25,
                color: subtitleColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );

    return Opacity(
      opacity: isLocked ? 0.45 : 1,
      child: Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: isLocked ? null : onTap,
                child: card,
              ),
            ),
          ),
          if (isLocked)
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF374151) : const Color(0xFF111827).withOpacity(.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Verrouillé',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFFF1F5F9) : null,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
