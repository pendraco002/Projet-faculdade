// lib/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:myapp/matchmaking_screen.dart';
import 'package:myapp/profile_screen.dart';
import 'package:myapp/game_manual_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String nickname;

  const DashboardScreen({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duelo Metabólico'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu_book),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameManualScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              'Bem-vindo(a), $nickname!',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Escolha seu modo de jogo para começar a duelar.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildGameModeCard(
              context,
              title: 'Entrar na Arena Solo',
              description:
                  'Enfrente a inteligência artificial para praticar suas habilidades.',
              icon: Icons.person_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MatchmakingScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildGameModeCard(
              context,
              title: 'Duelo Online',
              description: 'Enfrente outros nutricionistas em tempo real!',
              icon: Icons.wifi,
              onTap: () {
                // Lógica de matchmaking online
                // A ser implementado futuramente
              },
            ),
            const SizedBox(height: 20),
            _buildGameModeCard(
              context,
              title: 'Duelo em Rede Local',
              description:
                  'Crie uma sala ou entre em uma para jogar com amigos.',
              icon: Icons.people_outline,
              onTap: () {
                // Lógica de duelo em rede local
                // A ser implementado futuramente
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameModeCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
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
