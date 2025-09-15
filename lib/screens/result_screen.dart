import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../models/quiz_question.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final QuizResult result;
  final String quizTitle;
  final bool isChallenge;

  const ResultScreen({
    super.key,
    required this.result,
    required this.quizTitle,
    this.isChallenge = false,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _scoreController;
  late AnimationController _celebrationController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Start animations
    _scoreController.forward();
    _celebrationController.forward();
    
    // Start confetti if good score
    if (widget.result.percentage >= 70) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _confettiController.play();
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scoreController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _getGradientColors(),
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Result Icon and Title
                  _buildResultHeader(),
                  
                  const SizedBox(height: 30),
                  
                  // Score Card
                  _buildScoreCard(),
                  
                  const SizedBox(height: 30),
                  
                  // Stats Cards
                  _buildStatsCards(),
                  
                  const SizedBox(height: 30),
                  
                  // Action Buttons
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
          
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 1.5708,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 100,
              gravity: 0.05,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
                Colors.yellow,
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getGradientColors() {
    if (widget.result.percentage >= 90) {
      return [const Color(0xFF4CAF50), const Color(0xFF81C784), const Color(0xFFC8E6C9)];
    } else if (widget.result.percentage >= 70) {
      return [const Color(0xFF2196F3), const Color(0xFF64B5F6), const Color(0xFFBBDEFB)];
    } else if (widget.result.percentage >= 50) {
      return [const Color(0xFFFF9800), const Color(0xFFFFB74D), const Color(0xFFFFE0B2)];
    } else {
      return [const Color(0xFFF44336), const Color(0xFFEF5350), const Color(0xFFFFCDD2)];
    }
  }

  Widget _buildResultHeader() {
    IconData icon;
    String title;
    String subtitle;
    
    if (widget.result.percentage >= 90) {
      icon = Icons.emoji_events;
      title = 'Excellent! 🏆';
      subtitle = 'You\'re an Eco Champion!';
    } else if (widget.result.percentage >= 70) {
      icon = Icons.star;
      title = 'Great Job! ⭐';
      subtitle = 'You\'re doing amazing!';
    } else if (widget.result.percentage >= 50) {
      icon = Icons.thumb_up;
      title = 'Good Work! 👍';
      subtitle = 'Keep learning!';
    } else {
      icon = Icons.refresh;
      title = 'Try Again! 💪';
      subtitle = 'Practice makes perfect!';
    }
    
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 60,
            color: Colors.white,
          ),
        )
            .animate(controller: _celebrationController)
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1.0, 1.0),
              curve: Curves.elasticOut,
            )
            .then()
            .shake(hz: 2, curve: Curves.easeInOutCubic),
        
        const SizedBox(height: 20),
        
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 800.ms)
            .slideY(begin: 0.3, end: 0),
        
        const SizedBox(height: 8),
        
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white.withAlpha(229),
          ),
        )
            .animate()
            .fadeIn(delay: 500.ms, duration: 800.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Score',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Animated score
          AnimatedBuilder(
            animation: _scoreController,
            builder: (context, child) {
              final animatedScore = (widget.result.score * _scoreController.value).round();
              return Text(
                '$animatedScore',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _getGradientColors()[0],
                ),
              );
            },
          ),
          
          const SizedBox(height: 8),
          
          Text(
            '${widget.result.correctAnswers}/${widget.result.totalQuestions} Correct',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Grade badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: _getGradientColors()[0],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Grade: ${widget.result.grade}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 700.ms, duration: 800.ms)
        .slideY(begin: 0.3, end: 0)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Accuracy',
            '${widget.result.percentage.round()}%',
            Icons.track_changes,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Time',
            _formatDuration(widget.result.timeTaken),
            Icons.timer,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 900.ms, duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Play Again Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: _getGradientColors()[0],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 8,
            ),
            child: const Text(
              'Play Again 🔄',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Home Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              'Back to Home 🏠',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: 1100.ms, duration: 800.ms)
        .slideY(begin: 0.3, end: 0);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }
}

