# Ideas2Invest Mobile — Technical Report

**Project:** `ideas2invest_mobile`  
**Version:** 1.0.0+1  
**Framework:** Flutter (Dart ≥ 3.0)  
**Platforms:** Android · iOS · Web · macOS · Linux · Windows  
**Author:** Boulaamane Taha — EMI Process, École Mohammadia d'Ingénieurs  

---

## Table of Contents

1. [Project Overview](#1-project-overview)  
2. [Repository Layout](#2-repository-layout)  
3. [Root-Level Configuration Files](#3-root-level-configuration-files)  
4. [Dart / Flutter Source (`lib/`)](#4-dart--flutter-source-lib)  
   - 4.1 `lib/main.dart`  
   - 4.2 `lib/app.dart`  
   - 4.3 `lib/config/env.dart`  
   - 4.4 `lib/theme/theme.dart`  
   - 4.5 `lib/navigation/tab_item.dart`  
   - 4.6 `lib/screens/shell_screen.dart`  
   - 4.7 `lib/screens/about_screen.dart`  
   - 4.8 `lib/screens/settings_screen.dart`  
   - 4.9 `lib/web/webview_screen.dart`  
   - 4.10 `lib/web/web_iframe_screen.dart`  
   - 4.11 `lib/web/web_iframe_screen_stub.dart`  
   - 4.12 `lib/web/web_iframe_screen_export.dart`  
   - 4.13 `lib/web/url_helper.dart`  
5. [Android Platform (`android/`)](#5-android-platform-android)  
6. [iOS Platform (`ios/`)](#6-ios-platform-ios)  
7. [Web Platform (`web/`)](#7-web-platform-web)  
8. [macOS Platform (`macos/`)](#8-macos-platform-macos)  
9. [Linux Platform (`linux/`)](#9-linux-platform-linux)  
10. [Windows Platform (`windows/`)](#10-windows-platform-windows)  
11. [Assets (`assets/`)](#11-assets-assets)  
12. [Tests (`test/`)](#12-tests-test)  
13. [Dependency Overview](#13-dependency-overview)  
14. [Architecture Diagram](#14-architecture-diagram)  
15. [Data Flow](#15-data-flow)  
16. [Security Considerations](#16-security-considerations)  

---

## 1. Project Overview

Ideas2Invest Mobile is a **Flutter hybrid application** that wraps the Ideas2Invest web platform inside a native mobile shell.  
The app does **not** host its own business logic; all content is served from a configurable backend URL.  
The Flutter layer provides:

- native bottom-tab and drawer navigation
- back-gesture handling
- pull-to-refresh
- external-link interception (opens the system browser instead of the in-app WebView)
- a platform-conditional rendering strategy (WebView on mobile/desktop, `<iframe>` on web)

---

## 2. Repository Layout

```
.
├── .env.example                      # Environment template
├── .flutter-plugins-dependencies     # Flutter plugin dependency graph (generated)
├── .gitignore
├── .metadata                         # Flutter tooling metadata (generated)
├── analysis_options.yaml             # Dart linter configuration
├── ideas2invest_mobile.iml           # IntelliJ module descriptor
├── pubspec.yaml                      # Package manifest & dependency list
├── pubspec.lock                      # Pinned dependency versions
├── README.md                         # User-facing project documentation
│
├── assets/
│   └── icons/
│       └── app_icon.png              # Application launcher icon
│
├── docs/
│   └── screenshots/
│       └── .gitkeep                  # Placeholder preserving the empty directory
│
├── lib/                              # All Dart application source
│   ├── main.dart
│   ├── app.dart
│   ├── config/
│   │   └── env.dart
│   ├── navigation/
│   │   └── tab_item.dart
│   ├── screens/
│   │   ├── shell_screen.dart
│   │   ├── about_screen.dart
│   │   └── settings_screen.dart
│   ├── theme/
│   │   └── theme.dart
│   └── web/
│       ├── url_helper.dart
│       ├── web_iframe_screen.dart
│       ├── web_iframe_screen_export.dart
│       ├── web_iframe_screen_stub.dart
│       └── webview_screen.dart
│
├── test/
│   ├── unit_test.dart
│   └── widget_test.dart
│
├── android/                          # Android host project
├── ios/                              # iOS / iPadOS host project
├── web/                              # Flutter Web bootstrap files
├── macos/                            # macOS desktop host project
├── linux/                            # Linux desktop host project
└── windows/                          # Windows desktop host project
```

---

## 3. Root-Level Configuration Files

### `.env.example`

| Detail | Value |
|---|---|
| **Format** | Plain-text key=value |
| **Purpose** | Template showing required environment variables |
| **Key variable** | `BACKEND_BASE_URL=https://example.com/` |

The real `.env` file (excluded from version control via `.gitignore`) is loaded at startup by `flutter_dotenv` and bundled as a Flutter asset declared in `pubspec.yaml`.  
This single variable controls every URL the application resolves at runtime.

---

### `.flutter-plugins-dependencies`

Generated automatically by `flutter pub get`.  
Contains a JSON graph of which Flutter plugins are needed per platform and their interdependencies.  
It is committed to source control so that CI environments can reproduce the exact plugin set without running `pub get`.

---

### `.gitignore`

Excludes:

| Excluded path | Reason |
|---|---|
| `.dart_tool/`, `.packages`, `.pub-cache/`, `.pub/`, `build/` | Dart/Flutter build artefacts |
| `.idea/`, `.vscode/` | IDE-specific directories |
| `ios/Pods/`, various iOS artefacts | CocoaPods-managed iOS dependencies |
| `android/.gradle/`, `android/local.properties` | Android Gradle cache and machine-local settings |
| `android/**/GeneratedPluginRegistrant.java` | Auto-generated Android plugin glue code |
| `.env` | Sensitive runtime configuration |

---

### `.metadata`

Flutter tooling metadata.  
Records the Flutter channel, version, and project type used to create the project.  
Not manually edited.

---

### `analysis_options.yaml`

Dart static-analysis configuration.

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_const_constructors: true
    prefer_const_declarations: true
    avoid_print: false
```

- Inherits the recommended `flutter_lints` rule set.
- Enforces compile-time const usage wherever possible, keeping widget rebuilds cheap.
- Permits `print()` calls (useful during early development / debugging).

---

### `pubspec.yaml`

The Dart package manifest.

| Field | Value |
|---|---|
| `name` | `ideas2invest_mobile` |
| `version` | `1.0.0+1` (semver + build number) |
| `environment.sdk` | `>=3.0.0 <4.0.0` |

**Runtime dependencies:**

| Package | Version constraint | Role |
|---|---|---|
| `flutter` | SDK | Core UI framework |
| `webview_flutter` | `^4.10.0` | In-app WebView on Android / iOS / macOS |
| `url_launcher` | `^6.3.1` | Opens external URLs in the system browser |
| `flutter_dotenv` | `^5.2.1` | Reads `.env` key-value pairs at startup |
| `flutter_spinkit` | `^5.2.1` | Animated loading indicators |

**Dev dependencies:**

| Package | Version constraint | Role |
|---|---|---|
| `flutter_test` | SDK | Flutter testing framework |
| `flutter_lints` | `^5.0.0` | Recommended Dart/Flutter linting rules |

**Flutter section:**  
Registers `.env` and `assets/icons/` as bundled Flutter assets so they are accessible at runtime via `rootBundle` or `flutter_dotenv`.

---

### `pubspec.lock`

Auto-generated by `flutter pub get`.  
Pins every transitive dependency to a specific version and content hash, guaranteeing reproducible builds across machines.

---

### `ideas2invest_mobile.iml`

IntelliJ IDEA / Android Studio module descriptor.  
Defines the module type as a Flutter module so the IDE correctly indexes Dart sources and platform directories.  
Not relevant at build or runtime.

---

## 4. Dart / Flutter Source (`lib/`)

### 4.1 `lib/main.dart`

**Role:** Application entry point.

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const Ideas2InvestApp());
}
```

**Responsibilities:**
1. `WidgetsFlutterBinding.ensureInitialized()` — required before any platform channels or async operations during startup.
2. `dotenv.load(fileName: '.env')` — reads the bundled `.env` asset into memory so that `Env.backendBaseUrl` is available everywhere in the application.
3. `runApp(const Ideas2InvestApp())` — inflates the widget tree starting from the root widget.

**Dependencies imported:** `flutter/material.dart`, `flutter_dotenv`, `app.dart`.

---

### 4.2 `lib/app.dart`

**Role:** Root widget; configures the `MaterialApp`.

```dart
class Ideas2InvestApp extends StatelessWidget {
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
```

**Key decisions:**
- `debugShowCheckedModeBanner: false` hides the debug ribbon for demo cleanliness.
- `theme: appTheme` delegates all Material 3 theming to `lib/theme/theme.dart`.
- `home: const ShellScreen()` makes the shell the only route; all navigation inside the shell is in-tab navigation rather than Flutter route pushes.

---

### 4.3 `lib/config/env.dart`

**Role:** Centralised access layer for environment variables.

```dart
class Env {
  static String get backendBaseUrl { ... }
  static String resolveUrl(String path) { ... }
}
```

**`backendBaseUrl`:**
- Reads `BACKEND_BASE_URL` from `dotenv.env`.
- Falls back to `'https://example.com/'` if the variable is absent.
- Guarantees a trailing `/` so that `Uri.resolve` behaves correctly.

**`resolveUrl(String path)`:**
- Strips any leading `/` from `path` before calling `Uri.resolve`, preventing the path from being treated as absolute (which would discard the base URL's path segment if it had one).
- Returns the fully-qualified URL string, e.g. `resolveUrl('/ideas/')` with `BACKEND_BASE_URL=https://api.example.com/v1/` → `'https://api.example.com/v1/ideas/'`.

This class is the **single source of truth** for all URLs; no other file hard-codes a domain.

---

### 4.4 `lib/theme/theme.dart`

**Role:** Application-wide Material 3 theme.

```dart
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: const Color(0xFF1565C0),   // blue-800
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(centerTitle: true, elevation: 0),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Color(0xFF90CAF9),          // blue-200
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
);
```

**Key parameters:**
- `colorSchemeSeed` — uses Material 3 tonal palette generation; the entire colour scheme (primary, secondary, surface, background, error, etc.) is derived from a single seed colour.
- `labelBehavior: onlyShowSelected` — keeps the bottom navigation bar compact; inactive tab labels are hidden.
- `elevation: 0` on the AppBar — flat, edge-to-edge appearance.

---

### 4.5 `lib/navigation/tab_item.dart`

**Role:** Data model for bottom navigation tabs.

```dart
class TabItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String path;

  static const List<TabItem> tabs = [ ... ];
}
```

**Static tab list:**

| Index | Label | Path | Icon (inactive / active) |
|---|---|---|---|
| 0 | Home | `/` | `home_outlined` / `home` |
| 1 | Ideas | `/ideas/` | `lightbulb_outlined` / `lightbulb` |
| 2 | Posts | `/posts/` | `article_outlined` / `article` |
| 3 | Login | `/auth/login` | `login_outlined` / `login` |
| 4 | Register | `/auth/register` | `person_add_outlined` / `person_add` |

All paths are relative; they are resolved against `BACKEND_BASE_URL` at load time via `Env.resolveUrl`.

---

### 4.6 `lib/screens/shell_screen.dart`

**Role:** Main scaffold. The only stateful screen in the app; manages tab state, back-button handling, and drawer navigation.

**State:**
- `int _currentIndex` — index of the active bottom navigation tab.
- `List<GlobalKey<WebViewScreenState>> _mobileKeys` — one key per tab for the native WebView variant. Allows `ShellScreen` to call imperative methods on each WebView (`canGoBack`, `goBack`, `loadPath`).
- `List<GlobalKey<WebIframeScreenState>> _webKeys` — same concept for the web iframe variant.

**Back-button handling (`_onWillPop`):**
```
if (web)  → always allow the OS to handle back (browser manages history)
else      → ask active WebView if it can go back
           → if yes: navigate back inside WebView, consume the event
           → if no:  allow the event to propagate (exit/pop)
```
This is wired to `PopScope(canPop: false, onPopInvokedWithResult: ...)`, the Flutter 3.x replacement for the deprecated `WillPopScope`.

**Body rendering (conditional compilation pattern):**
```dart
body: kIsWeb
    ? WebIframeScreen(key: _webKeys[_currentIndex], path: ...)
    : IndexedStack(
        index: _currentIndex,
        children: [ WebViewScreen(...) × TabItem.tabs.length ],
      ),
```
- On **web**: only the active tab is rendered as an `<iframe>`.
- On **mobile/desktop**: all tabs are pre-built inside an `IndexedStack`; switching tabs is O(1) and preserves WebView scroll/session state.

**Tab reload behaviour:**  
Tapping the currently-active tab triggers `loadPath` with the tab's canonical path, effectively reloading the page — matching common mobile UX conventions.

**Drawer:**
- Header with brand colour from `Theme.of(context).colorScheme.primaryContainer`.
- Settings and About navigate to full-screen routes via `Navigator.push`.
- Login and Register load a path in the current WebView tab without leaving the shell.

---

### 4.7 `lib/screens/about_screen.dart`

**Role:** Static informational screen shown from the drawer.

Displays:
- App title (`Ideas2invest`)
- Version string (`1.0.0`)
- One-paragraph product description
- Copyright notice

No business logic; purely presentational. Pushed onto the Navigator stack by `ShellScreen._openDrawerRoute`.

---

### 4.8 `lib/screens/settings_screen.dart`

**Role:** Placeholder settings screen.

Currently exposes three tiles:
- **Dark Mode** — `SwitchListTile` with `onChanged: null` (disabled; labelled "Coming soon").
- **Clear Cache** — `ListTile` with no tap handler yet (placeholder).
- **Version** — `ListTile` displaying `1.0.0`.

No state management or persistence. Designed to be extended in future iterations.

---

### 4.9 `lib/web/webview_screen.dart`

**Role:** Native WebView screen used on Android, iOS, and desktop platforms.

**Widget type:** `StatefulWidget` with a `public` state class (`WebViewScreenState`) so that `ShellScreen` can call its methods via `GlobalKey`.

**Controller setup (in `initState`):**
```dart
_controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(NavigationDelegate(
    onPageStarted: (_) => setState(() => _isLoading = true),
    onPageFinished: (_) => setState(() => _isLoading = false),
    onNavigationRequest: (request) {
      if (UrlHelper.isExternal(request.url, Env.backendBaseUrl)) {
        launchUrl(Uri.parse(request.url), mode: LaunchMode.externalApplication);
        return NavigationDecision.prevent;
      }
      return NavigationDecision.navigate;
    },
  ))
  ..loadRequest(Uri.parse(Env.resolveUrl(widget.path)));
```

| Setting | Value | Rationale |
|---|---|---|
| `JavaScriptMode.unrestricted` | JS fully enabled | Required by the Ideas2Invest SPA |
| `onNavigationRequest` | Intercepts every navigation | Redirects external links to the OS browser |
| `LaunchMode.externalApplication` | Browser, not in-app | Prevents the WebView from straying off-domain |

**Public API exposed to `ShellScreen`:**
| Method | Description |
|---|---|
| `canGoBack()` | Wraps `_controller.canGoBack()` |
| `goBack()` | Wraps `_controller.goBack()` |
| `loadPath(String path)` | Navigates to `Env.resolveUrl(path)` |

**UI:**  
`Stack` containing:
1. `RefreshIndicator` wrapping `WebViewWidget` — pull-to-refresh calls `_controller.reload()`.
2. A `SpinKitFadingCircle` overlay shown while `_isLoading` is `true`.

---

### 4.10 `lib/web/web_iframe_screen.dart`

**Role:** Web-only screen that renders the backend inside an HTML `<iframe>`.

**Conditionally compiled:** this file is selected by `web_iframe_screen_export.dart` only when `dart.library.html` is available (i.e., when compiling for the browser).

**Implementation details:**
```dart
_viewType = 'iframe-${widget.path.hashCode}-${identityHashCode(this)}';
_iframe = html.IFrameElement()
  ..src = Env.resolveUrl(widget.path)
  ..style.border = 'none'
  ..style.width = '100%'
  ..style.height = '100%'
  ..allow = 'autoplay; clipboard-write; encrypted-media'
  ..setAttribute('allowfullscreen', 'true');

ui_web.platformViewRegistry.registerViewFactory(_viewType, (_) => _iframe);
```

- Each `WebIframeScreen` instance generates a **unique `_viewType` string** (using `path.hashCode` + `identityHashCode`) to avoid view-factory registration conflicts if multiple instances are ever created.
- `ui_web.platformViewRegistry` is the Flutter Web API for embedding arbitrary HTML elements.
- The iframe is wrapped in `SizedBox.expand` → `HtmlElementView` to fill the available space.

**Public API** (mirrors `WebViewScreenState`):
| Method | Behaviour |
|---|---|
| `loadPath(String path)` | Sets `_iframe.src` directly |
| `canGoBack()` | Always returns `false`; the browser handles history |
| `goBack()` | No-op |

---

### 4.11 `lib/web/web_iframe_screen_stub.dart`

**Role:** Non-web stub implementing the same public API as `web_iframe_screen.dart`.

Used on platforms where `dart.library.html` is unavailable (Android, iOS, macOS, Linux, Windows).  
`ShellScreen` never actually instantiates this on non-web platforms (it uses `WebViewScreen` instead and guards with `kIsWeb`), but the stub is required so that the code **compiles** on all targets.

`loadPath`, `canGoBack`, and `goBack` are all no-ops or trivial returns.  
`build` returns a centered `Text('Not supported on this platform')`.

---

### 4.12 `lib/web/web_iframe_screen_export.dart`

**Role:** Conditional export that selects the correct `WebIframeScreen` implementation at compile time.

```dart
export 'web_iframe_screen_stub.dart'
    if (dart.library.html) 'web_iframe_screen.dart';
```

This is the standard **Dart conditional import/export pattern** for platform-specific code.  
Every consumer imports only this file; the correct concrete implementation is resolved automatically by the Dart compiler based on the target platform.

---

### 4.13 `lib/web/url_helper.dart`

**Role:** Pure-logic utility for URL classification.

```dart
class UrlHelper {
  static bool isExternal(String url, String backendBaseUrl) {
    final linkUri = Uri.tryParse(url);
    final baseUri = Uri.tryParse(backendBaseUrl);
    if (linkUri == null || baseUri == null) return true;
    return linkUri.host.isNotEmpty && linkUri.host != baseUri.host;
  }
}
```

**Logic table:**

| Input URL | Result | Reason |
|---|---|---|
| `https://example.com/page` | `false` | Same host as base |
| `https://other.com/page` | `true` | Different host |
| `/relative/path` | `false` | Empty host = same origin |
| `not a url ::::` | `true` | Parse failure → treated as external (safe default) |

The private constructor `UrlHelper._()` prevents instantiation; all methods are static.  
Fully unit-tested in `test/unit_test.dart`.

---

## 5. Android Platform (`android/`)

### `android/app/src/main/AndroidManifest.xml`

| Attribute | Value | Significance |
|---|---|---|
| `<uses-permission INTERNET>` | Required | Without this, the WebView cannot make network requests |
| `android:label` | `Ideas2invest` | App name displayed on the launcher |
| `android:usesCleartextTraffic` | `false` | Disallows unencrypted HTTP traffic (HTTPS only) |
| `android:hardwareAccelerated` | `true` | Required for smooth WebView rendering |
| `android:windowSoftInputMode` | `adjustResize` | WebView inputs resize the window rather than hiding behind the keyboard |
| `android:launchMode` | `singleTop` | Prevents duplicate activity instances when the app is launched from a notification |

### `android/app/build.gradle.kts`

- `compileSdk`, `minSdk`, `targetSdk` are delegated to `flutter.*` values, keeping them in sync with the Flutter SDK's recommendations.
- `sourceCompatibility` / `targetCompatibility` / `jvmTarget` all set to `JavaVersion.VERSION_17`.
- Release signing currently uses the debug key — a production deployment must supply a proper keystore.

### `android/app/src/main/kotlin/com/example/ideas2invest_mobile/MainActivity.kt`

```kotlin
class MainActivity : FlutterActivity()
```

A single-line class. All Android hosting behaviour (engine lifecycle, plugin registration, back button, lifecycle events) is inherited from `FlutterActivity`.  
No platform channel or custom Android code is needed at this stage.

### `android/app/src/debug/AndroidManifest.xml` / `android/app/src/profile/AndroidManifest.xml`

Contain only the Internet permission override, enabling the Flutter debugger and profiler network connections during development.

### `android/app/src/main/res/`

| File / directory | Purpose |
|---|---|
| `drawable/launch_background.xml` | Default white splash screen (pre-API 31) |
| `drawable-v21/launch_background.xml` | Splash screen using Android vector drawables (API 21+) |
| `values/styles.xml` | Defines `LaunchTheme` and `NormalTheme` |
| `values-night/styles.xml` | Dark-mode override for `NormalTheme` |
| `mipmap-*/ic_launcher.png` | Launcher icons at hdpi / mdpi / xhdpi / xxhdpi / xxxhdpi densities |

### `android/build.gradle.kts` / `android/settings.gradle.kts` / `android/gradle.properties`

Root-level Gradle project configuration. Applies the Flutter Gradle plugin and sets Kotlin/Android plugin repositories. `gradle.properties` sets `android.useAndroidX=true`.

### `android/gradle/wrapper/gradle-wrapper.properties`

Pins the Gradle distribution URL, ensuring all developers and CI use the same Gradle version.

---

## 6. iOS Platform (`ios/`)

### `ios/Runner/AppDelegate.swift`

```swift
@main
class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
```

- Inherits `FlutterAppDelegate` to handle app lifecycle events and plugin calls.
- Implements `FlutterImplicitEngineDelegate` to register plugins on the lazily-created Flutter engine.
- This is the entry point for the Flutter iOS runner.

### `ios/Runner/SceneDelegate.swift`

Manages UIScene-based multi-window support (required since iOS 13). Delegates scene connection and disconnection lifecycle to the UIKit scene system.

### `ios/Runner/Info.plist`

iOS app metadata: bundle identifier, display name, version, supported interface orientations, and launch storyboard name. No custom privacy keys are required since the app only uses WebView and networking.

### `ios/Runner/Runner-Bridging-Header.h`

Empty bridging header. Allows Objective-C symbols to be used from Swift if needed in the future; currently contains no declarations.

### `ios/Flutter/Debug.xcconfig` / `Release.xcconfig`

Include Flutter-generated configuration files that inject build variables (Flutter SDK path, entitlements, etc.) into the Xcode build system.

### `ios/Runner.xcodeproj/project.pbxproj`

Xcode project file. Defines build targets, source files, frameworks, build phases, and build settings. Modified automatically by Xcode and the Flutter toolchain.

### `ios/Runner/Assets.xcassets/`

| Asset | Description |
|---|---|
| `AppIcon.appiconset/` | App icons from 20×20 @1x through 1024×1024 @1x for all iOS device classes |
| `LaunchImage.imageset/` | Launch screen placeholder images (@1x / @2x / @3x) |

### `ios/RunnerTests/RunnerTests.swift`

Minimal XCTest stub. Tests the existence of the test bundle; no custom test logic.

---

## 7. Web Platform (`web/`)

### `web/index.html`

The single HTML page that bootstraps the Flutter Web application.

```html
<base href="$FLUTTER_BASE_HREF">
<script src="flutter_bootstrap.js" async></script>
```

- `$FLUTTER_BASE_HREF` is replaced at build time by `flutter build web --base-href=...`.
- `flutter_bootstrap.js` (generated at build time) loads and initialises the Flutter engine in the browser.
- Sets `apple-mobile-web-app-capable` for PWA-like iOS homescreen mode.

### `web/manifest.json`

Progressive Web App manifest.

| Field | Value |
|---|---|
| `display` | `standalone` — hides the browser chrome |
| `theme_color` | `#0175C2` — Flutter's default blue |
| `background_color` | `#0175C2` |
| `orientation` | `portrait-primary` |
| `icons` | 192px, 512px (standard + maskable variants) |

### `web/favicon.png`

Browser tab icon.

### `web/icons/`

PWA icon set at 192×192 and 512×512 in standard and maskable variants (maskable icons provide the safe zone required by Android adaptive icon masks).

---

## 8. macOS Platform (`macos/`)

### `macos/Runner/MainFlutterWindow.swift`

Creates the `FlutterViewController` and passes it to the macOS window. This is the macOS equivalent of iOS's `AppDelegate`.

### `macos/Runner/AppDelegate.swift`

`NSApplicationDelegate` implementation that terminates the app when the last window is closed (`applicationShouldTerminateAfterLastWindowClosed` returns `true`).

### `macos/Flutter/GeneratedPluginRegistrant.swift`

Auto-generated file. Registers all Flutter plugins for the macOS runner. Regenerated by `flutter pub get`.

### `macos/Runner/Configs/`

| File | Purpose |
|---|---|
| `AppInfo.xcconfig` | App name, bundle ID, version |
| `Debug.xcconfig` | Debug-only build settings |
| `Release.xcconfig` | Release build settings |
| `Warnings.xcconfig` | Compiler warning flags |

### `macos/Runner/DebugProfile.entitlements` / `Release.entitlements`

macOS sandbox entitlements.  
`DebugProfile.entitlements` grants outgoing network connections required for hot-reload and the WebView; `Release.entitlements` restricts to only what is needed in production.

---

## 9. Linux Platform (`linux/`)

### `linux/runner/main.cc`

```cpp
int main(int argc, char** argv) {
  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
```

GLib/GTK entry point. Creates a `MyApplication` (GObject) and runs it through the GLib main loop.

### `linux/runner/my_application.cc` / `my_application.h`

Implements `MyApplication`, a `GtkApplication` subclass that:
- Creates the `FlutterViewController` and `FlutterWindow`.
- Attaches the Flutter engine to the GTK window.
- Handles the GLib `activate` signal.

### `linux/flutter/CMakeLists.txt` / `linux/flutter/generated_plugin_registrant.cc` / `.h` / `generated_plugins.cmake`

CMake and C++ plugin registration boilerplate generated by the Flutter toolchain.

---

## 10. Windows Platform (`windows/`)

### `windows/runner/main.cpp`

Win32 `wWinMain` entry point.  
- Initialises COM (`CoInitializeEx`).
- Creates a `FlutterWindow` with a default size of 1280×720.
- Runs the Win32 message pump.

### `windows/runner/flutter_window.cpp` / `.h`

Wraps `FlutterViewController` inside a `Win32Window`.  
Handles `WM_CREATE` (engine setup) and `WM_DESTROY` (shutdown).

### `windows/runner/win32_window.cpp` / `.h`

Base Win32 window implementation: creates and registers the window class, manages the HWND, dispatches messages.

### `windows/runner/utils.cpp` / `.h`

Utility functions for the Windows runner:
- `GetCommandLineArguments()` — converts the Win32 command line string to `std::vector<std::string>`.
- `CreateAndAttachConsole()` — allocates a console window for debug output.

### `windows/runner/Runner.rc` / `resource.h`

Win32 resource file and header. Embeds the app icon and version information into the PE binary.

### `windows/runner/runner.exe.manifest`

Application manifest requesting `dpiAwareness: PerMonitorV2` for crisp rendering on high-DPI displays.

### `windows/runner/resources/app_icon.ico`

`.ico` file embedded into the Windows executable. Displayed in Explorer, the taskbar, and the title bar.

---

## 11. Assets (`assets/`)

### `assets/icons/app_icon.png`

The application icon used by platform-specific tooling (e.g., `flutter_launcher_icons`) to generate per-platform icon files.  
Declared as a Flutter asset in `pubspec.yaml` so it is bundled in the app archive.

---

## 12. Tests (`test/`)

### `test/unit_test.dart`

Pure Dart unit tests (no widget rendering). Covers the two most important pure-logic modules:

**`UrlHelper.isExternal` group:**

| Test | Input | Expected |
|---|---|---|
| same host is not external | `https://example.com/page` vs base `https://example.com/` | `false` |
| different host is external | `https://other.com/page` | `true` |
| empty host (relative) is not external | `/page` | `false` |
| malformed URL is treated as external | `not a url ::::` | `true` |

**`TabItem` group:**

| Test | Assertion |
|---|---|
| has exactly 5 tabs | `TabItem.tabs.length == 5` |
| all tab paths start with `/` | each `path.startsWith('/')` |
| tab labels are unique | label set size equals tab count |

These tests do **not** require a device or Flutter engine; they run with `flutter test` in under one second.

---

### `test/widget_test.dart`

Widget tests that exercise the two pure-Flutter screens using `WidgetTester`.

**`AboutScreen` group:**

| Test | Assertion |
|---|---|
| renders app title and version | Finds `'Ideas2invest'` and `'Version 1.0.0'` in the widget tree |

**`SettingsScreen` group:**

| Test | Assertion |
|---|---|
| renders settings tiles | Finds `'Dark Mode'`, `'Clear Cache'`, and `'Version'` list tiles |

These tests do not touch `WebViewScreen` or `ShellScreen` (which depend on native platform channels and would require platform-channel mocking). They verify that the pure-widget screens render without throwing.

---

## 13. Dependency Overview

```
ideas2invest_mobile
│
├── flutter (SDK)
│   └── Material Design widget library, rendering engine, platform channels
│
├── webview_flutter ^4.10.0
│   ├── webview_flutter_android   (Android WebView2 / Chromium)
│   ├── webview_flutter_wkwebview (iOS/macOS WKWebView)
│   └── Provides: WebViewController, WebViewWidget, NavigationDelegate
│
├── url_launcher ^6.3.1
│   └── Opens URLs in the platform's default browser / app
│
├── flutter_dotenv ^5.2.1
│   └── Parses .env files and exposes them via dotenv.env Map
│
└── flutter_spinkit ^5.2.1
    └── Pre-built loading animation widgets (SpinKitFadingCircle used)
```

---

## 14. Architecture Diagram

```
┌──────────────────────────────────────────────────────┐
│                  Flutter Application                  │
│                                                        │
│  main.dart  ──►  app.dart  ──►  ShellScreen           │
│                                    │                   │
│              ┌─────────────────────┤                   │
│              │     Bottom Nav Bar  │                   │
│              │  (TabItem.tabs)     │                   │
│              └─────────────────────┤                   │
│                                    │                   │
│               ┌────────────────────┤                   │
│               │                    │                   │
│         kIsWeb?                    │                   │
│        ┌──────┴──────┐             │                   │
│       YES            NO            │                   │
│        │              │            │                   │
│  WebIframeScreen  IndexedStack     │                   │
│  (dart:html       [WebViewScreen]  │                   │
│   <iframe>)       × 5 tabs         │                   │
│        │              │            │                   │
│        └──────┬────────┘           │                   │
│               │                    │                   │
│          Env.resolveUrl()          │                   │
│               │                    │                   │
│               ▼                    │                   │
│      BACKEND_BASE_URL + path       │                   │
│               │                    │                   │
└───────────────┼────────────────────┘                   │
                │                                         │
                ▼                                         │
    ╔═════════════════════════╗                           │
    ║  Ideas2Invest Web Platform  ║                       │
    ║  (Django / React / etc.)    ║                       │
    ╚═════════════════════════╝                           │
                                                          │
    ◄── External links intercepted by UrlHelper ──────────┘
        → opened in system browser via url_launcher
```

---

## 15. Data Flow

### App startup
```
1. main() called
2. WidgetsFlutterBinding.ensureInitialized()
3. dotenv.load('.env')  →  BACKEND_BASE_URL stored in memory
4. runApp(Ideas2InvestApp)
5. MaterialApp built with appTheme + ShellScreen as home
6. ShellScreen builds IndexedStack of WebViewScreens (mobile)
   or single WebIframeScreen (web)
7. Each WebView loads Env.resolveUrl(tab.path)
   → e.g. https://ideas2invest-self.vercel.app/ for tab 0
```

### Tab switch
```
1. User taps NavigationDestination[i]
2. setState(() => _currentIndex = i)
3. IndexedStack reveals child[i] (already loaded, state preserved)
```

### In-tab navigation
```
1. User taps a link inside the WebView
2. NavigationDelegate.onNavigationRequest fires
3. UrlHelper.isExternal(url, backendBaseUrl)?
   YES → launchUrl(url, externalApplication)  → prevent in-app navigation
   NO  → NavigationDecision.navigate          → WebView handles it
```

### Back gesture (mobile)
```
1. PopScope.onPopInvokedWithResult fires (didPop = false)
2. _mobileKeys[_currentIndex].currentState?.canGoBack()
   YES → goBack()  → return false (consume event)
   NO  → return true → Navigator.maybePop() → exit app / pop screen
```

---

## 16. Security Considerations

| Concern | Mitigation |
|---|---|
| `.env` in source control | `.env` is `.gitignore`d; only `.env.example` (no real values) is committed |
| HTTPS only | `android:usesCleartextTraffic="false"` prevents HTTP downgrade on Android |
| JavaScript injection | `JavaScriptMode.unrestricted` is intentional — the app is a first-party shell for a trusted backend |
| External link navigation | `UrlHelper.isExternal` intercepts and redirects all off-domain navigation to the system browser |
| API credentials | No credentials are embedded in the app; the backend handles authentication |
| **Release signing** | **⚠️ CRITICAL — `android/app/build.gradle.kts` currently signs release builds with the debug keystore. Before submitting to any app store or distributing a production APK, a dedicated release keystore must be generated, stored securely (never committed to source control), and referenced via Gradle signing configuration or a CI secret.** |
