import 'package:flutter/material.dart';

import 'package:api/ui/pages/belt_page.dart';
import 'package:api/ui/pages/order_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            OrderPage(),
            BeltPage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.public),
            label: 'The Order',
          ),
          NavigationDestination(
            icon: Icon(Icons.satellite_alt),
            label: 'The Belt',
          ),
        ],
      ),
    );
  }
}
