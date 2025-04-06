import 'package:flutter/material.dart';
import 'package:babond/core/constants/app_colors.dart';
import 'home_page.dart';
import 'kandang_page.dart';
import 'informasi_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigation();
}

class _MainNavigation extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const KandangPage(),
    const InformasiPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 253, 235, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications, color: AppColors.pinkDark),
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text(
          'Babond',
          style: TextStyle(
            color: AppColors.pinkDark,
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: AppColors.pinkDark),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.pinkDark,
        unselectedItemColor: AppColors.pinkDark.withOpacity(0.5),
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pets_rounded), label: 'Cage'),
          BottomNavigationBarItem(icon: Icon(Icons.info_rounded), label: 'Informasi'),
        ],
      ),
    );
  }
}
