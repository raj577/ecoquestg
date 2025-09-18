import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;



void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
      apiKey: "AIzaSyDrmPnyOtdzSaSgF0ZNz4ZS2QU9nt18UoE",
      appId: "1:233348592044:web:YOUR_WEB_APP_ID",
      messagingSenderId: "233348592044",
      projectId: "saged-24422",
      authDomain: "saged-24422.firebaseapp.com",
      storageBucket: "saged-24422.firebasestorage.app",
    )
        : const FirebaseOptions(
      apiKey: "AIzaSyDrmPnyOtdzSaSgF0ZNz4ZS2QU9nt18UoE",
      appId: "1:233348592044:android:5cc087b821bf3f456c0a09",
      messagingSenderId: "233348592044",
      projectId: "saged-24422",
      storageBucket: "saged-24422.firebasestorage.app",
    ),
  );
  runApp(const EcoQuizApp());
}

class EcoQuizApp extends StatelessWidget {
  const EcoQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Eco Quiz Kids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'ComicNeue',
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4CAF50),
          secondary: Color(0xFFFF9800),
          surface: Color(0xFFF1F8E9),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xFF2E7D32),
          onSurfaceVariant: Color(0xFF1B5E20),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

