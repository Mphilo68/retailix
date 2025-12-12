import 'package:flutter/material.dart';
import '../config/constants.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final Function(ThemeMode) onThemeModeChanged;

  const SettingsScreen({
    super.key,
    required this.currentThemeMode,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if Dark Mode is currently active
    bool isDarkMode = currentThemeMode == ThemeMode.dark || currentThemeMode == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, 
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: <Widget>[
          // --- General Settings ---
          _buildSectionHeader(context, 'General'),
          _buildSettingTile(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English (US)',
            onTap: () {},
          ),
          
          // --- Theme Toggle (The requested feature) ---
          ListTile(
            leading: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: retailPrimary,
            ),
            title: const Text('Dark Mode'),
            subtitle: Text(isDarkMode ? 'Active' : 'Inactive'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (bool value) {
                // Call the callback to update the app's state
                onThemeModeChanged(value ? ThemeMode.dark : ThemeMode.light);
              },
              // Colors are now handled by the ThemeData switchTheme properties
            ),
            onTap: () {
               // Toggling via list tile tap
               onThemeModeChanged(!isDarkMode ? ThemeMode.dark : ThemeMode.light);
            },
          ),
          
          // --- Location Settings ---
          _buildSectionHeader(context, 'Location'),
          _buildSettingTile(
            context,
            icon: Icons.location_on_outlined,
            title: 'Default Store Location',
            subtitle: '123 Main St, Anytown',
            onTap: () {},
          ),
          _buildSettingTile(
            context,
            icon: Icons.map_outlined,
            title: 'Price Comparison Radius',
            subtitle: '5 miles',
            onTap: () {},
          ),

          // --- Notifications ---
          _buildSectionHeader(context, 'Notifications'),
          _buildSettingTile(
            context,
            icon: Icons.local_offer_outlined,
            title: 'Deal Alerts',
            subtitle: 'Receive push notifications for best deals',
            trailing: Switch(value: true, onChanged: (v) {}),
            onTap: () {},
          ),
          _buildSettingTile(
            context,
            icon: Icons.email_outlined,
            title: 'Email Subscriptions',
            subtitle: 'Weekly summary of price changes',
            trailing: Switch(value: false, onChanged: (v) {}),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 20, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: retailPrimary,
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: retailPrimary),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}