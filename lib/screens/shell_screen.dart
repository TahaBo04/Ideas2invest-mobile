import 'package:flutter/material.dart';

import '../navigation/tab_item.dart';
import '../web/webview_screen.dart';
import 'about_screen.dart';
import 'settings_screen.dart';

/// The main shell that hosts the bottom navigation bar, drawer, and WebView
/// tabs.
class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _currentIndex = 0;

  /// One [GlobalKey] per tab so each WebView keeps its state.
  final List<GlobalKey<WebViewScreenState>> _keys = List.generate(
    TabItem.tabs.length,
    (_) => GlobalKey<WebViewScreenState>(),
  );

  // ----- back-button handling -----

  Future<bool> _onWillPop() async {
    final webViewState = _keys[_currentIndex].currentState;
    if (webViewState != null && await webViewState.canGoBack()) {
      await webViewState.goBack();
      return false; // don't exit
    }
    return true; // exit the app / pop the screen
  }

  // ----- drawer helpers -----

  void _openDrawerRoute(Widget page) {
    Navigator.of(context).pop(); // close drawer
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  void _loadInCurrentTab(String path) {
    Navigator.of(context).pop(); // close drawer
    _keys[_currentIndex].currentState?.loadPath(path);
  }

  // ----- build -----

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Ideas2invest')),
        drawer: _buildDrawer(context),
        body: IndexedStack(
          index: _currentIndex,
          children: List.generate(TabItem.tabs.length, (i) {
            return WebViewScreen(
              key: _keys[i],
              path: TabItem.tabs[i].path,
            );
          }),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            if (index == _currentIndex) {
              // Reload the current tab when tapped again.
              _keys[_currentIndex].currentState
                  ?.loadPath(TabItem.tabs[_currentIndex].path);
            } else {
              setState(() => _currentIndex = index);
            }
          },
          destinations: TabItem.tabs
              .map(
                (tab) => NavigationDestination(
                  icon: Icon(tab.icon),
                  selectedIcon: Icon(tab.activeIcon),
                  label: tab.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Text(
              'Ideas2invest',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => _openDrawerRoute(const SettingsScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () => _openDrawerRoute(const AboutScreen()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () => _loadInCurrentTab('/login/'),
          ),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('Register'),
            onTap: () => _loadInCurrentTab('/register/'),
          ),
        ],
      ),
    );
  }
}
