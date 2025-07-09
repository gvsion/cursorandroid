import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CursorAIInteractiveDemo extends StatefulWidget {
  final Color cardColor;
  const CursorAIInteractiveDemo({super.key, required this.cardColor});

  @override
  State<CursorAIInteractiveDemo> createState() => _CursorAIInteractiveDemoState();
}

class _CursorAIInteractiveDemoState extends State<CursorAIInteractiveDemo>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _buttonGlowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _buttonGlowAnimation;

  @override
  void initState() {
    super.initState();
    
    // Controlador de escala
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    // Controlador de pulso
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Controlador de brilho do botão
    _buttonGlowController = AnimationController(
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

    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _buttonGlowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonGlowController,
      curve: Curves.easeInOut,
    ));

    // Iniciar animação de pulso
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    _buttonGlowController.dispose();
    super.dispose();
  }

  void _onTap() {
    // Animação de escala
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    // Animação de brilho do botão
    _buttonGlowController.forward().then((_) {
      _buttonGlowController.reverse();
    });

    // Feedback tátil
    HapticFeedback.mediumImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Redirecionando para cursor.sh...'),
        backgroundColor: Color(0xFF6366F1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _scaleController,
        _pulseController,
        _buttonGlowController,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.cardColor,
                  widget.cardColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF6366F1).withOpacity(0.2 + (_pulseAnimation.value * 0.1)),
                width: 1 + (_pulseAnimation.value * 0.5),
              ),
            ),
            child: Column(
              children: [
                Transform.scale(
                  scale: 1.0 + (_pulseAnimation.value * 0.02),
                  child: const Text(
                    'Experimente o Cursor AI',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Baixe gratuitamente e descubra como a IA pode transformar sua experiência de desenvolvimento.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3 * _buttonGlowAnimation.value),
                          blurRadius: 8 + (_buttonGlowAnimation.value * 8),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: null, // Desabilitado pois o GestureDetector cuida do tap
                      icon: const Icon(Icons.download),
                      label: const Text('Baixar Cursor AI'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 