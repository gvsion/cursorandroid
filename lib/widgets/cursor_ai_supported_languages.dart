import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CursorAISupportedLanguages extends StatefulWidget {
  final Color cardColor;
  const CursorAISupportedLanguages({super.key, required this.cardColor});

  @override
  State<CursorAISupportedLanguages> createState() => _CursorAISupportedLanguagesState();
}

class _CursorAISupportedLanguagesState extends State<CursorAISupportedLanguages>
    with TickerProviderStateMixin {
  late Map<String, AnimationController> _animationControllers;
  late Map<String, Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationControllers = {};
    _scaleAnimations = {};

    final languages = [
      'Python', 'JavaScript', 'TypeScript', 'Java', 'C#', 'C++', 'Go', 'Rust', 'Dart'
    ];

    for (String lang in languages) {
      _animationControllers[lang] = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );
      
      _scaleAnimations[lang] = Tween<double>(
        begin: 1.0,
        end: 0.95,
      ).animate(CurvedAnimation(
        parent: _animationControllers[lang]!,
        curve: Curves.easeInOut,
      ));
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onCardTap(String languageName) {
    final controller = _animationControllers[languageName];
    if (controller != null) {
      controller.forward().then((_) {
        controller.reverse();
      });
    }
    
    // Feedback tátil
    HapticFeedback.lightImpact();
    // Removido: Mostrar snackbar com informação da linguagem
  }

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
            return AnimatedLanguageCard(
              language: lang,
              cardColor: widget.cardColor,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class AnimatedLanguageCard extends StatelessWidget {
  final Map<String, String> language;
  final Color cardColor;

  const AnimatedLanguageCard({
    super.key,
    required this.language,
    required this.cardColor,
  });

  void _onTap(BuildContext context) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) => _LanguageDetailSheet(language: language),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _onTap(context),
      child: Container(
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
              language['asset'] as String,
              width: 32,
              height: 32,
            ),
            const SizedBox(height: 8),
            Text(
              language['name'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              language['description'] as String,
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
      ),
    );
  }
}

// BottomSheet de detalhes da linguagem
class _LanguageDetailSheet extends StatelessWidget {
  final Map<String, String> language;
  const _LanguageDetailSheet({required this.language});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Drag handle visual
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                language['name'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SvgPicture.asset(
                language['asset'] ?? '',
                width: 64,
                height: 64,
                color: isDark ? Colors.white : null,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  language['description'] ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
} 