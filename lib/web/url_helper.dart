/// Helpers for URL resolution and external-link detection.
class UrlHelper {
  UrlHelper._();

  /// Returns `true` when [url] points to a host different from the backend.
  static bool isExternal(String url, String backendBaseUrl) {
    final linkUri = Uri.tryParse(url);
    final baseUri = Uri.tryParse(backendBaseUrl);
    if (linkUri == null || baseUri == null) return true;
    return linkUri.host.isNotEmpty && linkUri.host != baseUri.host;
  }
}
