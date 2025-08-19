import 'package:flutter/material.dart';

class DuelProvider with ChangeNotifier {
  final TextEditingController nutritionPlanController = TextEditingController();
  final TextEditingController metabolicApproachController = TextEditingController();
  final TextEditingController supplementsController = TextEditingController();
  final TextEditingController monitoringPlanController = TextEditingController();

  // Futuramente, adicionaremos lógica de timer, rodadas, etc.
  
  void submitStrategy() {
    // Esta função será chamada quando o usuário finalizar a estratégia.
    // Por enquanto, apenas imprimimos no console de debug para confirmar.
    debugPrint("--- ESTRATÉGIA SUBMETIDA ---");
    debugPrint("Plano Nutricional: ${nutritionPlanController.text}");
    debugPrint("Abordagem Metabólica: ${metabolicApproachController.text}");
    debugPrint("Suplementos: ${supplementsController.text}");
    debugPrint("Monitoramento: ${monitoringPlanController.text}");
    
    // Aqui, no futuro, chamaremos a Cloud Function.
  }
  
  @override
  void dispose() {
    nutritionPlanController.dispose();
    metabolicApproachController.dispose();
    supplementsController.dispose();
    monitoringPlanController.dispose();
    super.dispose();
  }
}
