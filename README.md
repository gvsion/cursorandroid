# Cursor AI Flutter App

Este projeto é um exemplo moderno de app Flutter, apresentando uma tela interativa sobre o Cursor AI, com foco em organização, responsividade, uso de SVGs e temas claro/escuro.

## Funcionalidades Principais

### 1. **Tela de Apresentação do Cursor AI**
- Tela principal com animações de entrada (fade e slide).
- Cabeçalho com gradiente, ícone e slogan do Cursor AI.
- Cards de features destacando os diferenciais do produto.
- Seção de linguagens suportadas, com logos SVG reais.
- Seção expansível de recursos avançados.
- Chamada para ação com botão de download/demo.

### 2. **Organização Modular dos Widgets**
- Cada seção visual é um widget separado, localizado em `lib/widgets/`:
  - `cursor_ai_header.dart`: Cabeçalho visual.
  - `cursor_ai_feature_cards.dart`: Cards de features.
  - `cursor_ai_supported_languages.dart`: Grid de linguagens com SVG.
  - `cursor_ai_expandable_section.dart`: Recursos avançados expansíveis.
  - `cursor_ai_interactive_demo.dart`: Chamada para ação.
- A tela principal (`CursorAIInfoScreen`) apenas compõe esses widgets.

### 3. **Responsividade e Layout**
- Layout centralizado e com largura máxima para boa experiência em qualquer tela.
- Seção de linguagens usa `Wrap` para responsividade, adaptando o número de colunas conforme o espaço.
- Cards das linguagens são compactos e exibem SVGs escaláveis.

### 4. **Temas Claro e Escuro**
- Suporte completo a light mode e dark mode.
- O usuário pode alternar manualmente entre os temas pelo menu do AppBar.
- Cores e fundos dos cards se adaptam ao tema.

### 5. **Uso de SVGs para Logos**
- Logos das linguagens são arquivos SVG reais, baixados e salvos em `assets/languages/`.
- O app usa o pacote [`flutter_svg`](https://pub.dev/packages/flutter_svg) para renderizar SVGs.
- Os assets são declarados no `pubspec.yaml`.

### 6. **Animações e UX**
- Animação de entrada suave para a tela principal.
- Seção de recursos avançados com expansão animada.
- Feedback visual ao clicar no botão de download.

### 7. **Boas Práticas de Código**
- Código limpo, modular e fácil de manter.
- Separação clara entre lógica de apresentação e dados.
- Uso de temas, assets e dependências de forma declarativa.

## Como rodar o projeto

1. **Clone o repositório e instale as dependências:**
   ```bash
   flutter pub get
   ```
2. **Baixe os SVGs das linguagens e coloque em `assets/languages/`**
   (Veja instruções no código ou peça para o assistente baixar.)
3. **Rode o app:**
   ```bash
   flutter run
   ```

## Estrutura de Pastas

```
lib/
  main.dart
  cursor_ai_app.dart
  cursor_ai_info_screen.dart
  widgets/
    cursor_ai_header.dart
    cursor_ai_feature_cards.dart
    cursor_ai_supported_languages.dart
    cursor_ai_expandable_section.dart
    cursor_ai_interactive_demo.dart
assets/
  languages/
    python.svg
    javascript.svg
    typescript.svg
    java.svg
    csharp.svg
    cpp.svg
    go.svg
    rust.svg
    dart.svg
```

## Dependências principais
- [flutter_svg](https://pub.dev/packages/flutter_svg): Para renderizar SVGs.
- [http](https://pub.dev/packages/http): Exemplo de consumo de API (pode ser expandido).

## Personalização
- Para adicionar mais linguagens, basta colocar o SVG em `assets/languages/` e adicionar na lista do widget.
- Para mudar as cores ou temas, edite `cursor_ai_app.dart`.
- Para expandir funcionalidades, crie novos widgets em `lib/widgets/`.

## Observações
- O projeto segue boas práticas de Flutter e é ideal para servir de base para apps institucionais, portfólios ou landing pages interativas.
- O código está pronto para ser expandido com navegação, consumo de APIs reais, autenticação, etc.

---

**Desenvolvido com ❤️ usando Flutter e Cursor AI.**
