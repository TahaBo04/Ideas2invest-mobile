import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../config/env.dart';
import 'url_helper.dart';

/// A reusable WebView screen that loads a URL resolved against the backend
/// base URL.  Provides pull-to-refresh and a loading progress indicator.
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.path});

  /// Relative path (e.g. "/explore/") resolved against `BACKEND_BASE_URL`.
  final String path;

  @override
  State<WebViewScreen> createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (UrlHelper.isExternal(request.url, Env.backendBaseUrl)) {
              launchUrl(Uri.parse(request.url),
                  mode: LaunchMode.externalApplication);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(Env.resolveUrl(widget.path)));
  }

  /// Exposed so the shell can query back-navigation state.
  Future<bool> canGoBack() => _controller.canGoBack();

  /// Exposed so the shell can trigger back-navigation.
  Future<void> goBack() => _controller.goBack();

  /// Navigate this WebView to a new [path].
  void loadPath(String path) {
    _controller.loadRequest(Uri.parse(Env.resolveUrl(path)));
  }

  Future<void> _refresh() async {
    await _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _refresh,
          child: WebViewWidget(controller: _controller),
        ),
        if (_isLoading)
          const Center(
            child: SpinKitFadingCircle(
              color: Color(0xFF1565C0),
              size: 48.0,
            ),
          ),
      ],
    );
  }
}
