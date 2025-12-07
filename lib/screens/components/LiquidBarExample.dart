import 'package:flutter/material.dart';
import 'package:liquido/liquido.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Glass(
      blurSigma: 35,
      refractionBorder: 5,
      saturationBoost: 1.25,
      contrastBoost: 1.15,
      grainIntensity: 0.08,
      centerScale: 0.85,
      edgeScale: 1.12,
      brightnessCompensation: -0.12,
      glassTint: Colors.white.withOpacity(0.12),

      shape: const RoundedSuperellipseBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
      ),

      // FIXED: Single shadow (not list)
      boxShadow: const BoxShadow(
        color: Colors.black26,
        blurRadius: 25,
        offset: Offset(0, 10),
      ),

      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: onTap,

          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
