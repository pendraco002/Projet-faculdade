// lib/duel_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:myapp/caso_clinico_model.dart';
import 'package:myapp/round_summary_screen.dart';
import 'package:myapp/game_over_screen.dart';

class DuelScreen extends StatefulWidget {
  final CasoClinico caso;
  const DuelScreen({super.key, required this.caso});

  @override
  State<DuelScreen> createState() => _DuelScreenState();
}

class _DuelScreenState extends State<DuelScreen> {
  String? _feedbackMessage;
  int roundNumber = 1;
  final int maxRounds = 3;
  Map<String, double> examesNumericos = {};
  bool _isNevoaActive = false;
  bool _canUseConsultaRapida = true;
  bool _canUseNuvemMetabolica = true;
  bool _canUseFuroNaDieta = true;
  bool _isFuroNaDietaActive = false;

  @override
  void initState() {
    super.initState();
    _inicializarExames();
  }

  void _inicializarExames() {
    widget.caso.exames.forEach((nomeExame, valorString) {
      final valorNumerico = double.tryParse(valorString.split(' ')[0]) ?? 0.0;
      examesNumericos[nomeExame] = valorNumerico;
    });
  }

  String _formatarExamesParaExibicao() {
    if (_isNevoaActive) {
      return '• Exames ofuscados pela Névoa Metabólica.';
    }
    String textoExames = '';
    widget.caso.exames.forEach((nomeExame, valorOriginal) {
      final valorAtualizado =
          examesNumericos[nomeExame]?.toStringAsFixed(1) ?? 'N/A';
      final unidade = valorOriginal.split(' ').sublist(1).join(' ');
      textoExames += '• $nomeExame: $valorAtualizado $unidade\n';
    });
    return textoExames.trim();
  }

  String _getAvatarImage() {
    double glicemiaAtual = examesNumericos['Glicemia de Jejum'] ?? 130.0;
    if (glicemiaAtual < 100.0) {
      return 'assets/images/saudavel.png';
    } else if (glicemiaAtual <= 125.0) {
      return 'assets/images/neutro.png';
    } else {
      return 'assets/images/enfraquecido.png';
    }
  }

  Future<void> _endRoundSequence({
    String? feedback,
    double glicemiaChange = 0,
    bool consultaRapidaAtivada = false,
    bool ativarNevoaParaProximaRodada = false,
    bool ativarFuroNaDietaParaProximaRodada = false,
  }) async {
    setState(() {
      _feedbackMessage = feedback;
      if (examesNumericos.containsKey('Glicemia de Jejum')) {
        examesNumericos['Glicemia de Jejum'] =
            examesNumericos['Glicemia de Jejum']! + glicemiaChange;
      }
    });

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final startNextRound = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => RoundSummaryScreen(
          mostrarJogadaOponente: consultaRapidaAtivada,
          roundNumber: roundNumber,
        ),
      ),
    );
    if (!mounted) return;

    if (startNextRound == true) {
      if (roundNumber >= maxRounds) {
        bool didWin = (examesNumericos['Glicemia de Jejum'] ?? 1000.0) < 100.0;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GameOverScreen(didWin: didWin),
          ),
        );
      } else {
        setState(() {
          roundNumber++;
          _feedbackMessage = null;
          _isNevoaActive = ativarNevoaParaProximaRodada;
          _isFuroNaDietaActive = ativarFuroNaDietaParaProximaRodada;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final caso = widget.caso;
    return Scaffold(
      appBar: AppBar(
        title: Text('Rodada $roundNumber / $maxRounds'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(_getAvatarImage()),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paciente: ${caso.title}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        caso.detalhesPaciente,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 40, color: Colors.white24),
            const Text(
              'Queixa Principal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              caso.queixaPrincipal,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            const Text(
              'Exames Bioquímicos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatarExamesParaExibicao(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const Divider(height: 40, color: Colors.white24),
            const Text(
              'Objetivo do Duelo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE94560),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: caso.objetivos
                  .map(
                    (obj) => Text(
                      '• $obj',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.book, color: Colors.orangeAccent, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Referência Bibliográfica',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          caso.referencia,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 40, color: Colors.white24),
            const Text(
              'Poderes Especiais (1 uso por duelo)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 30),
                  color: _canUseConsultaRapida
                      ? Colors.blueAccent
                      : Colors.grey,
                  tooltip: 'Consulta Rápida',
                  onPressed: _canUseConsultaRapida
                      ? () {
                          setState(() => _canUseConsultaRapida = false);
                          _endRoundSequence(
                            feedback:
                                "Poder 'Consulta Rápida' ativado! Você verá a jogada do oponente.",
                            consultaRapidaAtivada: true,
                          );
                        }
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.cloud_off, size: 30),
                  color: _canUseNuvemMetabolica
                      ? Colors.purpleAccent
                      : Colors.grey,
                  tooltip: 'Névoa Metabólica',
                  onPressed: _canUseNuvemMetabolica
                      ? () {
                          setState(() => _canUseNuvemMetabolica = false);
                          _endRoundSequence(
                            feedback: "Poder 'Névoa Metabólica' ativado!",
                            ativarNevoaParaProximaRodada: true,
                          );
                        }
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.no_food, size: 30),
                  color: _canUseFuroNaDieta ? Colors.orangeAccent : Colors.grey,
                  tooltip: 'Furo na Dieta',
                  onPressed: _canUseFuroNaDieta
                      ? () {
                          setState(() => _canUseFuroNaDieta = false);
                          _endRoundSequence(
                            feedback: "Poder 'Furo na Dieta' ativado!",
                            ativarFuroNaDietaParaProximaRodada: true,
                          );
                        }
                      : null,
                ),
              ],
            ),
            const Divider(height: 40, color: Colors.white24),
            const Text(
              'Sua Ação para esta Rodada:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            if (_feedbackMessage == null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _isFuroNaDietaActive
                        ? null
                        : () => _endRoundSequence(
                            feedback: 'Sua escolha: Foco em Macronutrientes.',
                            glicemiaChange: -10.0,
                          ),
                    child: const Text('Foco em Macronutrientes'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _endRoundSequence(
                      feedback: 'Sua escolha: Foco em Micronutrientes.',
                    ),
                    child: const Text('Foco em Micronutrientes'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _endRoundSequence(
                      feedback: 'Sua escolha: Foco em Estilo de Vida.',
                      glicemiaChange: -5.0,
                    ),
                    child: const Text('Foco em Estilo de Vida'),
                  ),
                ],
              )
            else
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF16213E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  _feedbackMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
