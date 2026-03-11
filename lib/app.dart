import 'package:flutter/material.dart';

import 'theme/theme.dart';
import 'screens/shell_screen.dart';

class Ideas2InvestApp extends StatelessWidget {
  const Ideas2InvestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ideas2invest',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const ShellScreen(),
    );
  }
}
