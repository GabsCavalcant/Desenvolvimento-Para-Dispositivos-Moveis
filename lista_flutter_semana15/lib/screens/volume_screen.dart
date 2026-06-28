import 'dart:math';
import 'package:flutter/material.dart';

class Volume {
  double calcularEsfera(double raio) {
    return (4.0 / 3.0) * pi * pow(raio, 3);
  }
}

class VolumeScreen extends StatefulWidget {
  const VolumeScreen({super.key});

  @override
  State<VolumeScreen> createState() => _VolumeScreenState();
}

class _VolumeScreenState extends State<VolumeScreen> {
  final _raioController = TextEditingController();
  String? _resultado;

  void _calcular() {
    final raioStr = _raioController.text.trim().replaceAll(',', '.');
    final raio = double.tryParse(raioStr);

    if (raio == null || raio <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um raio válido e maior que zero')),
      );
      return;
    }

    final volume = Volume().calcularEsfera(raio);
    setState(() {
      _resultado = 'Volume = (4/3) × π × ${raio.toStringAsFixed(2)}³\n\n'
          '= ${volume.toStringAsFixed(4)} unidades³';
    });
  }

  @override
  Widget build(BuildContext context) {
    const cor = Color(0xFF00695C);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 02 — Volume da Esfera'),
        backgroundColor: cor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InfoCard(
              texto: 'Fórmula: V = (4/3) × π × r³',
              cor: cor,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _raioController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Raio da esfera',
                prefixIcon: Icon(Icons.circle_outlined),
                suffixText: 'unidades',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _calcular,
              icon: const Icon(Icons.calculate_outlined),
              label: const Text('Calcular Volume'),
              style: ElevatedButton.styleFrom(
                backgroundColor: cor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            if (_resultado != null) ...[
              const SizedBox(height: 24),
              _ResultadoCard(texto: _resultado!, cor: cor),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String texto;
  final Color cor;
  const _InfoCard({required this.texto, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cor.withOpacity(0.2)),
      ),
      child: Text(texto, style: TextStyle(color: cor, fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }
}

class _ResultadoCard extends StatelessWidget {
  final String texto;
  final Color cor;
  const _ResultadoCard({required this.texto, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle_outline, color: cor, size: 32),
          const SizedBox(height: 10),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: cor, fontWeight: FontWeight.w600, height: 1.6),
          ),
        ],
      ),
    );
  }
}