import 'package:flutter/material.dart';

class BecomeCourierScreen extends StatelessWidget {
  const BecomeCourierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ser Courier Andafast'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Página para Convertirse en Courier (Placeholder)',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xFF1A202C),
    );
  }
}
