import 'package:flutter/material.dart';
import '../config/constants.dart'; 
import '../screens/price_finder_screen.dart'; 
import '../screens/profile_screen.dart'; 
import '../screens/settings_screen.dart'; 
import '../screens/help_support_screen.dart'; 
import '../screens/login_screen.dart'; 
import '../screens/registration_screen.dart';

class RetailixApp extends StatefulWidget {
  const RetailixApp({super.key});

  @override
  State<RetailixApp> createState() => _RetailixAppState();
}

class _RetailixAppState extends State<RetailixApp> {
  // State variable to track the current theme mode
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme

  // Function to change the theme mode, passed to the Settings screen
  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  // --- Light Theme Definition ---
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: retailPrimary,
    scaffoldBackgroundColor: Colors.grey.shade50, // Light background for the main canvas
    appBarTheme: const AppBarTheme(
      backgroundColor: retailPrimary,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    cardColor: Colors.white, // Card/Container background color
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return retailPrimary;
        }
        return Colors.grey.shade400;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return retailPrimary.withOpacity(0.5);
        }
        return Colors.grey.shade300;
      }),
    ),
    useMaterial3: true,
    fontFamily: 'Inter',
  );

  // --- Dark Theme Definition ---
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: retailPrimary,
    scaffoldBackgroundColor: Colors.grey.shade900, // Dark background
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900, // Dark app bar
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    cardColor: Colors.grey.shade800, // Dark card/container background
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade800,
      selectedItemColor: retailPrimary,
      unselectedItemColor: Colors.grey.shade400,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      titleMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.shade700,
      filled: true,
      hintStyle: TextStyle(color: Colors.grey.shade500),
      labelStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: retailPrimary, width: 2),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return retailPrimary;
        }
        return Colors.grey.shade500;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return retailPrimary.withOpacity(0.5);
        }
        return Colors.grey.shade700;
      }),
    ),
    useMaterial3: true,
    fontFamily: 'Inter',
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retailix Price Finder',
      debugShowCheckedModeBanner: false,
      
      // Apply the managed theme mode
      themeMode: _themeMode,
      theme: lightTheme,
      darkTheme: darkTheme, // Use the defined dark theme

      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(), 
        '/home': (context) => const PriceFinderScreen(), 
        '/profile': (context) => const ProfileScreen(),
        // Pass the theme state and setter function to the SettingsScreen
        '/settings': (context) => SettingsScreen(
              currentThemeMode: _themeMode,
              onThemeModeChanged: _setThemeMode,
            ),
        '/help': (context) => const HelpSupportScreen(), 
      },
    );
  }
}