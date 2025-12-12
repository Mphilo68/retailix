import 'package:flutter/material.dart';
import '../config/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // --- Placeholder for actual Firebase Auth logic ---
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      setState(() {
        _isLoading = false;
      });

      // Simulate successful sign-in
      if (mounted) {
        // Navigate to the main home screen after successful login
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  void _signInAsGuest() {
    // Logic for anonymous sign-in or guest session
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Continuing as Guest...'))
    );
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _socialSignIn(String provider) {
    // Placeholder for social sign-in logic (e.g., GoogleSignIn().signIn())
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Signing in with $provider...'))
    );
    // In a real scenario, after successful authentication, navigate to /home
    // Navigator.of(context).pushReplacementNamed('/home');
  }

  void _navigateToRegister() {
    // Navigate to the new registration screen
    Navigator.of(context).pushNamed('/register');
  }
  
  // Helper widget to build modern social login buttons
  Widget _buildSocialButton({
    required IconData icon, 
    required String providerName,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Builder(
          builder: (context) {
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;
            return Container(
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                // Dynamic background for the button container
                color: isDarkMode ? Theme.of(context).cardColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(isDarkMode ? 0.3 : 0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(icon, size: 30, color: iconColor),
              ),
            );
          }
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // Theme-aware colors
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Scaffold background is now theme-aware
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400, // Maximum width for a clean look on desktop/tablet
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0), // Ample space from edges
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // App Logo/Name
                  Text(
                    'Retailix',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: retailPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Find the Best Prices, Instantly.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 50), 

                  // Login Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // Email Input (Uses theme-aware InputDecoration settings)
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Password Input (Uses theme-aware InputDecoration settings)
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        // Sign In Button
                        SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: retailPrimary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    'Sign In',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Navigate to Registration Screen
                  
                  TextButton(
                    onPressed: _navigateToRegister,
                    child: Text(
                      'Don\'t have an account? Register Now',
                      style: TextStyle(color: retailSecondary, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Social Login Separator
                  Row(
                    children: [
                      Expanded(child: Divider(color: isDarkMode ? Colors.grey.shade700 : Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR', style: TextStyle(color: isDarkMode ? Colors.grey.shade500 : Colors.grey)),
                      ),
                      Expanded(child: Divider(color: isDarkMode ? Colors.grey.shade700 : Colors.grey)),
                    ],
                  ),
                  
                  const SizedBox(height: 20),

                  // Social Login Buttons Row
                  Row(
                    children: [
                      // Google
                      _buildSocialButton(
                        icon: Icons.g_mobiledata_outlined,
                        providerName: 'Google',
                        iconColor: Colors.red.shade600,
                        onTap: () => _socialSignIn('Google'),
                      ),
                      // Apple
                      _buildSocialButton(
                        icon: Icons.apple,
                        providerName: 'Apple',
                        iconColor: isDarkMode ? Colors.white : Colors.black, // Apple logo is white in dark mode
                        onTap: () => _socialSignIn('Apple'),
                      ),
                      // Facebook
                      _buildSocialButton(
                        icon: Icons.facebook,
                        providerName: 'Facebook',
                        iconColor: Colors.blue.shade800,
                        onTap: () => _socialSignIn('Facebook'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Continue as Guest Button
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.person_outline),
                      label: const Text('Continue as Guest'),
                      onPressed: _signInAsGuest,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                        side: BorderSide(color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}