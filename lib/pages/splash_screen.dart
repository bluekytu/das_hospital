import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fillController;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();

    // Create fill animation
    _fillController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fillAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fillController, curve: Curves.easeInOut),
    );

    // Start animation and navigate after completion
    _fillController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      });
    });
  }

  @override
  void dispose() {
    _fillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo Fill
            SizedBox(
              width: 150,
              height: 150,
              child: CustomPaint(
                painter: LogoFillPainter(
                  fillPercentage: _fillAnimation.value,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Loading text
            Text(
              'Loading...',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),
            // Progress indicator
            SizedBox(
              width: 60,
              child: LinearProgressIndicator(
                value: _fillAnimation.value,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[600]!),
                minHeight: 3,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoFillPainter extends CustomPainter {
  final double fillPercentage;

  LogoFillPainter({required this.fillPercentage});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    // Draw background circle (outline)
    final outlinePaint = Paint()
      ..color = Colors.teal[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(Offset(centerX, centerY), radius, outlinePaint);

    // Draw filled circle (gradient fill from bottom to top)
    final fillPaint = Paint()
      ..style = PaintingStyle.fill;

    // Create a gradient shader for the fill
    final gradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Colors.teal[600]!,
        Colors.teal[400]!,
      ],
    );

    // Calculate fill height based on percentage
    final fillHeight = size.height * fillPercentage;
    final fillStartY = size.height - fillHeight;

    // Draw the fill rectangle with clipping to circle
    final path = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: radius - 1.5,
      ));

    canvas.clipPath(path);

    // Draw gradient filled rectangle from bottom
    final rect = Rect.fromLTWH(0, fillStartY, size.width, fillHeight);
    fillPaint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    canvas.drawRect(rect, fillPaint);

    // Reset clip
    canvas.restore();

    // Draw hospital icon in center
    _drawHospitalIcon(canvas, Offset(centerX, centerY), 40, Colors.teal[700]!);
  }

  void _drawHospitalIcon(Canvas canvas, Offset center, double size,
      Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw hospital building shape
    final left = center.dx - size / 2;
    final top = center.dy - size / 2;
    final right = center.dx + size / 2;
    final bottom = center.dy + size / 2;

    // Main building body
    canvas.drawRect(
      Rect.fromLTRB(left + 5, top + 15, right - 5, bottom - 5),
      paint,
    );

    // Roof
    final roofPath = Path()
      ..moveTo(left + 5, top + 15)
      ..lineTo(center.dx, top)
      ..lineTo(right - 5, top + 15);
    canvas.drawPath(roofPath, paint);

    // Cross (medical symbol)
    final crossPaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Vertical line of cross
    canvas.drawLine(
      Offset(center.dx, center.dy - 8),
      Offset(center.dx, center.dy + 8),
      crossPaint,
    );

    // Horizontal line of cross
    canvas.drawLine(
      Offset(center.dx - 8, center.dy),
      Offset(center.dx + 8, center.dy),
      crossPaint,
    );

    // Windows (small rectangles)
    final windowPaint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // Top left window
    canvas.drawRect(
      Rect.fromLTWH(left + 10, top + 25, 6, 6),
      windowPaint,
    );

    // Top right window
    canvas.drawRect(
      Rect.fromLTWH(right - 16, top + 25, 6, 6),
      windowPaint,
    );
  }

  @override
  bool shouldRepaint(LogoFillPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage;
  }
}
