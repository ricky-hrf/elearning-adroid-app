import 'package:flutter/material.dart';

class BrandHeaderCard extends StatelessWidget {
  final String platformName;
  final String schoolName;
  final String logoAsset;

  const BrandHeaderCard({
    super.key,
    required this.platformName,
    required this.schoolName,
    required this.logoAsset,
  });

  Widget _circle(double size, double alpha) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: alpha),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A90D9), Color(0xFF2F6DB5)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(right: -26, top: -30, child: _circle(110, 0.12)),
            Positioned(right: 30, bottom: -40, child: _circle(80, 0.08)),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        logoAsset,
                        width: 56,
                        height: 56,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('Gagal load logo: $error');
                          return const Icon(Icons.school, size: 44, color: Colors.white);
                        },
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          platformName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    schoolName.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.amberAccent.withValues(alpha: 0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
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