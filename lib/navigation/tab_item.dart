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
      label: 'Ideas',
      icon: Icons.lightbulb_outlined,
      activeIcon: Icons.lightbulb,
      path: '/ideas/',
    ),
    TabItem(
      label: 'Posts',
      icon: Icons.article_outlined,
      activeIcon: Icons.article,
      path: '/posts/',
    ),
    TabItem(
      label: 'Login',
      icon: Icons.login_outlined,
      activeIcon: Icons.login,
      path: '/auth/login',
    ),
    TabItem(
      label: 'Register',
      icon: Icons.person_add_outlined,
      activeIcon: Icons.person_add,
      path: '/auth/register',
    ),
  ];
}
