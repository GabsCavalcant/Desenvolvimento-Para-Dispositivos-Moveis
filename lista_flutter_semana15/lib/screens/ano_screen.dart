import 'package:flutter/material.dart';

class Ano {
  bool ehBissexto(int ano) {
    return (ano % 4 == 0 && ano % 100 != 0) || (ano % 400 == 0);
  }
}

class AnoScreen extends StatefulWidget {
  const AnoScreen({super.key});

  @override
  State<AnoScreen> createState() => _AnoScreenState();
}

class _AnoScreenState extends State<AnoScreen> {
  final _anoController = TextEditingController();
  String? _resultado;
  bool? _bissexto;

  void _verificar() {
    final str = _anoController.text.trim();
    final ano = int.tryParse(str);

    if (ano == null || ano <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um ano válido')),
      );
      return;
    }

    final bissexto = Ano().ehBissexto(ano);
    setState(() {
      _bissexto = bissexto;
      _resultado = bissexto
          ? 'O ano $ano É BISSEXTO! 🗓️\n\nPossui 366 dias.'
          : 'O ano $ano NÃO é bissexto.\n\nPossui 365 dias.';
    });
  }

  @override
  Widget build(BuildContext context) {
    const cor = Color(0xFF2E7D32);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 06 — Ano Bissexto'),
        backgroundColor: cor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InfoCard(
              texto: 'Regra: divisível por 4, exceto centenários — salvo os divisíveis por 400.',
              cor: cor,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _anoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ano',
                prefixIcon: Icon(Icons.calendar_today_outlined),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _verificar,
              icon: const Icon(Icons.search),
              label: const Text('Verificar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: cor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            if (_resultado != null) ...[
              const SizedBox(height: 24),
              _ResultadoCard(
                texto: _resultado!,
                cor: _bissexto == true ? cor : const Color(0xFFC62828),
              ),
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