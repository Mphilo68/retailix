import 'package:flutter/material.dart';
import '../config/constants.dart'; // Import constants for colors

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State variables for toggles
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _priceAlertsEnabled = true;
  String _preferredStore = 'Walmart';

  // Helper widget to build a toggle switch setting
  Widget _buildToggleSetting({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    String? subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: retailPrimary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: retailSecondary,
      ),
      onTap: () => onChanged(!value), // Allows tapping the whole tile to toggle
    );
  }

  // Helper widget to build a selection setting (e.g., dropdown, navigation)
  Widget _buildSelectSetting({
    required String title,
    required String currentValue,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: retailPrimary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(currentValue, style: TextStyle(color: Colors.grey.shade600)),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }

  // Function to show the store selection dialog
  void _showStoreSelection() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Preferred Store'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['Walmart', 'COSTCO', 'BestBuy', 'Amazon'].map((store) {
              return RadioListTile<String>(
                title: Text(store),
                value: store,
                groupValue: _preferredStore,
                activeColor: retailPrimary,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _preferredStore = value;
                    });
                    Navigator.pop(context);
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: retailPrimary,
      ),
      body: ListView(
        children: <Widget>[
          // 1. Account Section Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text('App Preferences', style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: retailPrimary,
            )),
          ),
          
          // Toggle 1: Notifications
          _buildToggleSetting(
            title: 'Enable Notifications',
            subtitle: 'Receive updates on new deals and list reminders.',
            icon: Icons.notifications_active_outlined,
            value: _notificationsEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _notificationsEnabled = newValue;
              });
            },
          ),

          // Toggle 2: Dark Mode
          _buildToggleSetting(
            title: 'Dark Mode',
            subtitle: 'Switch to a darker theme for night time use.',
            icon: Icons.dark_mode_outlined,
            value: _darkModeEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _darkModeEnabled = newValue;
                // In a real app, this would trigger Theme changes
              });
            },
          ),
          
          const Divider(height: 1, indent: 16, endIndent: 16),

          // Selection 1: Preferred Store
          _buildSelectSetting(
            title: 'Preferred Default Store',
            icon: Icons.store_outlined,
            currentValue: _preferredStore,
            onTap: _showStoreSelection,
          ),

          // Toggle 3: Price Alerts
          _buildToggleSetting(
            title: 'Low Price Alerts',
            subtitle: 'Get notified when tracked items drop below a target price.',
            icon: Icons.trending_down,
            value: _priceAlertsEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _priceAlertsEnabled = newValue;
              });
            },
          ),
          
          // 2. Data & Privacy Section Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text('Data & Privacy', style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: retailPrimary,
            )),
          ),

          // Select 2: Privacy Policy
          ListTile(
            leading: const Icon(Icons.security_outlined, color: retailPrimary),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            onTap: () {
              // Action: Open privacy policy link
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Privacy Policy...'))
              );
            },
          ),

          // Select 3: Terms of Service
          ListTile(
            leading: const Icon(Icons.article_outlined, color: retailPrimary),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            onTap: () {
              // Action: Open terms of service link
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Terms of Service...'))
              );
            },
          ),
        ],
      ),
    );
  }
}