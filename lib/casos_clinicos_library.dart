// lib/casos_clinicos_library.dart

import 'package:myapp/caso_clinico_model.dart';

List<CasoClinico> casosClinicos = [
  CasoClinico(
    id: 'caso-1',
    title: 'Síndrome Metabólica em Adulto Jovem',
    queixaPrincipal:
        'Paciente de 28 anos, programador, com ganho de peso progressivo nos últimos 3 anos.',
    detalhesPaciente:
        'Homem, 28 anos, 95kg, 175cm. Sedentário, dieta rica em ultraprocessados.',
    exames: {
      'Glicemia de Jejum': '140 mg/dL',
      'Triglicerídeos': '280 mg/dL',
      'HDL': '32 mg/dL',
      'Pressão Arterial': '140/90 mmHg',
    },
    objetivos: [
      'Reduzir peso corporal em 10-15%',
      'Normalizar perfil glicêmico e lipídico',
      'Implementar hábitos alimentares sustentáveis',
      'Melhorar composição corporal',
    ],
    referencia:
        'Alberti KG, et al. Harmonizing the metabolic syndrome: a joint interim statement. Circulation. 2009;120(16):1640-5.',
    dificuldade: 'intermediario',
    categoria: 'metabolismo',
  ),
  CasoClinico(
    id: 'caso-2',
    title: 'Nutrição Esportiva - Corredor de Maratona',
    queixaPrincipal:
        'Corredora amadora de 35 anos se preparando para sua primeira maratona em 16 semanas.',
    detalhesPaciente:
        'Mulher, 35 anos, 60kg, 165cm. Treina 6x/semana, com volume semanal de 60km. Queixa-se de fadiga muscular excessiva.',
    exames: {
      'Ferritina': '15 ng/mL',
      'Creatina Quinase (CK)': '350 U/L',
      'Vitamina D': '18 ng/mL',
    },
    objetivos: [
      'Otimizar a periodização nutricional para os treinos',
      'Prevenir lesões e fadiga muscular',
      'Aumentar as reservas de glicogênio muscular',
      'Corrigir deficiências de micronutrientes',
    ],
    referencia:
        'Thomas DT, et al. American College of Sports Medicine, Academy of Nutrition and Dietetics, and Dietitians of Canada: Joint Position Statement—Nutrition and Athletic Performance. Med Sci Sports Exerc. 2016;48(3):543-68.',
    dificuldade: 'avancado',
    categoria: 'esportiva',
  ),
  CasoClinico(
    id: 'caso-3',
    title: 'Alimentação Complementar - Bebê 6 meses',
    queixaPrincipal:
        'Bebê de 6 meses, em aleitamento materno exclusivo, pronta para iniciar alimentação complementar.',
    detalhesPaciente:
        'Bebê, 6 meses, 7kg, 68cm. Ganho de peso e desenvolvimento neuropsicomotor adequados. Mãe ansiosa e com muitas dúvidas sobre o processo.',
    exames: {},
    objetivos: [
      'Apresentar novos alimentos de forma segura e gradual',
      'Garantir a oferta adequada de ferro',
      'Ensinar os pais sobre sinais de prontidão e métodos de oferta',
      'Promover a aceitação de uma variedade de sabores e texturas',
    ],
    referencia:
        'Sociedade Brasileira de Pediatria. Manual de Alimentação do Lactente, Criança Maior, Adolescente e na Escola. 4ª ed. Rio de Janeiro: SBP, 2018.',
    dificuldade: 'iniciante',
    categoria: 'pediatria',
  ),
];
