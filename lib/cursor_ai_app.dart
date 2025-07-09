import 'package:flutter/material.dart';
import 'cursor_ai_info_screen.dart';

final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

class CursorAIApp extends StatelessWidget {
  const CursorAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Cursor AI Info',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6366F1),
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color(0xFFF8FAFC),
            useMaterial3: true,
            fontFamily: 'Roboto Mono',
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6366F1),
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF181A20),
            useMaterial3: true,
            fontFamily: 'Roboto Mono',
          ),
          themeMode: mode,
          home: CursorAIInfoScreen(
            onThemeChanged: (ThemeMode newMode) => themeModeNotifier.value = newMode,
            currentThemeMode: mode,
          ),
        );
      },
    );
  }
} 