// lib/profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/power_model.dart'; // Importando o novo arquivo

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String _nickname = 'Nutri';
  String _specialty = 'Nutrição Clínica';
  Color _avatarColor = const Color(0xFFE94560);
  final List<Color> _availableColors = [
    const Color(0xFFE94560),
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.cyanAccent,
  ];

  // Dados fictícios para demonstração
  int _level = 2;
  int _nutriScore = 150;
  int _wins = 5;
  int _losses = 2;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: _avatarColor,
                    backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                    child: _imageFile == null
                        ? Text(
                            _nickname.isNotEmpty ? _nickname[0].toUpperCase() : '?',
                            style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        : null,
                  ),
                  if (_imageFile != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: _removeImage,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galeria'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Câmera'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                _nickname,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Nível $_level | $_nutriScore XP',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Vitórias', _wins, Colors.greenAccent),
                _buildStatCard('Derrotas', _losses, Colors.redAccent),
              ],
            ),
            const Divider(height: 40, color: Colors.white24),
            const Text(
              'Editar Perfil',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('Apelido do Nutricionista', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: _nickname),
              onChanged: (value) => setState(() => _nickname = value),
              decoration: const InputDecoration(
                hintText: 'Seu apelido de nutricionista',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Especialidade', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _specialty,
              items: ['Nutrição Clínica', 'Nutrição Esportiva']
                  .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _specialty = value);
                }
              },
            ),
            const SizedBox(height: 24),
            const Text('Cor do Avatar', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _availableColors.map((color) {
                return GestureDetector(
                  onTap: () => setState(() => _avatarColor = color),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: color,
                    child: _avatarColor == color
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Perfil atualizado com sucesso!')),
                );
              },
              child: const Text('Salvar Alterações'),
            ),
            const Divider(height: 40, color: Colors.white24),
            const Text(
              'Arsenal de Poderes',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allPowers.length,
              itemBuilder: (context, index) {
                final power = allPowers[index];
                bool isUnlocked = _level >= power.levelRequired;
                return Opacity(
                  opacity: isUnlocked ? 1.0 : 0.5,
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: ListTile(
                      leading: Icon(power.icon, color: power.color),
                      title: Text(power.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(power.description),
                      trailing: isUnlocked
                          ? const Icon(Icons.lock_open, color: Colors.green)
                          : Text('Nível ${power.levelRequired}'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, int value, Color color) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}