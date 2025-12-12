import 'package:flutter/material.dart';
import '../config/constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  // FocusNode to track when the password field is active
  final FocusNode _passwordFocusNode = FocusNode();
  
  bool _isLoading = false;
  bool _isPasswordVisible = false; // NEW: State for toggling password visibility
  bool _isPasswordFocused = false; // NEW: State for tracking password field focus

  // State variable for password strength
  double _passwordStrength = 0;
  String _strengthText = '';
  Color _strengthColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    // Listen to changes in the password field to update the strength meter
    _passwordController.addListener(_checkPasswordStrength);
    
    // Listen to focus changes to show/hide the strength meter
    _passwordFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_checkPasswordStrength);
    _passwordFocusNode.removeListener(_handleFocusChange);
    
    _passwordFocusNode.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // NEW: Handler to update focus state
  void _handleFocusChange() {
    setState(() {
      _isPasswordFocused = _passwordFocusNode.hasFocus;
    });
  }

  // Password strength checking logic
  void _checkPasswordStrength() {
    final password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        _passwordStrength = 0;
        _strengthText = '';
        _strengthColor = Colors.grey;
      });
      return;
    }

    // Initialize scores
    int score = 0;
    
    // Rule 1: Length (min 8 characters is recommended for 'Good')
    if (password.length >= 8) {
      score += 1;
    }
    
    // Rule 2: Contains lowercase letters
    if (password.contains(RegExp(r'[a-z]'))) {
      score += 1;
    }
    
    // Rule 3: Contains uppercase letters
    if (password.contains(RegExp(r'[A-Z]'))) {
      score += 1;
    }
    
    // Rule 4: Contains numbers
    if (password.contains(RegExp(r'[0-9]'))) {
      score += 1;
    }
    
    // Rule 5: Contains special characters
    if (password.contains(RegExp(r'[!@#\$&*~-]'))) {
      score += 1;
    }

    // Determine strength based on score (max score is 5)
    setState(() {
      _passwordStrength = score / 5;
      if (score < 2) {
        _strengthText = 'Very Weak';
        _strengthColor = Colors.red.shade700;
      } else if (score == 2) {
        _strengthText = 'Weak';
        _strengthColor = Colors.orange;
      } else if (score == 3) {
        _strengthText = 'Fair';
        _strengthColor = Colors.yellow.shade700;
      } else if (score == 4) {
        _strengthText = 'Good';
        _strengthColor = Colors.lightGreen.shade700;
      } else { // score 5
        _strengthText = 'Very Strong';
        _strengthColor = Colors.green.shade700;
      }
    });
  }

  void _register() async {
    // Force validation before attempting registration
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!'))
      );
      return;
    }

    // Optional: Add a check to prevent registration if password is too weak
    if (_passwordStrength < 0.4) { // Requires at least "Weak" strength (score >= 2)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a stronger password.'))
      );
      return;
    }
      
    setState(() {
      _isLoading = true;
    });

    // --- Placeholder for actual Firebase Auth registration logic ---
    await Future.delayed(const Duration(seconds: 2)); 

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account for ${_nameController.text} created successfully!'))
      );
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        elevation: 0,
        backgroundColor: isDarkMode ? Theme.of(context).scaffoldBackgroundColor : retailPrimary,
        foregroundColor: isDarkMode ? Colors.white : Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Join Retailix',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: retailPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Get started with smart price finding and lists.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Name Input
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email Input
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

                  // Password Input
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode, // Use the FocusNode
                    obscureText: !_isPasswordVisible, // Controlled by state
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      // Toggle button for visibility
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: isDarkMode ? Colors.white70 : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  
                  // Conditional display of Password Strength Indicator and Text
                  if (_isPasswordFocused) ...[
                    const SizedBox(height: 10),
                    // Password Strength Indicator
                    LinearProgressIndicator(
                      value: _passwordStrength,
                      backgroundColor: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                      color: _strengthColor,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 5),

                    // Password Strength Text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _strengthText.isEmpty ? 'Enter a password' : 'Strength: $_strengthText',
                        style: TextStyle(
                          color: _strengthText.isEmpty ? (isDarkMode ? Colors.white70 : Colors.grey) : _strengthColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ] else if (_passwordController.text.isNotEmpty) ...[
                    // If not focused but password entered, display minimal status
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password set. Tap to review strength.',
                        style: TextStyle(
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ] else ...[
                    const SizedBox(height: 30),
                  ],


                  // Confirm Password Input
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_reset_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Register Button
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
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
                              'Register',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Back to Login Link
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Go back to the Login Screen
                    },
                    child: Text(
                      'Already have an account? Sign In',
                      style: TextStyle(color: retailSecondary, fontWeight: FontWeight.w600),
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