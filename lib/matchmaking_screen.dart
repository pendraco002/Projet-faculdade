// lib/matchmaking_screen.dart

import 'package:flutter/material.dart';
import 'package:myapp/caso_clinico_model.dart';
import 'package:myapp/casos_clinicos_library.dart';
import 'package:myapp/duel_screen.dart';

class MatchmakingScreen extends StatefulWidget {
  const MatchmakingScreen({super.key});

  @override
  State<MatchmakingScreen> createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends State<MatchmakingScreen> {
  final List<CasoClinico> _casosDisponiveis = casosClinicos;

  void _iniciarDuelo(CasoClinico caso) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DuelScreen(caso: caso)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escolha seu Desafio Solo')),
      body: _casosDisponiveis.isEmpty
          ? const Center(
              child: Text(
                'Nenhum caso disponível no momento.',
                style: TextStyle(fontSize: 18, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _casosDisponiveis.length,
              itemBuilder: (context, index) {
                final caso = _casosDisponiveis[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          caso.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          caso.queixaPrincipal,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _iniciarDuelo(caso),
                          child: const Text('Iniciar Duelo'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
