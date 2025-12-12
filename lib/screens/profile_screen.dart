import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../utils/auth_service.dart'; // Import the new service

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Handles the sign-out process and navigates back to the login screen
  void _handleSignOut(BuildContext context) async {
    // 1. Call the simulated sign out service
    await AuthService().signOut();

    // 2. Navigate back to the login screen, replacing all previous routes
    if (context.mounted) {
      // pushNamedAndRemoveUntil clears the entire navigation stack, preventing back navigation to home
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have been signed out.'))
      );
    }
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: onTap != null ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: retailPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // User Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.white,
              child: const Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: retailSecondary,
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jane Shopper',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'jane.shopper@retailix.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const Divider(height: 1, thickness: 1),

            // Account Settings
            _buildSectionHeader('Account Settings'),
            _buildProfileTile(
              icon: Icons.edit_outlined,
              title: 'Edit Personal Information',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Editing Info...'))
                );
              },
            ),
            _buildProfileTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Changing Password...'))
                );
              },
            ),
            
            const Divider(height: 1, thickness: 1),

            // Preferences
            _buildSectionHeader('Preferences'),
            _buildProfileTile(
              icon: Icons.location_on_outlined,
              title: 'My Locations',
              subtitle: '2 saved addresses',
              onTap: () {},
            ),
            _buildProfileTile(
              icon: Icons.local_offer_outlined,
              title: 'Notification Preferences',
              subtitle: 'Email and Push enabled',
              onTap: () {},
            ),

            const Divider(height: 1, thickness: 1),
            
            // App Information
            _buildSectionHeader('App Information'),
            _buildProfileTile(
              icon: Icons.info_outline,
              title: 'Terms of Service',
              onTap: () {},
            ),
            _buildProfileTile(
              icon: Icons.security,
              title: 'Privacy Policy',
              onTap: () {},
            ),

            const Divider(height: 1, thickness: 1),

            // Sign Out Button (The Target)
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sign Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
              onTap: () => _handleSignOut(context),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 20, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: retailPrimary,
          ),
        ),
      ),
    );
  }
}