import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controllerHome;
  late AnimationController _controllerLogin;
  late Animation<double> _animationHome;
  late Animation<double> _animationLogin;

  final List<Orb> _orbs = [];
  final List<Blast> _blasts = [];
  final Random _random = Random();
  late Ticker _orbTicker;
  int _frameCounter = 0;

  @override
  void initState() {
    super.initState();

    _controllerHome = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animationHome = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controllerHome, curve: Curves.easeInOut),
    );

    _controllerLogin = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animationLogin = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controllerLogin, curve: Curves.easeInOut),
    );

    for (int i = 0; i < 8; i++) {
      _orbs.add(_createRandomOrb());
    }

    _orbTicker = createTicker((elapsed) {
      for (var orb in _orbs) {
        orb.update();
      }

      for (var blast in _blasts) {
        blast.update();
      }

      _blasts.removeWhere((blast) => blast.isDone);

      _frameCounter++;
      if (_frameCounter % 60 == 0 && _orbs.length < 20) {
        _orbs.add(_createRandomOrb());
      }

      setState(() {});
    })..start();
  }

  Orb _createRandomOrb() {
    final hsv = HSVColor.fromAHSV(1, _random.nextDouble() * 360, 1, 1);
    return Orb(
      position: Offset(_random.nextDouble() * 400, _random.nextDouble() * 800),
      velocity: Offset(
        (_random.nextDouble() - 0.5) * 2,
        (_random.nextDouble() - 0.5) * 2,
      ),
      radius: _random.nextDouble() * 20 + 10,
      color: hsv.toColor(),
      rotationAngle: _random.nextDouble() * 2 * pi,
    );
  }

  void _handleTap(TapUpDetails details) {
    final tapPos = details.localPosition;
    Orb? tappedOrb;

    for (var orb in _orbs) {
      if ((orb.position - tapPos).distance <= orb.radius) {
        tappedOrb = orb;
        break;
      }
    }

    if (tappedOrb != null) {
      _orbs.remove(tappedOrb);
      _blasts.add(Blast(origin: tappedOrb.position, color: tappedOrb.color));
    }
  }

  @override
  void dispose() {
    _controllerHome.dispose();
    _controllerLogin.dispose();
    _orbTicker.dispose();
    super.dispose();
  }

  Widget buildBouncingButton({
    required String text,
    required Animation<double> animation,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ScaleTransition(
      scale: animation,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: color, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 20,
          shadowColor: color.withOpacity(0.8),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            color: color,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: _handleTap,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F0C29),
                    Color(0xFF302B63),
                    Color(0xFF24243E),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            CustomPaint(
              size: Size.infinite,
              painter: OrbPainter(_orbs, _blasts),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildBouncingButton(
                    text: 'Home',
                    animation: _animationHome,
                    onPressed: () => context.go('/home'),
                    color: Colors.cyanAccent,
                  ),
                  const SizedBox(height: 50),
                  buildBouncingButton(
                    text: 'Login',
                    animation: _animationLogin,
                    onPressed: () => context.go('/login'),
                    color: Colors.pinkAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Orb {
  Offset position;
  Offset velocity;
  double radius;
  Color color;
  double rotationAngle;

  Orb({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.color,
    this.rotationAngle = 0,
  });

  void update() {
    position += velocity;

    if (position.dx <= 0 || position.dx >= 400) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy <= 0 || position.dy >= 800) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }

    final hsv = HSVColor.fromColor(color);
    color = hsv.withHue((hsv.hue + 0.5) % 360).toColor();

    rotationAngle += 0.05;
  }
}

class Blast {
  final Offset origin;
  final Color color;
  final List<_Particle> particles = [];
  int frameCount = 0;

  Blast({required this.origin, required this.color}) {
    final random = Random();
    for (int i = 0; i < 20; i++) {
      particles.add(
        _Particle(
          position: origin,
          velocity: Offset.fromDirection(
            random.nextDouble() * 2 * pi,
            random.nextDouble() * 4,
          ),
          color: color.withOpacity(0.7),
        ),
      );
    }
  }

  void update() {
    for (var p in particles) {
      p.position += p.velocity;
      p.opacity -= 0.03;
    }
    frameCount++;
  }

  bool get isDone => frameCount > 30;
}

class _Particle {
  Offset position;
  Offset velocity;
  double opacity;
  final Color color;

  _Particle({
    required this.position,
    required this.velocity,
    required this.color,
  }) : opacity = 1.0;
}

class OrbPainter extends CustomPainter {
  final List<Orb> orbs;
  final List<Blast> blasts;

  OrbPainter(this.orbs, this.blasts);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var orb in orbs) {
      paint.shader =
          RadialGradient(
            colors: [orb.color.withOpacity(0.6), Colors.transparent],
          ).createShader(
            Rect.fromCircle(center: orb.position, radius: orb.radius * 2),
          );
      canvas.drawCircle(orb.position, orb.radius * 2, paint);

      paint.shader = null;
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = orb.color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0);
      canvas.drawCircle(orb.position, orb.radius, paint);

      final satelliteDistance = orb.radius + 6;
      final satelliteOffset = Offset(
        cos(orb.rotationAngle) * satelliteDistance,
        sin(orb.rotationAngle) * satelliteDistance,
      );
      final satellitePaint = Paint()
        ..color = orb.color.withOpacity(0.7)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(orb.position + satelliteOffset, 3, satellitePaint);
    }

    for (var blast in blasts) {
      for (var p in blast.particles) {
        final particlePaint = Paint()
          ..color = p.color.withOpacity(p.opacity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);
        canvas.drawCircle(p.position, 3, particlePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant OrbPainter oldDelegate) => true;
}
