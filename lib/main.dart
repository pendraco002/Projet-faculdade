// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:myapp/core/providers/duel_provider.dart';
import 'package:myapp/core/providers/theme_provider.dart';
import 'package:myapp/core/router/app_router.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const DueloMetabolicoApp());
}

class DueloMetabolicoApp extends StatelessWidget {
  const DueloMetabolicoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DuelProvider()),
      ],
      // O MaterialApp.router agora é construído diretamente.
      // O GoRouter, configurado separadamente, irá ler o estado do AuthProvider
      // a partir do context quando precisar.
      child: MaterialApp.router(
        title: 'Duelo Metabólico',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router, // Usando a configuração estática do router
      ),
    );
  }
}
