import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:url_launcher/url_launcher.dart'; // Add this package to your pubspec.yaml
import '../utils/quiz_data.dart';
import 'category_screen.dart';
import 'quiz_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _features = [
    {
      'title': 'Quick Quiz',
      'subtitle': 'Random questions from all topics',
      'icon': Icons.flash_on,
      'gradient': [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)],
    },
    {
      'title': 'Categories',
      'subtitle': 'Choose your favorite topic',
      'icon': Icons.category,
      'gradient': [const Color(0xFF4ECDC4), const Color(0xFF44A08D)],
    },
    {
      'title': 'Challenge Mode',
      'subtitle': 'Test your eco knowledge',
      'icon': Icons.emoji_events,
      'gradient': [const Color(0xFFFFE66D), const Color(0xFFFF6B6B)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8F5E8),
              Color(0xFFF1F8E9),
              Color(0xFFE0F2F1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Welcome Card
                      _buildWelcomeCard(),

                      const SizedBox(height: 30),

                      // Feature Cards
                      _buildFeatureCards(),

                      const SizedBox(height: 30),

                      // Stats Card
                      _buildStatsCard(),

                      const SizedBox(height: 40), // Space before footer

                      // Footer
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.eco,
              color: Colors.white,
              size: 28,
            ),
          )
              .animate()
              .scale(duration: 600.ms, curve: Curves.elasticOut)
              .then()
              .shimmer(duration: 2000.ms),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Eco Hero! 🌱',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(begin: -0.3, end: 0),

                Text(
                  'Ready to save the planet?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 800.ms)
                    .slideX(begin: -0.3, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.public,
            size: 60,
            color: Colors.white,
          )
              .animate(onPlay: (controller) => controller.repeat())
              .rotate(duration: 4000.ms),

          const SizedBox(height: 16),

          const Text(
            'Learn About Our Planet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 800.ms)
              .slideY(begin: 0.3, end: 0),

          const SizedBox(height: 8),

          Text(
            'Discover how to protect the environment through fun quizzes and activities!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          )
              .animate()
              .fadeIn(delay: 500.ms, duration: 800.ms)
              .slideY(begin: 0.3, end: 0),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 1000.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  Widget _buildFeatureCards() {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildFeatureCard(
              title: _features[0]['title'],
              subtitle: _features[0]['subtitle'],
              icon: _features[0]['icon'],
              gradient: _features[0]['gradient'],
              onTap: () => _startQuickQuiz(),
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              title: _features[1]['title'],
              subtitle: _features[1]['subtitle'],
              icon: _features[1]['icon'],
              gradient: _features[1]['gradient'],
              onTap: () => _navigateToCategories(),
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              title: _features[2]['title'],
              subtitle: _features[2]['subtitle'],
              icon: _features[2]['icon'],
              gradient: _features[2]['gradient'],
              onTap: () => _startChallengeMode(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
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
      child: Column(
        children: [
          Text(
            'Your Eco Impact',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Quizzes', '0', Icons.quiz, Colors.blue),
              _buildStatItem('Score', '0%', Icons.star, Colors.orange),
              _buildStatItem('Streak', '0', Icons.local_fire_department, Colors.red),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 800.ms, duration: 1000.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  // New footer widget
  Widget _buildFooter() {
    final Uri url = Uri.parse('https://raj577.github.io/');

    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
        children: <TextSpan>[
          const TextSpan(text: 'Developed by '),
          TextSpan(
            text: 'raj577',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                // This will now open the URL
                if (!await launchUrl(url)) {
                  // Shows a message if the URL can't be launched
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not launch $url')),
                  );
                }
              },
          ),
        ],
      ),
    );
  }

  void _startQuickQuiz() {
    final questions = QuizData.getAllQuestions()..shuffle();
    final selectedQuestions = questions.take(5).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          questions: selectedQuestions,
          title: 'Quick Quiz',
        ),
      ),
    );
  }

  void _navigateToCategories() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CategoryScreen(),
      ),
    );
  }

  void _startChallengeMode() {
    final questions = QuizData.getAllQuestions()
        .where((q) => q.difficulty >= 2)
        .toList()
      ..shuffle();
    final selectedQuestions = questions.take(10).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          questions: selectedQuestions,
          title: 'Challenge Mode',
          isChallenge: true,
        ),
      ),
    );
  }
}