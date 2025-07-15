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

  int _selectedIndex = 0;
  final List<String> _sections = ['Início', 'Funcionalidades', 'Linguagens', 'Parcerias'];

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
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
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
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.code, size: 48, color: Colors.white),
                  SizedBox(height: 12),
                  Text('iCursor', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('O IDE mais inteligente', style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome),
              title: const Text('Funcionalidades'),
              selected: _selectedIndex == 1,
              onTap: () {
                setState(() => _selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Linguagens'),
              selected: _selectedIndex == 2,
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.handshake),
              title: const Text('Parcerias'),
              selected: _selectedIndex == 3,
              onTap: () {
                setState(() => _selectedIndex = 3);
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Versão 1.0.0', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ),
          ],
        ),
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
                  child: Builder(
                    builder: (context) {
                      switch (_selectedIndex) {
                        case 0:
                          // Início
                          return Column(
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
                              const SizedBox(height: 30),
                              // Footer
                              _buildFooter(context),
                            ],
                          );
                        case 1:
                          // Funcionalidades
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                'Funcionalidades',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6366F1),
                                ),
                              ),
                              const SizedBox(height: 20),
                              CursorAIFeatureCards(cardColor: cardColor),
                              const SizedBox(height: 30),
                              _buildFooter(context),
                            ],
                          );
                        case 2:
                          // Linguagens (sem título)
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              CursorAISupportedLanguages(cardColor: cardColor),
                              const SizedBox(height: 30),
                              _buildFooter(context),
                            ],
                          );
                        case 3:
                          // Parcerias
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                'Parcerias',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6366F1),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Logos das parcerias
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _PartnerLogo(
                                    asset: 'assets/languages/openai.png',
                                    name: 'OpenAI',
                                  ),
                                  const SizedBox(width: 24),
                                  _PartnerLogo(
                                    asset: 'assets/languages/simpleicons.png',
                                    name: 'Simple Icons',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              _buildFooter(context),
                            ],
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Divider(thickness: 1, color: Theme.of(context).dividerColor.withOpacity(0.2)),
          const SizedBox(height: 8),
          Text(
            'iCursor © 2024',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Feito com Flutter',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5),
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Parcerias: OpenAI, Simple Icons, Flutter Community',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para exibir logo e nome do parceiro (apenas PNG padrão)
class _PartnerLogo extends StatelessWidget {
  final String asset;
  final String name;
  const _PartnerLogo({required this.asset, required this.name});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              asset,
              color: isDark ? Colors.white : null,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
} 