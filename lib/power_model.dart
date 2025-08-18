// lib/power_model.dart

import 'package:flutter/material.dart';

class Power {
  final String id;
  final String name;
  final String description;
  final int cost;
  final int levelRequired;
  final IconData icon;
  final Color color;

  Power({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.levelRequired,
    required this.icon,
    required this.color,
  });
}

final List<Power> allPowers = [
  Power(
    id: 'consulta_rapida',
    name: 'Consulta Rápida',
    description: 'Revela a jogada do oponente na próxima rodada.',
    cost: 25,
    levelRequired: 1,
    icon: Icons.visibility,
    color: Colors.blueAccent,
  ),
  Power(
    id: 'nevoa_metabolica',
    name: 'Névoa Metabólica',
    description: 'Oculta os exames do paciente para o oponente por uma rodada.',
    cost: 30,
    levelRequired: 3,
    icon: Icons.cloud_off,
    color: Colors.purpleAccent,
  ),
  Power(
    id: 'furo_na_dieta',
    name: 'Furo na Dieta',
    description:
        'Desabilita temporariamente uma opção de estratégia do oponente.',
    cost: 35,
    levelRequired: 5,
    icon: Icons.no_food,
    color: Colors.orangeAccent,
  ),
];
