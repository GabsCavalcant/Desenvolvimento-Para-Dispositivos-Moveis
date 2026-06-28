import 'package:flutter/material.dart';

class Fatorial {
  BigInt calcular(int n) {
    if (n < 0) throw ArgumentError('Número deve ser não negativo');
    if (n == 0 || n == 1) return BigInt.one;
    BigInt resultado = BigInt.one;
    for (int i = 2; i <= n; i++) {
      resultado *= BigInt.from(i);
    }
    return resultado;
  }
}

class FatorialScreen extends StatefulWidget {
  const FatorialScreen({super.key});

  @override
  State<FatorialScreen> createState() => _FatorialScreenState();
}

class _FatorialScreenState extends State<FatorialScreen> {
  final _numController = TextEditingController();
  String? _resultado;

  void _calcular() {
    final str = _numController.text.trim();
    final n = int.tryParse(str);

    if (n == null || n < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um número inteiro não negativo')),
      );
      return;
    }

    if (n > 1000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Número muito grande (máx: 1000)')),
      );
      return;
    }

    final fat = Fatorial().calcular(n);
    setState(() {
      _resultado = '$n! = ${fat.toString()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    const cor = Color(0xFFC62828);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 05 — Fatorial'),
        backgroundColor: cor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InfoCard(
              texto: 'Fórmula: n! = n × (n−1) × (n−2) × ... × 1\n0! = 1',
              cor: cor,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _numController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número inteiro',
                prefixIcon: Icon(Icons.functions),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _calcular,
              icon: const Icon(Icons.calculate_outlined),
              label: const Text('Calcular Fatorial'),
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
      child: Text(texto, style: TextStyle(color: cor, fontSize: 13, fontWeight: FontWeight.w600)),
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