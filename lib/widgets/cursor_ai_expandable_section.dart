import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CursorAIExpandableSection extends StatefulWidget {
  final Color cardColor;
  const CursorAIExpandableSection({super.key, required this.cardColor});

  @override
  State<CursorAIExpandableSection> createState() => _CursorAIExpandableSectionState();
}

class _CursorAIExpandableSectionState extends State<CursorAIExpandableSection>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  late AnimationController _listController;
  late Animation<double> _listAnimation;

  @override
  void initState() {
    super.initState();
    
    // Controlador de escala
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    // Controlador de bounce
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Controlador de lista
    _listController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Animações
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.bounceOut,
    ));

    _listAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _listController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _bounceController.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _onTap() {
    // Animação de escala
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    // Animação de bounce
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });

    // Feedback tátil
    HapticFeedback.lightImpact();

    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _listController.forward();
    } else {
      _listController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _scaleController,
        _bounceController,
        _listController,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: widget.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05 + (_bounceAnimation.value * 0.03)),
                  blurRadius: 10 + (_bounceAnimation.value * 5),
                  offset: Offset(0, 5 + (_bounceAnimation.value * 2)),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _onTap,
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.0 + (_bounceAnimation.value * 0.1),
                        child: const Icon(Icons.info_outline, color: Color(0xFF6366F1)),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Recursos Avançados',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      AnimatedRotation(
                        turns: _isExpanded ? 0.25 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ],
                  ),
                ),
                if (_isExpanded) ...[
                  const SizedBox(height: 16),
                  AnimatedBuilder(
                    animation: _listAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _listAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - _listAnimation.value)),
                          child: Column(
                            children: [
                              _buildFeatureItem('Chat com IA', 'Converse naturalmente sobre seu código'),
                              _buildFeatureItem('Autocompletar Inteligente', 'Sugestões contextuais avançadas'),
                              _buildFeatureItem('Refatoração Automática', 'Melhore seu código com um clique'),
                              _buildFeatureItem('Debugging Inteligente', 'Encontre bugs mais rapidamente'),
                              _buildFeatureItem('Git Integration', 'Controle de versão integrado'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF6366F1),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 