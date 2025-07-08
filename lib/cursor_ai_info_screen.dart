import 'package:flutter/material.dart';
import 'widgets/cursor_ai_header.dart';
import 'widgets/cursor_ai_feature_cards.dart';
import 'widgets/cursor_ai_supported_languages.dart';
import 'widgets/cursor_ai_expandable_section.dart';
import 'widgets/cursor_ai_interactive_demo.dart';

class CursorAIInfoScreen extends StatefulWidget {
  final void Function(ThemeMode)? onThemeChanged;
  final ThemeMode? currentThemeMode;

  const CursorAIInfoScreen({super.key, this.onThemeChanged, this.currentThemeMode});

  @override
  State<CursorAIInfoScreen> createState() => _CursorAIInfoScreenState();
}

class _CursorAIInfoScreenState extends State<CursorAIInfoScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isExpanded = false;

  Color get cardColor {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white.withOpacity(0.08) : Colors.white;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (widget.onThemeChanged != null && widget.currentThemeMode != null)
            PopupMenuButton<ThemeMode>(
              icon: Icon(
                widget.currentThemeMode == ThemeMode.dark
                    ? Icons.dark_mode
                    : widget.currentThemeMode == ThemeMode.light
                        ? Icons.light_mode
                        : Icons.brightness_auto,
              ),
              tooltip: 'Tema',
              onSelected: widget.onThemeChanged,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: ThemeMode.system,
                  child: Row(
                    children: const [
                      Icon(Icons.brightness_auto, size: 18),
                      SizedBox(width: 8),
                      Text('Sistema'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: ThemeMode.light,
                  child: Row(
                    children: const [
                      Icon(Icons.light_mode, size: 18),
                      SizedBox(width: 8),
                      Text('Claro'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: ThemeMode.dark,
                  child: Row(
                    children: const [
                      Icon(Icons.dark_mode, size: 18),
                      SizedBox(width: 8),
                      Text('Escuro'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CursorAIHeader(),
                      const SizedBox(height: 30),
                      CursorAIFeatureCards(cardColor: cardColor),
                      const SizedBox(height: 30),
                      CursorAISupportedLanguages(cardColor: cardColor),
                      const SizedBox(height: 30),
                      CursorAIExpandableSection(cardColor: cardColor),
                      const SizedBox(height: 30),
                      CursorAIInteractiveDemo(cardColor: cardColor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 