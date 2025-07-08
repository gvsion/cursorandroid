import 'package:flutter/material.dart';

class CursorAISupportedLanguages extends StatelessWidget {
  final Color cardColor;
  const CursorAISupportedLanguages({super.key, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    final languages = [
      {
        'name': 'Python',
        'icon': Icons.code,
        'color': const Color(0xFF3572A5),
        'description': 'Muito usado em IA, ciência de dados, web e automação.'
      },
      {
        'name': 'JavaScript',
        'icon': Icons.javascript,
        'color': const Color(0xFFF7DF1E),
        'description': 'A linguagem da web, essencial para front-end e back-end.'
      },
      {
        'name': 'TypeScript',
        'icon': Icons.code,
        'color': const Color(0xFF3178C6),
        'description': 'JavaScript com tipagem estática, mais seguro e robusto.'
      },
      {
        'name': 'Java',
        'icon': Icons.coffee,
        'color': const Color(0xFFB07219),
        'description': 'Popular em aplicações corporativas, Android e backend.'
      },
      {
        'name': 'C#',
        'icon': Icons.code,
        'color': const Color(0xFF178600),
        'description': 'Muito usado em aplicações Windows, jogos (Unity) e web.'
      },
      {
        'name': 'C++',
        'icon': Icons.memory,
        'color': const Color(0xFFF34B7D),
        'description': 'Performance máxima para sistemas, jogos e aplicações críticas.'
      },
      {
        'name': 'Go',
        'icon': Icons.directions_run,
        'color': const Color(0xFF00ADD8),
        'description': 'Simples, eficiente e ideal para sistemas distribuídos.'
      },
      {
        'name': 'Rust',
        'icon': Icons.security,
        'color': const Color(0xFFDEA584),
        'description': 'Segurança e performance para sistemas modernos.'
      },
      {
        'name': 'Dart',
        'icon': Icons.flutter_dash,
        'color': const Color(0xFF00B4AB),
        'description': 'Linguagem do Flutter, ideal para apps multiplataforma.'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Linguagens Suportadas',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6366F1),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: languages.map((lang) {
            return Container(
              width: 170,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: lang['color'] as Color,
                    radius: 22,
                    child: Icon(
                      lang['icon'] as IconData,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    lang['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lang['description'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
} 