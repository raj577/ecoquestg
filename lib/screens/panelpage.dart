import 'package:flutter/material.dart';

// Import statements for pages like login_screen.dart and ngopage.dart
// are typically needed only if they are in separate files.
// Since I am providing a single file, I'll comment out the file imports
// and keep the class definitions for demonstration.

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
        scaffoldBackgroundColor: Colors.green[300],
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
      if (role == UserRole.ngo || role == UserRole.teacher || role == UserRole.student || role == UserRole.govt) {
        // Navigate to the LoginPage for all these roles
        // NOTE: If LoginPage is not defined in this file, you must ensure it is imported or defined.
        Navigator.of(context).push(
          // Assuming 'LoginPage' is a defined class (or imported)
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
      // 'Other' role would typically go to a Guest or Info page.
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
        // LOGO Implementation (App Bar)
        // title: Image.asset(
        //   'assets/images/logoti.png', // Assuming logoti.png is the logo you want here
        //   height: 32,
        //   color: Colors.white,
        // ),
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
              // --- NEW IMAGE IMPLEMENTATION (Top of Page) ---
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Center(
                  child: Image.asset(
                    'assets/images/logoti.png', // Placeholder file name
                    height: 120, // Adjust height as needed
                    // Optionally set color if it's a vector-based asset:
                    // color: darkGreenText,
                  ),
                ),
              ),
              // --- END NEW IMAGE IMPLEMENTATION ---

              Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please select your primary role to customize your dashboard:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
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

// --- NEW PAGE DEFINITIONS (REQUIRED for navigation to work) ---

// Placeholder for the external Login Page
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(child: Text('This is the placeholder Login Screen.')),
    );
  }
}

// Placeholder for the external NGO Page (now unused, but kept for context)
class NGOPage extends StatelessWidget {
  const NGOPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NGO Dashboard')),
      body: const Center(child: Text('This is the placeholder NGO Dashboard.')),
    );
  }
}
