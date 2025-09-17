import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/quiz_question.dart';

class QuestionCard extends StatelessWidget {
  final QuizQuestion question;
  final int? selectedAnswer;
  final bool isAnswered;
  final Function(int) onAnswerSelected;
  final AnimationController animationController;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.isAnswered,
    required this.onAnswerSelected,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        _buildQuestionImage(),
        
        const SizedBox(height: 20),
        

        _buildQuestionText(),
        
        const SizedBox(height: 24),
        

        _buildAnswerOptions(),
        

        if (isAnswered) ...[
          const SizedBox(height: 20),
          _buildExplanation(),
        ],
      ],
    );
  }

  Widget _buildQuestionImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          question.imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    )
        .animate(controller: animationController)
        .fadeIn(duration: 600.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0))
        .slideY(begin: -0.2, end: 0);
  }

  Widget _buildQuestionText() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        question.question,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2E7D32),
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    )
        .animate(controller: animationController)
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideX(begin: -0.3, end: 0);
  }

  Widget _buildAnswerOptions() {
    return Column(
      children: List.generate(
        question.options.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildAnswerOption(index),
        ),
      ),
    );
  }

  Widget _buildAnswerOption(int index) {
    final isSelected = selectedAnswer == index;
    final isCorrect = index == question.correctAnswerIndex;
    
    Color backgroundColor;
    Color textColor;
    Color borderColor;
    IconData? icon;
    
    if (!isAnswered) {
      backgroundColor = Colors.white;
      textColor = const Color(0xFF2E7D32);
      borderColor = Colors.transparent;
    } else {
      if (isCorrect) {
        backgroundColor = const Color(0xFF4CAF50);
        textColor = Colors.white;
        borderColor = const Color(0xFF2E7D32);
        icon = Icons.check_circle;
      } else if (isSelected) {
        backgroundColor = const Color(0xFFF44336);
        textColor = Colors.white;
        borderColor = const Color(0xFFD32F2F);
        icon = Icons.cancel;
      } else {
        backgroundColor = Colors.white.withOpacity(0.7);
        textColor = const Color(0xFF2E7D32).withOpacity(0.7);
        borderColor = Colors.transparent;
      }
    }
    
    return GestureDetector(
      onTap: () => onAnswerSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Option letter
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Option text
            Expanded(
              child: Text(
                question.options[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            
            // Result icon
            if (isAnswered && icon != null) ...[
              const SizedBox(width: 8),
              Icon(
                icon,
                color: textColor,
                size: 24,
              ),
            ],
          ],
        ),
      ),
    )
        .animate(controller: animationController)
        .fadeIn(delay: (300 + index * 100).ms, duration: 500.ms)
        .slideX(begin: 0.3, end: 0)
        .then()
        .shimmer(
          delay: (1000 + index * 200).ms,
          duration: 1000.ms,
          color: Colors.white54,
        );
  }

  Widget _buildExplanation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF81C784).withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4CAF50),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Did you know?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            question.explanation,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF2E7D32),
              height: 1.4,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.3, end: 0)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0));
  }
}

