import 'package:eco_quiz_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

// --- MAIN APPLICATION SETUP ---

void main() {
  runApp(const NgoQuizApp());
}

class NgoQuizApp extends StatelessWidget {
  const NgoQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Impact Alliance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Earth-toned color scheme
        primarySwatch: const MaterialColor(0xFF2D5B2D, {
          50: Color(0xFFF0F4EF),
          100: Color(0xFFC7DBC7),
          200: Color(0xFF9EBE9E),
          300: Color(0xFF75A275),
          400: Color(0xFF538C53),
          500: Color(0xFF2D5B2D), // Primary Green (Deep)
          600: Color(0xFF275127),
          700: Color(0xFF204520),
          800: Color(0xFF183918),
          900: Color(0xFF0D280D),
        }),
        // Changed from bright Colors.green to a soft sage green for better UI
        scaffoldBackgroundColor:Colors.green,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// --- DATA MODEL AND CONTENT ---

class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question(this.text, this.options, this.correctAnswerIndex);
}

final List<Question> _quizQuestions = [
  Question(
    'What is the most effective way for an individual to reduce food waste at home?',
    ['Buying in bulk', 'Composting all scraps', 'Planning meals and using a shopping list', 'Freezing all leftovers'],
    2, // Planning meals
  ),
  Question(
    'Which action is key to verifying real-world environmental tasks like tree planting?',
    ['Verbal confirmation', 'Self-reporting', 'GPS-tagged photos and QR code checks', 'Signing a paper form'],
    2, // GPS-tagged photos and QR code checks
  ),
  Question(
    'What primary benefit does waste segregation offer?',
    ['It makes garbage look tidier', 'It reduces landfill volume and improves recycling efficiency', 'It eliminates all pollution', 'It speeds up garbage collection'],
    1, // Reduces landfill volume and improves recycling efficiency
  ),
  Question(
    'Which sustainable practice helps reduce methane emissions from landfills?',
    ['Using plastic bags', 'Composting food and organic waste', 'Buying bottled water', 'Driving an SUV'],
    1, // Composting
  ),
  Question(
    'What material is most difficult to recycle and often requires special processing, or should be avoided?',
    ['Aluminum foil', 'Glass bottles', 'Soft, flexible plastic films (like food wrappers)', 'Cardboard boxes'],
    2, // Soft, flexible plastic films
  ),
];

// --- MAIN SCREEN (STATE MANAGEMENT) ---

enum View { home, quiz, certificate }

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  View _currentView = View.home;
  int _currentQuestionIndex = 0;
  int _score = 0;
  final int _passingScore = 4;

  void _navigateTo(View view) {
    setState(() {
      _currentView = view;
    });
  }

  void _startQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _currentView = View.quiz;
    });
  }

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _quizQuestions[_currentQuestionIndex].correctAnswerIndex) {
      _score++;
    }

    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _navigateTo(View.certificate);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentView) {
      case View.home:
        return HomeScreen(
          onStartQuiz: _startQuiz,
        );
      case View.quiz:
        return QuizScreen(
          question: _quizQuestions[_currentQuestionIndex],
          questionNumber: _currentQuestionIndex + 1,
          totalQuestions: _quizQuestions.length,
          onAnswerSelected: _answerQuestion,
        );
      case View.certificate:
        return CertificateScreen(
          score: _score,
          total: _quizQuestions.length,
          passingScore: _passingScore,
          onReturnHome: () => _navigateTo(View.home),
          onRetakeQuiz: _startQuiz,
        );
      default:
        return HomeScreen(onStartQuiz: _startQuiz);
    }
  }
}

// --- 1. HOME SCREEN (NGO LANDING PAGE) ---

class HomeScreen extends StatelessWidget {
  final VoidCallback onStartQuiz;

