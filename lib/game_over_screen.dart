// lib/game_over_screen.dart

import 'package:flutter/material.dart';
import 'package:myapp/login_screen.dart';

class GameOverScreen extends StatelessWidget {
  final bool didWin;

  const GameOverScreen({super.key, required this.didWin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                didWin ? Icons.emoji_events : Icons.sentiment_dissatisfied,
                size: 80,
                color: didWin ? Colors.yellowAccent : Colors.redAccent,
              ),
              const SizedBox(height: 16),
              Text(
                didWin ? 'Vitória!' : 'Derrota!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: didWin ? Colors.yellowAccent : Colors.redAccent,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                didWin
                    ? 'Parabéns, você demonstrou uma excelente estratégia e alcançou os objetivos clínicos!'
                    : 'A estratégia do seu oponente foi mais eficaz. Continue praticando para se tornar um mestre!',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Voltar para o Início'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}