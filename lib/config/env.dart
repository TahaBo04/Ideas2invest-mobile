import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Env._();

  /// Returns the backend base URL from .env, ensuring it ends with a '/'.
  static String get backendBaseUrl {
    final raw = dotenv.env['BACKEND_BASE_URL'] ?? 'https://example.com/';
    return raw.endsWith('/') ? raw : '$raw/';
  }

  /// Resolves a relative [path] against the backend base URL.
  ///
  /// Leading slashes on [path] are stripped so that `Uri.resolve` works
  /// correctly against the trailing-slash base URL.
  static String resolveUrl(String path) {
    final base = Uri.parse(backendBaseUrl);
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return base.resolve(cleanPath).toString();
  }
}
