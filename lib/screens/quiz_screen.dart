import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../models/quiz_question.dart';
import '../widgets/question_card.dart';
import '../widgets/progress_bar.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;
  final String title;
  final bool isChallenge;

  const QuizScreen({
    super.key,
    required this.questions,
    required this.title,
    this.isChallenge = false,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with TickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<bool> _answerResults = [];
  late ConfettiController _confettiController;
  late AnimationController _progressController;
  late AnimationController _questionController;
  bool _isAnswered = false;
  int? _selectedAnswer;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _questionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _progressController.forward();
    _questionController.forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _progressController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentQuestionIndex];
    
    return Scaffold(

      // Confetti overlay
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF81C784),
                  Color(0xFF4CAF50),
                  Color(0xFF2E7D32),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          QuestionCard(
                            question: currentQuestion,
                            selectedAnswer: _selectedAnswer,
                            isAnswered: _isAnswered,
                            onAnswerSelected: _handleAnswerSelection,
                            animationController: _questionController,
                          ),
                          const SizedBox(height: 30),
                          if (_isAnswered) _buildNextButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 1.5708, // radians for downward
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.05,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Top row with back button and score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _showExitDialog(),
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$_score',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Title
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms)
              .slideY(begin: -0.3, end: 0),
          
          const SizedBox(height: 16),
          
          // Progress Bar
          CustomProgressBar(
            current: _currentQuestionIndex + 1,
            total: widget.questions.length,
            animationController: _progressController,
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _nextQuestion,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF2E7D32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 8,
        ),
        child: Text(
          _currentQuestionIndex == widget.questions.length - 1
              ? 'See Results! 🎉'
              : 'Next Question →',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  void _handleAnswerSelection(int selectedIndex) {
    if (_isAnswered) return;
    
    setState(() {
      _selectedAnswer = selectedIndex;
      _isAnswered = true;
    });
    
    final currentQuestion = widget.questions[_currentQuestionIndex];
    final isCorrect = selectedIndex == currentQuestion.correctAnswerIndex;
    
    _answerResults.add(isCorrect);
    
    if (isCorrect) {
      _score += widget.isChallenge ? 20 : 10;
      _confettiController.play();
    }
    
    // Auto-advance after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _isAnswered) {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isAnswered = false;
        _selectedAnswer = null;
      });
      
      // Reset and restart animations
      _questionController.reset();
      _progressController.forward();
      _questionController.forward();
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    final duration = DateTime.now().difference(_startTime);
    final result = QuizResult(
      totalQuestions: widget.questions.length,
      correctAnswers: _answerResults.where((result) => result).length,
      score: _score,
      timeTaken: duration,
      answerResults: _answerResults,
    );
    
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(
          result: result,
          quizTitle: widget.title,
          isChallenge: widget.isChallenge,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Exit Quiz?'),
        content: const Text('Are you sure you want to exit? Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Quiz'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Exit quiz
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}

