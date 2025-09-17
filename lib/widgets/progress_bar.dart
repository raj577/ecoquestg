import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final AnimationController animationController;

  const CustomProgressBar({
    super.key,
    required this.current,
    required this.total,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final progress = current / total;
    
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question $current of $total',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        

        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [

              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              

              AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Container(
                    width: MediaQuery.of(context).size.width * progress * animationController.value,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFE082),
                          Color(0xFFFFD54F),
                          Color(0xFFFFC107),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFC107).withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideX(begin: -1.0, end: 0),
        
        const SizedBox(height: 8),
        

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            total,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: index < current
                    ? const Color(0xFFFFC107)
                    : Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            )
                .animate()
                .fadeIn(delay: (index * 100).ms, duration: 400.ms)
                .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0)),
          ),
        ),
      ],
    );
  }
}

