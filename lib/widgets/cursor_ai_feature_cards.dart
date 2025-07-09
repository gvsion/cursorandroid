import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CursorAIFeatureCards extends StatefulWidget {
  final Color cardColor;
  const CursorAIFeatureCards({super.key, required this.cardColor});

  @override
  State<CursorAIFeatureCards> createState() => _CursorAIFeatureCardsState();
}

class _CursorAIFeatureCardsState extends State<CursorAIFeatureCards>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _elevationAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationControllers = [];
    _scaleAnimations = [];
    _elevationAnimations = [];

    for (int i = 0; i < 3; i++) {
      _animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ));
      
      _scaleAnimations.add(Tween<double>(
        begin: 1.0,
        end: 0.98,
      ).animate(CurvedAnimation(
        parent: _animationControllers[i],
        curve: Curves.easeInOut,
      )));
      
      _elevationAnimations.add(Tween<double>(
        begin: 5.0,
        end: 15.0,
      ).animate(CurvedAnimation(
        parent: _animationControllers[i],
        curve: Curves.easeInOut,
      )));
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onCardTap(int index, String title) {
    final controller = _animationControllers[index];
    controller.forward().then((_) {
      controller.reverse();
    });
    
    // Feedback tátil
    HapticFeedback.mediumImpact();
    // Removido: Mostrar snackbar com informação da feature
  }

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
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;
        final scaleAnimation = _scaleAnimations[index];
        final elevationAnimation = _elevationAnimations[index];
        
        return AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) {
            return AnimatedBuilder(
              animation: elevationAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: scaleAnimation.value,
                  child: GestureDetector(
                    onTap: () => _onCardTap(index, feature['title'] as String),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: widget.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: elevationAnimation.value,
                            offset: Offset(0, elevationAnimation.value / 3),
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
                    ),
                  ),
                );
              },
            );
          },
        );
      }).toList(),
    );
  }
} 