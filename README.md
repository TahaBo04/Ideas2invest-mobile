# Ideas2invest Mobile

**Ideas2invest** is a B2B SaaS platform that acts as an intermediary between
businesses and investors on one side and freelancers, engineers, PhD students,
and other innovators on the other. It empowers innovators to showcase their
ideas safely — without risk of theft — through a secure, NDA-backed payment
model and optional brevet/patent support.

This repository contains the **cross-platform Flutter companion app** (iOS,
Android, and Web) that wraps the Ideas2invest web platform in a native mobile
shell with bottom-tab navigation, a drawer menu, and platform-native behaviours
such as pull-to-refresh and back-button handling.

> 🏆 **Presented at JNITI 2026** — *Innovation as a Development Vector*

---

## Table of Contents

1. [Platform Overview](#platform-overview)
2. [Screenshots](#screenshots)
3. [Project Structure](#project-structure)
4. [Getting Started](#getting-started)
5. [How It Works](#how-it-works)
6. [JNITI 2026 Presentation Plan](#jniti-2026-presentation-plan)
7. [Release Checklist](#release-checklist)
8. [Dependencies](#dependencies)
9. [License](#license)

---

## Platform Overview

### Problem

Innovators — whether freelancers, engineers, researchers, or entrepreneurs —
often hesitate to share breakthrough ideas for fear of intellectual theft. At
the same time, businesses and investors struggle to discover and evaluate early-
stage innovation before committing resources.

### Solution

Ideas2invest solves both sides of the equation:

| Stakeholder | Benefit |
|---|---|
| **Innovators** | Publish ideas with full confidentiality controls; monetise access to detailed specs |
| **Businesses / Investors** | Pay to unlock detailed idea dossiers; NDA signed automatically at checkout |
| **Platform** | Secure escrow of knowledge; optional national & international brevet filing support |

### Key Features

- 🔒 **Confidential idea publishing** — public teaser + gated full disclosure
- 💳 **Pay-to-access with NDA coupling** — payment automatically triggers a
  legally binding NDA between the buyer and the innovator
- 📜 **Brevet / Patent assistance** *(under study)* — help innovators register
  national and international patents to legitimise and protect their work
- 🤝 **B2B matchmaking** — structured workflow for investor due-diligence and
  business–innovator collaboration
- 📱 **Mobile & Web** — fully responsive web platform plus this native mobile
  app

---

## Screenshots

> ⚠️ **Screenshots not yet committed.** Save each image to
> `docs/screenshots/<filename>` and the links below will resolve automatically.
> Aim for at least one screenshot per section.

### Web Platform

| Section | File to add |
|---------|-------------|
| Home / Landing page | `docs/screenshots/web_home.png` |
| Ideas listing | `docs/screenshots/web_ideas.png` |
| Idea detail — teaser view (free) | `docs/screenshots/web_idea_detail_teaser.png` |
| Idea detail — unlocked (post NDA + payment) | `docs/screenshots/web_idea_detail_unlocked.png` |
| NDA + Payment flow | `docs/screenshots/web_payment_nda.png` |
| Posts / community feed | `docs/screenshots/web_posts.png` |
| Authentication (Login / Register) | `docs/screenshots/web_auth.png` |

<!-- Once the files above exist, uncomment and use these image tags:
![Web – Home](docs/screenshots/web_home.png)
![Web – Ideas](docs/screenshots/web_ideas.png)
![Web – Idea Detail (Teaser)](docs/screenshots/web_idea_detail_teaser.png)
![Web – Idea Detail (Unlocked)](docs/screenshots/web_idea_detail_unlocked.png)
![Web – NDA & Payment](docs/screenshots/web_payment_nda.png)
![Web – Posts Feed](docs/screenshots/web_posts.png)
![Web – Auth](docs/screenshots/web_auth.png)
-->

---

### Mobile App (Flutter)

| Section | File to add |
|---------|-------------|
| Home tab | `docs/screenshots/mobile_home.png` |
| Ideas tab | `docs/screenshots/mobile_ideas.png` |
| Posts tab | `docs/screenshots/mobile_posts.png` |
| Login screen | `docs/screenshots/mobile_login.png` |
| Navigation drawer | `docs/screenshots/mobile_drawer.png` |
| Settings screen | `docs/screenshots/mobile_settings.png` |

<!-- Once the files above exist, uncomment and use these image tags:
![Mobile – Home](docs/screenshots/mobile_home.png)
![Mobile – Ideas](docs/screenshots/mobile_ideas.png)
![Mobile – Posts](docs/screenshots/mobile_posts.png)
![Mobile – Login](docs/screenshots/mobile_login.png)
![Mobile – Drawer](docs/screenshots/mobile_drawer.png)
![Mobile – Settings](docs/screenshots/mobile_settings.png)
-->

---

## Project Structure

```
.
├── .env.example                        # Environment template
├── analysis_options.yaml               # Dart lint rules
├── pubspec.yaml                        # Flutter dependencies
├── assets/
│   └── icons/
│       └── app_icon.png                # App icon (replace before release)
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml         # INTERNET permission included
├── ios/
│   └── Runner/
│       └── Info.plist                  # ATS configured (HTTPS only)
├── lib/
│   ├── main.dart                       # Entry point – loads .env, runs app
│   ├── app.dart                        # MaterialApp with Material 3 theme
│   ├── config/
│   │   └── env.dart                    # Reads BACKEND_BASE_URL, normalises trailing slash
│   ├── theme/
│   │   └── theme.dart                  # App-wide Material 3 theme (blue #1565C0)
│   ├── navigation/
│   │   └── tab_item.dart               # Tab definitions (label, icon, path)
│   ├── screens/
│   │   ├── shell_screen.dart           # Main shell: tabs + drawer + back-button logic
│   │   ├── settings_screen.dart        # Native Settings page
│   │   └── about_screen.dart           # Native About page
│   └── web/
│       ├── webview_screen.dart         # Mobile WebView with pull-to-refresh & spinner
│       ├── web_iframe_screen.dart      # Web-platform iframe (dart:html, web-only)
│       ├── web_iframe_screen_stub.dart # Stub for non-web platforms
│       ├── web_iframe_screen_export.dart # Conditional export (web vs. mobile)
│       └── url_helper.dart             # External-link detection helper
└── test/
    └── unit_test.dart                  # Unit tests for URL helpers and tab definitions
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

# Web
flutter run -d chrome
```

---

## How It Works

### Navigation

The app provides five bottom-navigation tabs, each loading a corresponding
section of the backend:

| Tab          | Icon               | Backend Path      |
|--------------|--------------------|-------------------|
| Home         | `home`             | `/`               |
| Ideas        | `lightbulb`        | `/ideas/`         |
| Posts        | `article`          | `/posts/`         |
| Login        | `login`            | `/auth/login`     |
| Register     | `person_add`       | `/auth/register`  |

A **drawer menu** provides additional access to:

- **Settings** – native Flutter settings page (dark mode toggle, cache clear).
- **About** – native Flutter about page (version, copyright).

### External Links

Any link whose host differs from `BACKEND_BASE_URL` is opened in the system
browser via `url_launcher`, keeping the user inside the app for all internal
navigation.

### Back Button

On Android, pressing the hardware back button:

1. If the current WebView can go back → navigates back within the WebView.
2. Otherwise → exits the app (default system behaviour).

### Pull-to-Refresh

Each WebView tab supports pull-to-refresh, which reloads the current page.

### Loading Indicator

A `SpinKitFadingCircle` spinner is shown while any WebView page is loading.

### Web Platform Support

On Flutter Web the app renders the backend inside an HTML `<iframe>` (via
`dart:html`) rather than a WebView widget, providing full browser-native
behaviour.

---

## JNITI 2026 Presentation Plan

> This section outlines the recommended structure for a project demo / report
> to be presented at the **JNITI 2026** hackathon (*Innovation as a Development
> Vector*).

### Recommended Presentation Structure

```
1. Cover Slide
   ├─ Project name & logo
   ├─ Team name / members
   └─ Hackathon: JNITI 2026 — Innovation as a Development Vector

2. Problem Statement (2 min)
   ├─ Innovators fear idea theft → ideas stay locked in drawers
   ├─ Investors/businesses lack structured access to early-stage ideas
   └─ Existing platforms offer no legal protection at point of disclosure

3. Our Solution — Ideas2invest (3 min)
   ├─ B2B SaaS intermediary platform
   ├─ Public teaser + gated full disclosure model
   ├─ Pay-to-access + automatic NDA coupling
   └─ Optional brevet/patent filing support

4. Live Demo — Web Platform (5 min)
   ├─ [SCREENSHOT: web_home.png]           Landing page & value proposition
   ├─ [SCREENSHOT: web_ideas.png]          Browse published ideas
   ├─ [SCREENSHOT: web_idea_detail_teaser.png]  Teaser view (free)
   ├─ [SCREENSHOT: web_payment_nda.png]    Payment + NDA signing flow
   ├─ [SCREENSHOT: web_idea_detail_unlocked.png] Unlocked full disclosure
   └─ [SCREENSHOT: web_posts.png]          Community posts & discussion feed

5. Live Demo — Mobile App (3 min)
   ├─ [SCREENSHOT: mobile_home.png]        Home tab
   ├─ [SCREENSHOT: mobile_ideas.png]       Ideas tab (browse + access)
   ├─ [SCREENSHOT: mobile_posts.png]       Posts / feed tab
   ├─ [SCREENSHOT: mobile_login.png]       Authentication
   └─ [SCREENSHOT: mobile_drawer.png]      Navigation drawer

6. Technical Architecture (2 min)
   ├─ Backend: [your stack] serving REST API + web frontend
   ├─ Mobile: Flutter (iOS / Android / Web) — native wrapper
   ├─ Security: HTTPS-only (ATS + HSTS), NDA stored server-side
   └─ Payments: [payment provider] → triggers NDA generation

7. Business Model (2 min)
   ├─ Revenue streams: platform fee on each unlocked idea
   ├─ Premium tier: brevet/patent filing assistance
   └─ Future: escrow + milestone-based investment releases

8. Roadmap (1 min)
   ├─ v1.0 (current): idea publishing + pay-to-access + NDA
   ├─ v1.1 (planned): national brevet filing integration
   └─ v1.2 (planned): international PCT patent support

9. Q&A
```

### Demo Checklist

Before the presentation, verify:

- [ ] Backend is live and accessible at `BACKEND_BASE_URL`
- [ ] At least 3 sample ideas are published (1 free teaser, 2 fully locked)
- [ ] Payment + NDA flow has been tested end-to-end
- [ ] Flutter app is installed on a physical Android device for demo
- [ ] Screenshots in `docs/screenshots/` are up to date
- [ ] Slide deck references the latest screenshots

---

## Release Checklist

### Android (Google Play Store)

1. **Bundle ID** – update `applicationId` in `android/app/build.gradle`
   (e.g. `com.ideas2invest.mobile`).
2. **App Icon** – replace `assets/icons/app_icon.png` with your production
   icon and run
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
3. **Signing** – configure automatic signing with your Apple Developer account
   in Xcode.
4. **Build IPA**:
   ```bash
   flutter build ipa --release
   ```
5. Upload via Xcode Organizer or `xcrun altool` to App Store Connect.

---

## Dependencies

| Package            | Purpose                                      |
|--------------------|----------------------------------------------|
| `webview_flutter`  | In-app WebView (mobile)                      |
| `url_launcher`     | Open external links in system browser        |
| `flutter_dotenv`   | Load `.env` configuration at runtime         |
| `flutter_spinkit`  | Animated loading spinner                     |

---

## License

This project is private. See the repository owner for licensing details.
