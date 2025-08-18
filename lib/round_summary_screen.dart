// lib/round_summary_screen.dart

import 'package:flutter/material.dart';

class RoundSummaryScreen extends StatelessWidget {
  final bool mostrarJogadaOponente;
  final int roundNumber;

  const RoundSummaryScreen({
    super.key,
    required this.mostrarJogadaOponente,
    required this.roundNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rodada $roundNumber Concluída'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Fim da Rodada!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (mostrarJogadaOponente)
                const Text(
                  'Você utilizou "Consulta Rápida". A jogada do oponente foi: Foco em Macronutrientes.',
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true); // Retorna 'true' para a tela anterior
                },
                child: const Text('Próxima Rodada'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}