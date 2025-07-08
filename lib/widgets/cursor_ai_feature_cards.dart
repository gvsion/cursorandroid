import 'package:flutter/material.dart';

class CursorAIFeatureCards extends StatelessWidget {
  final Color cardColor;
  const CursorAIFeatureCards({super.key, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.auto_awesome,
        'title': 'AI Poderosa',
        'description': 'Assistente de IA integrado para desenvolvimento mais rápido',
        'color': const Color(0xFF10B981),
      },
      {
        'icon': Icons.speed,
        'title': 'Performance',
        'description': 'Velocidade excepcional com Rust e TypeScript',
        'color': const Color(0xFFF59E0B),
      },
      {
        'icon': Icons.psychology,
        'title': 'Inteligente',
        'description': 'Entende contexto e sugere melhorias no código',
        'color': const Color(0xFFEF4444),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: features.map((feature) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: feature['color'] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feature['description'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
} 