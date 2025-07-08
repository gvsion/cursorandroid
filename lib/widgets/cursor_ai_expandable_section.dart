import 'package:flutter/material.dart';

class CursorAIExpandableSection extends StatefulWidget {
  final Color cardColor;
  const CursorAIExpandableSection({super.key, required this.cardColor});

  @override
  State<CursorAIExpandableSection> createState() => _CursorAIExpandableSectionState();
}

class _CursorAIExpandableSectionState extends State<CursorAIExpandableSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF6366F1)),
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
            _buildFeatureItem('Chat com IA', 'Converse naturalmente sobre seu código'),
            _buildFeatureItem('Autocompletar Inteligente', 'Sugestões contextuais avançadas'),
            _buildFeatureItem('Refatoração Automática', 'Melhore seu código com um clique'),
            _buildFeatureItem('Debugging Inteligente', 'Encontre bugs mais rapidamente'),
            _buildFeatureItem('Git Integration', 'Controle de versão integrado'),
          ],
        ],
      ),
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