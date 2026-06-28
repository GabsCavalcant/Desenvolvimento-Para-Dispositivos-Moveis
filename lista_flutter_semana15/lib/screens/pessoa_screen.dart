import 'package:flutter/material.dart';

class Pessoa {
  final int id;
  final String nome;
  final int idade;
  final String genero;

  Pessoa({required this.id, required this.nome, required this.idade, required this.genero});

  String saudar() {
    final tratamento = genero.toLowerCase() == 'feminino' ? 'Sra.' : 'Sr.';
    return 'Olá, $tratamento $nome!\nVocê tem $idade anos.\nSeja muito bem-vindo(a)! 👋';
  }
}

class PessoaScreen extends StatefulWidget {
  const PessoaScreen({super.key});

  @override
  State<PessoaScreen> createState() => _PessoaScreenState();
}

class _PessoaScreenState extends State<PessoaScreen> {
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  String _generoSelecionado = 'Masculino';
  String? _resultado;

  void _calcular() {
    final nome = _nomeController.text.trim();
    final idadeStr = _idadeController.text.trim();

    if (nome.isEmpty || idadeStr.isEmpty) {
      setState(() => _resultado = null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    final idade = int.tryParse(idadeStr);
    if (idade == null || idade < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe uma idade válida')),
      );
      return;
    }

    final pessoa = Pessoa(
      id: 1,
      nome: nome,
      idade: idade,
      genero: _generoSelecionado,
    );

    setState(() => _resultado = pessoa.saudar());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 01 — Pessoa'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InfoCard(
              texto: 'Informe os dados da pessoa para gerar uma saudação personalizada.',
              cor: const Color(0xFF1565C0),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person_outline),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _idadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Idade',
                prefixIcon: Icon(Icons.cake_outlined),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _generoSelecionado,
              decoration: const InputDecoration(
                labelText: 'Gênero',
                prefixIcon: Icon(Icons.wc_outlined),
              ),
              items: ['Masculino', 'Feminino']
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (v) => setState(() => _generoSelecionado = v!),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _calcular,
              icon: const Icon(Icons.waving_hand_outlined),
              label: const Text('Gerar Saudação'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            if (_resultado != null) ...[
              const SizedBox(height: 24),
              _ResultadoCard(texto: _resultado!, cor: const Color(0xFF1565C0)),
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
      child: Text(texto, style: TextStyle(color: cor, fontSize: 13)),
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