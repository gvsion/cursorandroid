import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CursorAISupportedLanguages extends StatelessWidget {
  final Color cardColor;
  const CursorAISupportedLanguages({super.key, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    final languages = [
      {
        'name': 'Python',
        'asset': 'assets/languages/python.svg',
        'description': 'Muito usado em IA, ciência de dados, web e automação.'
      },
      {
        'name': 'JavaScript',
        'asset': 'assets/languages/javascript.svg',
        'description': 'A linguagem da web, essencial para front-end e back-end.'
      },
      {
        'name': 'TypeScript',
        'asset': 'assets/languages/typescript.svg',
        'description': 'JavaScript com tipagem estática, mais seguro e robusto.'
      },
      {
        'name': 'Java',
        'asset': 'assets/languages/java.svg',
        'description': 'Popular em aplicações corporativas, Android e backend.'
      },
      {
        'name': 'C#',
        'asset': 'assets/languages/csharp.svg',
        'description': 'Muito usado em aplicações Windows, jogos (Unity) e web.'
      },
      {
        'name': 'C++',
        'asset': 'assets/languages/cpp.svg',
        'description': 'Performance máxima para sistemas, jogos e aplicações críticas.'
      },
      {
        'name': 'Go',
        'asset': 'assets/languages/go.svg',
        'description': 'Simples, eficiente e ideal para sistemas distribuídos.'
      },
      {
        'name': 'Rust',
        'asset': 'assets/languages/rust.svg',
        'description': 'Segurança e performance para sistemas modernos.'
      },
      {
        'name': 'Dart',
        'asset': 'assets/languages/dart.svg',
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
              width: 110,
              padding: const EdgeInsets.all(10),
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
                  SvgPicture.asset(
                    lang['asset'] as String,
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lang['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    lang['description'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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