import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class GlassNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const GlassNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(0),
        topRight: Radius.circular(0),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0.5),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.0),
            border: Border(
              top: BorderSide(
                color: Colors.black.withValues(alpha: 0.2),
                width: 0.4,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.black,
            onTap: onTap,
            iconSize: 18,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_grid_2x2_fill),
                label: 'Tools',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 35,
                  width: 60,
                  child: Lottie.asset(
                    'assets/animations/bot2.json',
                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.save_alt),
                label: 'Saved',
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
