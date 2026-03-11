# Ideas2invest Mobile

A Flutter mobile app (iOS + Android) that wraps the Ideas2invest website in a
native shell with bottom-tab navigation, a drawer menu, and platform-native
behaviors such as pull-to-refresh and proper back-button handling.

---

## Project Structure

```
.
├── .env.example                  # Environment template
├── analysis_options.yaml         # Dart lint rules
├── pubspec.yaml                  # Flutter dependencies
├── assets/
│   └── icons/
│       └── app_icon.png          # Placeholder app icon (replace before release)
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml   # INTERNET permission included
├── ios/
│   └── Runner/
│       └── Info.plist            # ATS configured (HTTPS only)
├── lib/
│   ├── main.dart                 # Entry point – loads .env, runs app
│   ├── app.dart                  # MaterialApp with Material 3 theme
│   ├── config/
│   │   └── env.dart              # Reads BACKEND_BASE_URL, normalises trailing slash
│   ├── theme/
│   │   └── theme.dart            # App-wide Material 3 theme
│   ├── navigation/
│   │   └── tab_item.dart         # Tab definitions (label, icon, path)
│   ├── screens/
│   │   ├── shell_screen.dart     # Main shell: tabs + drawer + back-button logic
│   │   ├── settings_screen.dart  # Native Settings page
│   │   └── about_screen.dart     # Native About page
│   └── web/
│       ├── webview_screen.dart   # WebView widget with loading indicator & pull-to-refresh
│       └── url_helper.dart       # External-link detection helper
└── test/
    └── unit_test.dart            # Unit tests for URL helpers and tab definitions
```

---

## Getting Started

### Prerequisites

| Tool    | Minimum version |
|---------|-----------------|
| Flutter | 3.x stable      |
| Dart    | ≥ 3.0.0         |

### 1. Clone & install

```bash
git clone <repo-url>
cd Ideas2invest-mobile
flutter pub get
```

### 2. Configure the environment

```bash
cp .env.example .env
```

Edit `.env` and set your backend URL:

```
BACKEND_BASE_URL=https://your-site.com/
```

> **Tip:** Always include a trailing slash. The app normalises it at runtime,
> but keeping it explicit avoids confusion.

### 3. Run

```bash
# Android
flutter run

# iOS (macOS only)
flutter run --device-id <ios-simulator-id>
```

---

## How It Works

### Navigation

The app has five bottom tabs, each loading a different path on the backend:

| Tab     | Path         |
|---------|--------------|
| Home    | `/`          |
| Explore | `/explore/`  |
| Feed    | `/feed/`     |
| Create  | `/create/`   |
| Account | `/account/`  |

A **drawer menu** provides access to:

- **Settings** – a native Flutter page (placeholder for future settings).
- **About** – a native Flutter page with app info.
- **Login** – loads `/login/` in the current WebView tab.
- **Register** – loads `/register/` in the current WebView tab.

### External Links

Any link whose host differs from `BACKEND_BASE_URL` is opened in the system
browser via `url_launcher`, keeping the user inside the app for internal
navigation.

### Back Button

On Android, pressing the hardware back button:

1. If the current WebView can go back → navigates back within the WebView.
2. Otherwise → exits the app (default system behavior).

### Pull-to-Refresh

Each WebView tab supports pull-to-refresh, which reloads the current page.

### Loading Indicator

A `SpinKitFadingCircle` spinner is shown while any WebView page is loading.

---

## Release Checklist

### Android (Google Play Store)

1. **Bundle ID** – update `applicationId` in `android/app/build.gradle`
   (e.g. `com.ideas2invest.mobile`).
2. **App Icon** – replace `assets/icons/app_icon.png` with your production
   icon and run a tool like
   [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
   to generate all densities.
3. **Signing** – create a keystore and configure `android/key.properties`:
   ```properties
   storePassword=<password>
   keyPassword=<password>
   keyAlias=upload
   storeFile=<path-to-keystore>
   ```
4. **Build AAB**:
   ```bash
   flutter build appbundle --release
   ```
5. Upload `build/app/outputs/bundle/release/app-release.aab` to Google Play
   Console.

### iOS (Apple App Store)

1. **Bundle ID** – update `PRODUCT_BUNDLE_IDENTIFIER` in Xcode → Runner →
   General (e.g. `com.ideas2invest.mobile`).
2. **App Icon** – provide a 1024×1024 icon in `ios/Runner/Assets.xcassets`.
3. **Signing** – configure automatic signing with your Apple Developer
   account in Xcode.
4. **Build IPA**:
   ```bash
   flutter build ipa --release
   ```
5. Upload via Xcode Organizer or `xcrun altool` to App Store Connect.

---

## Dependencies

| Package            | Purpose                                |
|--------------------|----------------------------------------|
| `webview_flutter`  | In-app WebView                         |
| `url_launcher`     | Open external links in system browser  |
| `flutter_dotenv`   | Load `.env` configuration at runtime   |
| `flutter_spinkit`  | Animated loading spinner               |

---

## License

This project is private. See the repository owner for licensing details.
