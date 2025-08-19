// lib/core/router/app_router.dart

import 'dart:async'; // ADICIONADO para StreamSubscription
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// CORRIGIDO: Esconde a classe 'AuthProvider' do pacote firebase_auth para evitar conflito
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;

import 'package:myapp/core/data/casos_clinicos_library.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:myapp/presentation/screens/dashboard_screen.dart';
import 'package:myapp/presentation/screens/duel_screen.dart';
import 'package:myapp/presentation/screens/login_screen.dart';
import 'package:myapp/presentation/screens/profile_screen.dart';
import 'package:myapp/presentation/screens/matchmaking_screen.dart';
import 'package:myapp/presentation/screens/game_manual_screen.dart';

class AppRouter {
  static final router = GoRouter(
    refreshListenable: _RouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/solo-challenge',
        builder: (context, state) => const MatchmakingScreen(),
      ),
      GoRoute(
        path: '/game-manual',
        builder: (context, state) => const GameManualScreen(),
      ),
      GoRoute(
        path: '/duel/:caseId',
        builder: (context, state) {
          final caseId = state.pathParameters['caseId']!;
          final caso = casosClinicos.firstWhere((c) => c.id == caseId, orElse: () => casosClinicos.first);
          return DuelScreen(caso: caso);
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // Agora, sem ambiguidade, ele sabe que estamos usando nosso AuthProvider
      final authProvider = context.read<AuthProvider>();
      final isLoggedIn = authProvider.status == AuthStatus.authenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/dashboard';
      
      return null;
    },
  );
}

// Classe auxiliar para converter um Stream em um Listenable
class _RouterRefreshStream extends ChangeNotifier {
  _RouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
