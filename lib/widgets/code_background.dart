import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CodeBackground extends StatefulWidget {
  final Widget child;
  const CodeBackground({super.key, required this.child});

  @override
  State<CodeBackground> createState() => _CodeBackgroundState();
}

class _CodeBackgroundState extends State<CodeBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<CodeParticle> _particles = [];
  final math.Random _random = math.Random();

  final List<String> _codeSnippets = [
    '<div>',
    'const app = new App();',
    'function deploy() {',
    '01010011',
    '11001010',
    'Flutter.run();',
    'async / await',
    'git push origin main',
    'return Neuralix();',
    '{ status: 200 }',
    'SELECT * FROM clients',
    'docker compose up',
    'API.fetch()',
    'npm run build',
    'export default',
    'Widget build()',
    'class Developer {}',
    'System.out.println()',
    'const [data, setData]',
    'Neuralix.innovate()',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    // Generate floating code particles
    for (int i = 0; i < 40; i++) {
      _particles.add(
        CodeParticle(
          text: _codeSnippets[_random.nextInt(_codeSnippets.length)],
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          speed: 0.15 + _random.nextDouble() * 0.35,
          opacity: 0.08 + _random.nextDouble() * 0.22,
          size: 11.0 + _random.nextDouble() * 5.0,
          isBinary: _random.nextBool(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base dark cyber gradient
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.6, -0.7),
                radius: 1.2,
                colors: [
                  Color(0xFF0C234E), // Deep cyber blue glow
                  Color(0xFF051026),
                  AppColors.background,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        // Secondary cyan ambient glow
        Positioned(
          top: 300,
          right: -100,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.cyanAccent.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Glowing blue center-bottom aura
        Positioned(
          bottom: 200,
          left: -150,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryBlue.withValues(alpha: 0.10),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Animated Code Painter
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: CodeGridPainter(
                  progress: _controller.value,
                  particles: _particles,
                ),
              );
            },
          ),
        ),

        // Content
        widget.child,
      ],
    );
  }
}

class CodeParticle {
  final String text;
  final double x;
  double y;
  final double speed;
  final double opacity;
  final double size;
  final bool isBinary;

  CodeParticle({
    required this.text,
    required this.x,
    required this.y,
    required this.speed,
    required this.opacity,
    required this.size,
    required this.isBinary,
  });
}

class CodeGridPainter extends CustomPainter {
  final double progress;
  final List<CodeParticle> particles;

  CodeGridPainter({required this.progress, required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF0F264E).withValues(alpha: 0.35)
      ..strokeWidth = 0.5;

    // Draw Subtle Matrix Cyber Grid
    const double gridSize = 50.0;
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw Subtle Circuit Dots at Grid Intersections
    final dotPaint = Paint()..color = AppColors.cyanAccent.withValues(alpha: 0.25);
    for (double x = 0; x < size.width; x += gridSize * 3) {
      for (double y = 0; y < size.height; y += gridSize * 3) {
        final double pulse = (math.sin((x + y) * 0.01 + progress * 2 * math.pi) + 1) / 2;
        canvas.drawCircle(Offset(x, y), 1.2 + pulse * 1.0, dotPaint);
      }
    }

    // Draw Floating Code Snippets
    for (final particle in particles) {
      final double currentY = ((particle.y + progress * particle.speed) % 1.0) * size.height;
      final double currentX = particle.x * size.width;

      final textSpan = TextSpan(
        text: particle.text,
        style: TextStyle(
          fontFamily: 'Courier',
          fontSize: particle.size,
          color: particle.isBinary
              ? AppColors.cyanAccent.withValues(alpha: particle.opacity * 0.8)
              : Colors.lightBlueAccent.withValues(alpha: particle.opacity),
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(currentX, currentY));
    }
  }

  @override
  bool shouldRepaint(covariant CodeGridPainter oldDelegate) => true;
}

