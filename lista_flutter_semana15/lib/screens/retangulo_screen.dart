
import 'package:flutter/material.dart';

class Retangulo {
  double calcularArea(double base, double altura) {
    return base * altura;
  }
}

class RetanguloScreen extends StatefulWidget {
  const RetanguloScreen({super.key});

  @override
  State<RetanguloScreen> createState() => _RetanguloScreenState();
}

class _RetanguloScreenState extends State<RetanguloScreen> {
  final _baseController = TextEditingController();
  final _alturaController = TextEditingController();
  String? _resultado;

  void _calcular() {
    final baseStr = _baseController.text.trim().replaceAll(',', '.');
    final alturaStr = _alturaController.text.trim().replaceAll(',', '.');
    final base = double.tryParse(baseStr);
    final altura = double.tryParse(alturaStr);

    if (base == null || altura == null || base <= 0 || altura <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe valores válidos para base e altura')),
      );
      return;
    }

    final area = Retangulo().calcularArea(base, altura);
    setState(() {
      _resultado = 'Área = base × altura\n\n'
          '= ${base.toStringAsFixed(2)} × ${altura.toStringAsFixed(2)}\n\n'
          '= ${area.toStringAsFixed(4)} unidades²';
    });
  }

  @override
  Widget build(BuildContext context) {
    const cor = Color(0xFF6A1B9A);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 04 — Retângulo'),
        backgroundColor: cor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InfoCard(texto: 'Fórmula: Área = base × altura', cor: cor),
            const SizedBox(height: 24),
            TextField(
              controller: _baseController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Base',
                prefixIcon: Icon(Icons.straighten),
                suffixText: 'unidades',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _alturaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Altura',
                prefixIcon: Icon(Icons.height),
                suffixText: 'unidades',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _calcular,
              icon: const Icon(Icons.calculate_outlined),
              label: const Text('Calcular Área'),
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