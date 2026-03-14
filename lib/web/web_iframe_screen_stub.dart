import 'package:flutter/material.dart';

/// Stub for non-web platforms — should never be instantiated.
class WebIframeScreen extends StatefulWidget {
  const WebIframeScreen({super.key, required this.path});

  final String path;

  @override
  State<WebIframeScreen> createState() => WebIframeScreenState();
}

class WebIframeScreenState extends State<WebIframeScreen> {
  void loadPath(String path) {}
  Future<bool> canGoBack() async => false;
  Future<void> goBack() async {}

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Not supported on this platform'));
  }
}
