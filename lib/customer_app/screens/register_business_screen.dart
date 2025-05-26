import 'package:flutter/material.dart';

class RegisterBusinessScreen extends StatelessWidget {
  const RegisterBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar mi Negocio'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Página de Registro de Negocio (Placeholder)',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xFF1A202C),
    );
  }
}
