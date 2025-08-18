// lib/game_manual_screen.dart

import 'package:flutter/material.dart';

class GameManualScreen extends StatelessWidget {
  const GameManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manual do Jogo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Conceitos Básicos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'O que é o Duelo Metabólico?',
              content:
                  'Um jogo educativo onde nutricionistas competem resolvendo casos clínicos. Você desenvolve estratégias nutricionais completas e ganha pontos pela qualidade da sua abordagem.',
            ),
            const Divider(height: 32, color: Colors.white24),
            _buildSection(
              title: 'Sistema de Progressão',
              content:
                  ' • NutriScore: Pontos ganhos ao completar desafios. \n'
                  ' • Ligas: Suba de nível (Bronze, Prata, Ouro, Platina, Diamante) para enfrentar oponentes mais fortes.',
            ),
            const Divider(height: 32, color: Colors.white24),
            const Text(
              'Modos de Jogo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _buildGameModeCard(
              title: 'Desafio Solo',
              description:
                  'Pratique contra a IA e receba feedback detalhado. Perfeito para aprender.',
              icon: Icons.person_outline,
            ),
            _buildGameModeCard(
              title: 'Duelo Online',
              description:
                  'Enfrente outros nutricionistas do mundo todo em tempo real.',
              icon: Icons.wifi,
            ),
            _buildGameModeCard(
              title: 'Duelo em Rede Local',
              description:
                  'Jogue com amigos na mesma sala. Ideal para aulas e competições.',
              icon: Icons.people_outline,
            ),
            const Divider(height: 32, color: Colors.white24),
            const Text(
              'Poderes Especiais',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _buildPowerCard(
              title: 'Consulta Rápida',
              description:
                  'Revela a jogada do oponente. Desbloqueado no Nível 1.',
              icon: Icons.visibility,
              color: Colors.blueAccent,
            ),
            _buildPowerCard(
              title: 'Névoa Metabólica',
              description:
                  'Oculta os exames do oponente. Desbloqueado no Nível 3.',
              icon: Icons.cloud_off,
              color: Colors.purpleAccent,
            ),
            _buildPowerCard(
              title: 'Furo na Dieta',
              description:
                  'Desabilita uma opção de estratégia do oponente. Desbloqueado no Nível 5.',
              icon: Icons.no_food,
              color: Colors.orangeAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildGameModeCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildPowerCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
