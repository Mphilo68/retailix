import 'package:flutter/material.dart';
import '../config/constants.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  // Data structure for FAQ items
  static const List<Map<String, String>> faqItems = [
    {
      'question': 'How does Retailix find the best price?',
      'answer':
          'Retailix uses aggregated data from thousands of public retail sources and proprietary deal feeds. When you search for a product, we scan prices from major and local retailers in your area to present the best current offer.',
    },
    {
      'question': 'Can I save items to a shopping list?',
      'answer':
          'Yes! You can create multiple shopping lists and add products directly from the search results or the deals section. Lists are automatically sorted to optimize your shopping route based on price and location.',
    },
    {
      'question': 'Is my personal data secure?',
      'answer':
          'We take privacy very seriously. All personal and payment information is encrypted and stored securely. We never share your data with third parties without explicit consent. Please see our Privacy Policy in the Settings screen for more details.',
    },
    {
      'question': 'How do I report an incorrect price?',
      'answer':
          'If you find an outdated or incorrect price, please tap the "Report" button next to the price listing. Our team will verify the information immediately. Your help ensures the accuracy of our data!',
    },
  ];

  // Helper widget for expandable FAQ items
  Widget _buildFAQTile(String question, String answer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600, color: retailPrimary),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the contact method buttons
  Widget _buildContactMethod({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: retailSecondary, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: retailPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: retailPrimary,
                ),
              ),
            ),

            // FAQ List
            ...faqItems.map((item) {
              return _buildFAQTile(item['question']!, item['answer']!);
            }),

            const SizedBox(height: 30),

            // Contact Section Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Need More Help?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: retailPrimary,
                ),
              ),
            ),
            
            // Contact Subtitle
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: Text(
                'Our support team is available 24/7.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),

            // Contact Methods
            _buildContactMethod(
              title: 'Live Chat',
              subtitle: 'Connect with a representative now.',
              icon: Icons.chat_bubble_outline,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Starting Live Chat...'))
                );
              },
            ),
            _buildContactMethod(
              title: 'Email Support',
              subtitle: 'Send us an email and we\'ll reply within 24 hours.',
              icon: Icons.email_outlined,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Composing Support Email...'))
                );
              },
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}