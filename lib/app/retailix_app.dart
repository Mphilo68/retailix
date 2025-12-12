import 'package:flutter/material.dart';
import '../config/constants.dart'; // Import constants
import '../screens/price_finder_screen.dart'; // Import home screen
import '../screens/profile_screen.dart'; // Import profile screen
import '../screens/settings_screen.dart'; // Import settings screen
import '../screens/help_support_screen.dart'; // Import help & support screen

class RetailixApp extends StatelessWidget {
  const RetailixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retailix Price Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: retailPrimary,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: retailPrimary,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      // Use named routes for clean navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const PriceFinderScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        // Placeholder routes for navigation, implemented in the drawer's _navigate function for now
        // '/lists': (context) => const ShoppingListScreen(),
        // '/deals': (context) => const DailyDealsScreen(),
        // '/favorites': (context) => const FavoritesScreen(),
        '/help': (context) => const HelpSupportScreen(),
        // '/logout': (context) => const LogoutScreen(),
      },
    );
  }
}