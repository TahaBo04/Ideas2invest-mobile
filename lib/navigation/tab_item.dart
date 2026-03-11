import 'package:flutter/material.dart';

class TabItem {
  const TabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.path,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String path;

  static const List<TabItem> tabs = [
    TabItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      path: '/',
    ),
    TabItem(
      label: 'Explore',
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore,
      path: '/explore/',
    ),
    TabItem(
      label: 'Feed',
      icon: Icons.dynamic_feed_outlined,
      activeIcon: Icons.dynamic_feed,
      path: '/feed/',
    ),
    TabItem(
      label: 'Create',
      icon: Icons.add_circle_outline,
      activeIcon: Icons.add_circle,
      path: '/create/',
    ),
    TabItem(
      label: 'Account',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      path: '/account/',
    ),
  ];
}
