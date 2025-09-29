import 'package:eco_quiz_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'ngopage.dart';

// --- MAIN APPLICATION SETUP ---

void main() {
  runApp(const RoleSelectionApp());
}

class RoleSelectionApp extends StatelessWidget {
  const RoleSelectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Impact Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // --- USING STANDARD Colors.green FOR PRIMARY SWATCH ---
        primarySwatch: Colors.green,

        // Mid-tone green background, as specified by the user
        scaffoldBackgroundColor: Colors.green,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const UserRoleSelectionScreen(),
    );
  }
}

// --- USER ROLE SELECTION SCREEN ---

enum UserRole { teacher, student, ngo, govt, other }

class UserRoleSelectionScreen extends StatelessWidget {
  const UserRoleSelectionScreen({super.key});

  // Function to handle role selection and navigation
  void selectRole(BuildContext context, UserRole role) {
    final String selectedRoleName = role.name.toUpperCase();

    // 1. Show a confirmation Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Role Selected: $selectedRoleName. Navigating...'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.shade700,
      ),
    );

    // 2. Navigation Logic:
    // Delay navigation slightly so the Snackbar is visible for a moment
    Future.delayed(const Duration(milliseconds: 500), () {
      if (role == UserRole.ngo) {
        // Navigate to the NGOPage
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else if (role == UserRole.teacher) {
        // Placeholder for other role navigation or generic dashboard
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else if (role == UserRole.teacher) {
        // Placeholder for other role navigation or generic dashboard
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else if (role == UserRole.student) {
        // Placeholder for other role navigation or generic dashboard
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color accentGreen = Colors.green.shade700;
    final Color darkGreenText = Colors.green.shade900;

    // Maps the UserRole enum to display text and icons
    final roleOptions = {
      UserRole.teacher: {'text': 'Teacher', 'icon': Icons.school},
      UserRole.student: {'text': 'Student', 'icon': Icons.person},
      UserRole.ngo: {'text': 'NGO / Eco-Club', 'icon': Icons.people},
      UserRole.govt: {'text': 'Government / City Admin', 'icon': Icons.account_balance},
      UserRole.other: {'text': 'Other / Guest', 'icon': Icons.more_horiz},
    };

    return Scaffold(
      appBar: AppBar(
        // LOGO Implementation
        title: Image.asset(
          'assets/images/logot.png',
          height: 32,
          color: Colors.white,
        ),
        centerTitle: false,
        backgroundColor: Colors.green[900],
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to EcoRhythm',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w900,
                  color: darkGreenText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please select your primary role to customize your dashboard:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 40),

              // Role Selection Cards (Buttons)
              ...roleOptions.entries.map((entry) {
                final role = entry.key;
                final data = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () => selectRole(context, role),
                    icon: Icon(data['icon'] as IconData, size: 28, color: accentGreen),
                    label: Text(
                      data['text'] as String,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: accentGreen,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.green, width: 2),
                      ),
                      elevation: 4,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

// --- NEW PAGE DEFINITION ---

class NGOPage extends StatelessWidget {
  const NGOPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('NGO Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, NGO / Eco-Club Partner!',
              style: theme.textTheme.headlineMedium!.copyWith(color: Colors.green.shade900),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'This is the dedicated page for managing your programs and impact data.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Go back to the role selection screen
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Return to Role Selection'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
