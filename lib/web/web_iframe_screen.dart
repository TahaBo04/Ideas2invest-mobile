import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import '../config/env.dart';

/// A web-only screen that displays an iframe pointing at the backend URL.
class WebIframeScreen extends StatefulWidget {
  const WebIframeScreen({super.key, required this.path});

  final String path;

  @override
  State<WebIframeScreen> createState() => WebIframeScreenState();
}

class WebIframeScreenState extends State<WebIframeScreen> {
  late final String _viewType;
  late final html.IFrameElement _iframe;

  @override
  void initState() {
    super.initState();
    _viewType = 'iframe-${widget.path.hashCode}-${identityHashCode(this)}';
    _iframe = html.IFrameElement()
      ..src = Env.resolveUrl(widget.path)
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allow = 'autoplay; clipboard-write; encrypted-media'
      ..setAttribute('allowfullscreen', 'true');

    ui_web.platformViewRegistry
        .registerViewFactory(_viewType, (int viewId) => _iframe);
  }

  /// Navigate the iframe to a new [path].
  void loadPath(String path) {
    _iframe.src = Env.resolveUrl(path);
  }

  /// Always returns false on web — browser handles back navigation.
  Future<bool> canGoBack() async => false;

  /// No-op on web.
  Future<void> goBack() async {}

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
