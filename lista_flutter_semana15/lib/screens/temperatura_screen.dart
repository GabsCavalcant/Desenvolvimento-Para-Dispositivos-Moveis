import 'package:flutter/material.dart';

class Temperatura {
  double fahrenheitParaCelsius(double f) {
    return (5.0 / 9.0) * (f - 32);
  }
}

class TemperaturaScreen extends StatefulWidget {
  const TemperaturaScreen({super.key});

  @override
  State<TemperaturaScreen> createState() => _TemperaturaScreenState();
}

class _TemperaturaScreenState extends State<TemperaturaScreen> {
  final _tempController = TextEditingController();
  String? _resultado;

  void _calcular() {
    final str = _tempController.text.trim().replaceAll(',', '.');
    final f = double.tryParse(str);

    if (f == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe uma temperatura válida')),
      );
      return;
    }

    final celsius = Temperatura().fahrenheitParaCelsius(f);
    setState(() {
      _resultado = '${f.toStringAsFixed(1)} °F\n\n'
          '= ${celsius.toStringAsFixed(2)} °C';
    });
  }

  @override
  Widget build(BuildContext context) {
    const cor = Color(0xFFE65100);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 03 — Temperatura'),
        backgroundColor: cor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InfoCard(
              texto: 'Fórmula: °C = (5/9) × (°F − 32)',
              cor: cor,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _tempController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                labelText: 'Temperatura em Fahrenheit',
                prefixIcon: Icon(Icons.thermostat_outlined),
                suffixText: '°F',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _calcular,
              icon: const Icon(Icons.calculate_outlined),
              label: const Text('Converter para Celsius'),
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
            style: TextStyle(fontSize: 16, color: cor, fontWeight: FontWeight.w600, height: 1.6),
          ),
        ],
      ),
    );
  }
}