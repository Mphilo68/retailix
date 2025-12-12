import 'package:flutter/material.dart';
import '../config/constants.dart'; // Import constants for colors

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Helper to determine the leading icon based on title (to use specific icons)
  IconData _getLeadingIcon(String title) {
    switch (title) {
      case 'Change Password': return Icons.lock_outline;
      case 'Shipping Addresses': return Icons.location_on_outlined;
      case 'Notification Settings': return Icons.notifications_none;
      case 'Payment Methods': return Icons.credit_card_outlined;
      case 'Sign Out': return Icons.logout;
      default: return Icons.settings_applications;
    }
  }

  // Refactored Profile Tile to use specific icons
  Widget _buildProfileTileRefactored({
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(_getLeadingIcon(title), color: retailPrimary),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
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
            // Profile Header Area
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Avatar
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: retailSecondary,
                    child: Icon(Icons.account_circle, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  // User Name
                  const Text(
                    'Alex Retailer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  // User Email
                  const Text(
                    'alex.retailer@retailix.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Edit Profile Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action: Open Edit Profile Form
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: retailPrimary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Account Actions Section
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: Text(
                  'Account & Preferences',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),

            // Profile Buttons/Tiles
            _buildProfileTileRefactored(
              title: 'Change Password',
              onTap: () {},
            ),
            _buildProfileTileRefactored(
              title: 'Shipping Addresses',
              onTap: () {},
            ),
            _buildProfileTileRefactored(
              title: 'Notification Settings',
              onTap: () {},
            ),
            _buildProfileTileRefactored(
              title: 'Payment Methods',
              onTap: () {},
            ),
            
            const SizedBox(height: 20),

            // Sign Out Button (Distinct style)
            _buildProfileTileRefactored(
              title: 'Sign Out',
              color: Colors.red,
              onTap: () {},
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}