// lib/presentation/screens/duel_screen.dart
import 'package:flutter/material.dart';
import 'package:myapp/core/models/caso_clinico_model.dart';
import 'package:myapp/core/providers/duel_provider.dart';
import 'package:provider/provider.dart';

class DuelScreen extends StatelessWidget {
  final CasoClinico caso;
  const DuelScreen({super.key, required this.caso});

  @override
  Widget build(BuildContext context) {
    // Acessa o DuelProvider que foi registrado no main.dart
    final duelProvider = context.watch<DuelProvider>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(caso.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Seção de Cenário Clínico
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cenário Clínico', style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(caso.detalhesPaciente, style: textTheme.bodyMedium),
                     const SizedBox(height: 16),
                    Text('Objetivos:', style: textTheme.titleMedium),
                     ...caso.objetivos.map((obj) => Text('• $obj', style: textTheme.bodyMedium)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Seção da Estratégia
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text('Sua Estratégia Nutricional', style: textTheme.titleLarge),
                     const SizedBox(height: 16),
                    _buildStrategyTextField(
                      label: 'Plano Nutricional',
                      hint: 'Descreva o plano alimentar, macros, etc...',
                      controller: duelProvider.nutritionPlanController,
                    ),
                    _buildStrategyTextField(
                      label: 'Abordagem Metabólica',
                      hint: 'Explique o raciocínio científico...',
                      controller: duelProvider.metabolicApproachController,
                    ),
                    _buildStrategyTextField(
                      label: 'Suplementos e Complementos',
                      hint: 'Liste suplementos, dosagens, justificativas...',
                      controller: duelProvider.supplementsController,
                    ),
                    _buildStrategyTextField(
                      label: 'Plano de Monitoramento',
                      hint: 'Como você acompanhará a evolução?',
                      controller: duelProvider.monitoringPlanController,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Finalizar Estratégia'),
              onPressed: () {
                // Chama a função do provider para processar os dados
                context.read<DuelProvider>().submitStrategy();
                // Mostra um feedback visual para o usuário
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Estratégia enviada para análise!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para criar os campos de texto padronizados
  Widget _buildStrategyTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}
