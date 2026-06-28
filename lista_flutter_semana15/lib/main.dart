import 'package:flutter/material.dart';
import 'screens/pessoa_screen.dart';
import 'screens/volume_screen.dart';
import 'screens/temperatura_screen.dart';
import 'screens/retangulo_screen.dart';
import 'screens/fatorial_screen.dart';
import 'screens/ano_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introdução ao Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Map<String, dynamic>> exercicios = [
    {
      'numero': '01',
      'titulo': 'Pessoa',
      'descricao': 'Saudação personalizada com nome, idade e gênero',
      'icone': Icons.person_outline,
      'cor': const Color(0xFF1565C0),
      'tela': const PessoaScreen(),
    },
    {
      'numero': '02',
      'titulo': 'Volume da Esfera',
      'descricao': 'Calcula o volume de uma esfera a partir do raio',
      'icone': Icons.circle_outlined,
      'cor': const Color(0xFF00695C),
      'tela': const VolumeScreen(),
    },
    {
      'numero': '03',
      'titulo': 'Temperatura',
      'descricao': 'Converte temperatura de Fahrenheit para Celsius',
      'icone': Icons.thermostat_outlined,
      'cor': const Color(0xFFE65100),
      'tela': const TemperaturaScreen(),
    },
    {
      'numero': '04',
      'titulo': 'Retângulo',
      'descricao': 'Calcula a área de um retângulo',
      'icone': Icons.rectangle_outlined,
      'cor': const Color(0xFF6A1B9A),
      'tela': const RetanguloScreen(),
    },
    {
      'numero': '05',
      'titulo': 'Fatorial',
      'descricao': 'Calcula o fatorial de um número inteiro',
      'icone': Icons.functions,
      'cor': const Color(0xFFC62828),
      'tela': const FatorialScreen(),
    },
    {
      'numero': '06',
      'titulo': 'Ano Bissexto',
      'descricao': 'Verifica se um ano é bissexto ou não',
      'icone': Icons.calendar_today_outlined,
      'cor': const Color(0xFF2E7D32),
      'tela': const AnoScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introdução ao Flutter',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Exercícios de Classes',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: exercicios.length,
        itemBuilder: (context, index) {
          final ex = exercicios[index];
          return _ExercicioCard(exercicio: ex);
        },
      ),
    );
  }
}

class _ExercicioCard extends StatelessWidget {
  final Map<String, dynamic> exercicio;

  const _ExercicioCard({required this.exercicio});

  @override
  Widget build(BuildContext context) {
    final Color cor = exercicio['cor'] as Color;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => exercicio['tela'] as Widget),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: cor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(exercicio['icone'] as IconData, color: cor, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Ex ${exercicio['numero']}  ',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: cor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          exercicio['titulo'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exercicio['descricao'] as String,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}