import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'home.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    Home(),
    FavoritePage(),
    CountryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        height: 75,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x25000000),
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(
              index: 0,
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              title: 'Home',
            ),
            _navItem(
              index: 1,
              icon: Icons.favorite_border,
              selectedIcon: Icons.favorite,
              title: 'Favorite',
            ),
            _navItem(
              index: 2,
              icon: Icons.public_outlined,
              selectedIcon: Icons.public,
              title: 'Country',
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String title,
  }) {
    final bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: SizedBox(
        width: 100,
        height: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? selectedIcon : icon,
              size: 28,
              color: selected
                  ? const Color(0xffff7043)
                  : const Color(0xff777777),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                selected ? FontWeight.w600 : FontWeight.w400,
                color: selected
                    ? const Color(0xffff7043)
                    : const Color(0xff777777),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountryPage extends StatelessWidget {
  const CountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          'Choose Country',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}