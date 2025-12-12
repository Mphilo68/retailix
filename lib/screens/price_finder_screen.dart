import 'package:flutter/material.dart';
import '../config/constants.dart'; // Import constants
import 'profile_screen.dart'; // Import Profile Screen

class PriceFinderScreen extends StatefulWidget {
  const PriceFinderScreen({super.key});

  @override
  State<PriceFinderScreen> createState() => _PriceFinderScreenState();
}

class _PriceFinderScreenState extends State<PriceFinderScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    if (index == 3) { // Index 3 corresponds to the 'Profile' icon
      // Navigate to the ProfileScreen directly
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
      // We don't change _selectedIndex here, so the bottom bar stays on the original tab 
      // or we can set it to a neutral tab if we prefer. For now, we leave it as is 
      // since the profile screen is a separate full page.
      
    } else {
      // For all other tabs (Home, Scan, Lists), update the selected index
      setState(() {
        _selectedIndex = index;
      });
      // Optionally, if the user taps 'Home' (index 0) while on a different tab,
      // we can pop back to the root if needed, but for now we just change the index.
    }
  }

  // Helper function for drawer item navigation
  void _navigate(String routeName) {
    Navigator.pop(context); // Close the drawer first
    if (routeName == '/') return; 
    
    // Simple push replacement for non-home screens
    if (routeName == '/profile' || routeName == '/settings' || routeName == '/help') {
      Navigator.of(context).pushNamed(routeName);
    } 
    // Add other screen navigations here
    else {
      // Placeholder for other routes (Shopping List, Deals, Settings, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Navigating to $routeName...'))
      );
    }
  }

  // --- WIDGETS FOR UI SECTIONS ---

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      toolbarHeight: 60,
      title: const Text(
        'RETAILIX',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, size: 28),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, size: 28),
          onPressed: () {
            // Action: Navigate to Notification Center
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notification Center coming soon!'))
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, size: 28),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for products or scan',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: retailPrimary),
            onPressed: () {},
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildMainProductCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Organic Whole Milk (1 Gallon)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'E3.99',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: retailPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                // Best Price Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: retailSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Best Price!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Placeholder for Product Image
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Center(
              child: Icon(Icons.shopping_bag_outlined, color: retailPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealCard({
    required String title,
    required String price,
    required IconData icon,
    required Color iconColor,
    bool isHot = false,
  }) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: isHot
                ? Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'HOT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox(height: 18),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceComparisonCard({
    required String storeName,
    required String price,
    required String detail,
    required bool hasDeal,
  }) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Store Logo/Name Placeholder
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                color: Colors.grey.shade200,
                child: Center(child: Text(storeName[0])), // Placeholder initial
              ),
              const SizedBox(width: 4),
              Text(
                storeName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: retailPrimary,
            ),
          ),
          Text(
            detail,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(height: 8),
          if (hasDeal)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: retailSecondary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 0,
                ),
                child: const Text('View Deal', style: TextStyle(fontSize: 12)),
              ),
            )
          else
            const SizedBox(height: 36), // Maintain vertical space
        ],
      ),
    );
  }

  Widget _buildAppDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header with Retailix branding
          const DrawerHeader(
            decoration: BoxDecoration(
              color: retailPrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Retailix',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your Smart Shopping Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // --- User Requested Menu Items ---

          ListTile(
            leading: const Icon(Icons.home_outlined, color: retailPrimary),
            title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () => _navigate('/'),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('My Profile'),
            onTap: () => _navigate('/profile'), // Navigates to ProfileScreen
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_outlined),
            title: const Text('Shopping List'),
            onTap: () => _navigate('/lists'),
          ),
          ListTile(
            leading: const Icon(Icons.local_offer_outlined),
            title: const Text('Daily Deals'),
            onTap: () => _navigate('/deals'),
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Store Favourites'),
            onTap: () => _navigate('/favorites'),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => _navigate('/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            onTap: () => _navigate('/help'),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () => _navigate('/logout'),
          ),
        ],
      ),
    );
  }

  // --- SCREEN BODY ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildCustomAppBar(),
      drawer: _buildAppDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Search Bar
            _buildSearchBar(),

            // Main Product Card (Milk)
            _buildMainProductCard(),

            // Daily Deals Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Text(
                'Daily Deals',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            // Horizontal List of Deals
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildDealCard(
                      title: 'Avocados',
                      price: 'E15.99',
                      icon: Icons.grass,
                      iconColor: Colors.green.shade700,
                      isHot: true),
                  _buildDealCard(
                      title: 'Ground Coffee',
                      price: 'E16.99',
                      icon: Icons.coffee,
                      iconColor: Colors.brown.shade700,
                      isHot: false),
                  _buildDealCard(
                      title: 'Electric Toothbrush',
                      price: 'E114.99',
                      icon: Icons.brush,
                      iconColor: retailPrimary,
                      isHot: false),
                  _buildDealCard(
                      title: 'Summer Salad Kit',
                      price: 'E7.50',
                      icon: Icons.local_florist,
                      iconColor: Colors.pink,
                      isHot: true),
                ],
              ),
            ),

            // Compare Prices Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Text(
                'Compare Prices',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            // Horizontal List of Comparisons
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildPriceComparisonCard(
                      storeName: 'Walmart',
                      price: 'E129.99',
                      detail: 'E160.00 orig.',
                      hasDeal: false),
                  _buildPriceComparisonCard(
                      storeName: 'COSTCO',
                      price: 'E134.50',
                      detail: 'Membership Req.',
                      hasDeal: false),
                  _buildPriceComparisonCard(
                      storeName: 'BestBuy',
                      price: 'E18.00',
                      detail: 'In-store pickup',
                      hasDeal: true),
                  _buildPriceComparisonCard(
                      storeName: 'Amazon',
                      price: 'E139.99',
                      detail: 'Free Shipping',
                      hasDeal: false),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            activeIcon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: retailPrimary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}