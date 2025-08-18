// lib/login_screen.dart
import 'package:flutter/material.dart';
import 'package:myapp/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Duelo Metabólico',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'A plataforma para mestres da nutrição',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nicknameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Seu Apelido de Nutri',
                  hintText: 'Ex: NutriGlicose',
                  prefixIcon: const Icon(Icons.person, color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF16213E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: const TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final nickname = _nicknameController.text;
                  if (nickname.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DashboardScreen(nickname: nickname),
                      ),
                    );
                  }
                },
                child: const Text('Entrar na Arena'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