  const HomeScreen({super.key, required this.onStartQuiz});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        // App Bar is green (theme.primaryColor) and text is white
        title: const Text('Eco Impact Alliance', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green[900],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 16.0),
                child: Text('🌳', style: TextStyle(fontSize: 80)),
              ),
            ),
            Text(
              'Our Mission: Driving Sustainable Habit Change',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.black, // Deep green text on light green background
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We empower students and communities to adopt certified, measurable ecological actions, focusing on waste segregation, reforestation, and local environmental stewardship.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 40),

            // Call to Action Card: Quiz
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Achieve Your Green Habits Certificate',
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF538C53),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Test your fundamental knowledge of sustainable habits and get certified by the Alliance. Pass the quiz to receive your digital recognition.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: onStartQuiz,
                      icon: const Icon(Icons.school, color: Colors.white),
                      label: const Text('Start Certification Quiz', style: TextStyle(fontSize: 16, color: Colors.white)),
                      // Button is primary green
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: onStartQuiz,
                      icon: const Icon(Icons.school, color: Colors.white),
                      label: const Text('Create Event', style: TextStyle(fontSize: 16, color: Colors.white)),
                      // Button is primary green
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
    onPressed: () {
    // Line 1: Can run multiple lines of code
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(

          ),
        ),
      );
    onStartQuiz();
    },
                      icon: const Icon(Icons.back_hand, color: Colors.white),
                      label: const Text('Back To Home', style: TextStyle(fontSize: 16, color: Colors.white)),
                      // Button is primary green
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
            // Contact/Partner Information
            Text(
              'Partnered with Local Eco-Clubs & CSR Initiatives',
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. QUIZ SCREEN ---

class QuizScreen extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final int totalQuestions;
  final void Function(int) onAnswerSelected;

  const QuizScreen({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        // App Bar is green (theme.primaryColor) and text is white
        title: const Text('Green Habits Quiz', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[900],
        automaticallyImplyLeading: false, // Prevents accidental back navigation
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: questionNumber / totalQuestions,
              backgroundColor: Colors.white,
              color: const Color(0xFFA7C957), // Accent green
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 8),
            Text(
              'Question $questionNumber of $totalQuestions',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // Question Text
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFA7C957), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                question.text,
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Options List
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final optionText = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ElevatedButton(
                  onPressed: () => onAnswerSelected(index),
                  // Button is green (theme.primaryColor) with white background and primary green text
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      // Fixed the border color calculation
                      side: BorderSide(color: Colors.green, width: 1),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    children: [
                      Text('${index + 1}.', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          optionText,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

// --- 3. CERTIFICATE SCREEN ---

class CertificateScreen extends StatelessWidget {
  final int score;
  final int total;
  final int passingScore;
  final VoidCallback onReturnHome;
  final VoidCallback onRetakeQuiz;

  const CertificateScreen({
    super.key,
    required this.score,
    required this.total,
    required this.passingScore,
    required this.onReturnHome,
    required this.onRetakeQuiz,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasPassed = score >= passingScore;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        // App Bar is green (theme.primaryColor) and text is white
        title: const Text('Certification Result', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Score Summary Card
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: hasPassed ? const Color(0xFFA7C957) : const Color(0xFFBC4749), // Pass Green / Fail Red
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      hasPassed ? 'CERTIFIED SUCCESS!' : 'CERTIFICATION NOT ACHIEVED',
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Your Score: $score / $total',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    Text(
                      'Required to Pass: $passingScore / $total',
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Certificate Template
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: theme.primaryColor, width: 8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 8)),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ECO IMPACT ALLIANCE',
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: const Color(0xFF6A994E),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const Divider(color: Colors.black45, thickness: 1, height: 20),
                      Text(
                        'This Certificate is Presented to:',
                        style: theme.textTheme.titleMedium!.copyWith(color: Colors.black54),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'A COMMITTED ENVIRONMENTALIST', // Placeholder for actual user name
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                          fontFamily: 'Georgia',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        hasPassed
                            ? 'For successfully completing the Green Habits Fundamentals Quiz.'
                            : 'For demonstrating effort in the Green Habits Fundamentals Quiz.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge!.copyWith(color: Colors.black54),
                      ),
                      const Spacer(),
                      Text(
                        'Issued: ${DateTime.now().toIso8601String().substring(0, 10)}',
                        style: const TextStyle(fontSize: 12, color: Colors.black45),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Actions
            if (hasPassed)
              ElevatedButton.icon(
                onPressed: () {
                  // In a real app, this would trigger a PDF generation or share logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Simulating certificate download/share...')),
                  );
                },
                icon: const Icon(Icons.share, color: Colors.white),
                label: const Text('Share/Download Certificate', style: TextStyle(fontSize: 16, color: Colors.white)),
                // Button is green
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF538C53),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: onRetakeQuiz,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text('Retake Quiz', style: TextStyle(fontSize: 16, color: Colors.white)),
                // Button is red/failure color
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBC4749),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
              ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: onReturnHome,
              child: Text('Return to Home', style: TextStyle(color: theme.primaryColor)),
            ),
          ],
        ),
      ),
    );
  }
}

