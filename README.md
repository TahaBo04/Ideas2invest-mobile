# Ideas2Invest Mobile

**Ideas2Invest Mobile** is the official cross-platform Flutter companion app for the **Ideas2Invest platform** — a B2B SaaS innovation marketplace that connects **innovators, engineers, researchers, freelancers, students, and entrepreneurs** with **investors, companies, and industrial actors looking for new technologies, processes, and business opportunities**.

The core idea behind the platform is simple:

> **Valuable ideas should not remain hidden because of fear of theft**

Ideas2Invest allows innovators to publish ideas in a **controlled, monetizable, and legally framed environment**. Instead of forcing creators to reveal everything publicly, the platform enables a **two-layer disclosure model**:

- **Public teaser layer** for discovery
- **Private premium layer** containing the full technical, economic, and strategic content

This repository contains the **Flutter mobile application** that serves as the native mobile shell for the Ideas2Invest web platform on **Android, iOS, and Web**.

🏆 **Presented at JNITI 2026 — Innovation as a Development Vector**

---

# Table of Contents

1. Project Overview  
2. The Problem  
3. The Solution  
4. How the Platform Works  
5. Use Case Example  
6. Business Model  
7. Security and Intellectual Property Logic  
8. Mobile App Architecture  
9. Key Features  
10. Technical Stack  
11. Project Structure  
12. Installation  
13. Configuration  
14. Running the App  
15. Building the APK  
16. Testing  
17. JNITI 2026 Demo Flow  
18. Future Roadmap  
19. Author  
20. License  

---

# Project Overview

**Ideas2Invest** is a digital platform designed to transform **raw innovation into structured investment opportunity**.

It acts as an intermediary between two groups:

| Stakeholder | Role |
|---|---|
| Innovators | Publish promising ideas, inventions, technical concepts, or business projects |
| Investors / Companies | Discover, evaluate, unlock, and potentially fund or acquire these ideas |

The mobile app exists because innovation marketplaces must be **accessible everywhere**, not only from desktop environments.

The Flutter application provides:

- fast browsing of innovation opportunities
- mobile access to the web platform
- native-feeling navigation
- integration with mobile device behaviors

while the **web platform continues to host the core business logic**.

---

# The Problem

## Innovators fear idea theft

Many engineers, students, inventors, and researchers hesitate to share their ideas because revealing the full concept publicly can allow others to replicate or commercialize it.

## No structured marketplace for protected ideas

Platforms like:

- LinkedIn  
- GitHub  
- ResearchGate  
- crowdfunding platforms  

allow people to share **content or startups**, but they do **not allow people to safely monetize raw ideas themselves**.

## Investors discover ideas too late

Most investors only encounter ideas once they are already structured as startups, while the most valuable innovations often appear earlier as:

- engineering concepts
- industrial process ideas
- scientific innovations
- product ideas
- feasibility studies

Ideas2Invest aims to expose this **hidden innovation layer**.

---

# The Solution

Ideas2Invest introduces a **gated innovation marketplace**.

Instead of exposing the entire idea publicly, disclosure is structured in **two stages**.

## Public Teaser

Visible to everyone:

- title
- short description
- industry category
- value proposition

Example:

```
Cactus-based leather alternative
```

This allows discovery without revealing the entire method.

## Premium Unlock

After payment and agreement conditions, the investor gains access to:

- full feasibility study
- process engineering details
- technical calculations
- industrial implementation plan
- project roadmap
- economic assumptions

This converts the idea from a **concept** into a **potential investment dossier**.

---

# How the Platform Works

## Step 1 — Innovator submits an idea

Innovators publish:

- title
- teaser description
- domain or industry
- unlock price

Example:

Title: Hydrogen Compression Heat Recovery System

Teaser:
A system that captures the thermal energy generated during hydrogen compression and reuses it to improve system efficiency.

Unlock price: 150 USD

---

## Step 2 — Investor browses opportunities

Investors explore ideas through:

- innovation categories
- trending projects
- new publications
- teaser descriptions

At this stage, investors see **enough information to evaluate interest**, but **not enough to reproduce the concept**.

---

## Step 3 — Investor unlocks the idea

If the investor is interested:

1. the investor pays the unlock fee  
2. platform records the access event  
3. the full technical documentation becomes available  

---

## Step 4 — Collaboration begins

Once unlocked, investors may:

- contact the innovator
- negotiate licensing
- fund development
- create a startup around the idea

---

# Use Case Example

## Public View

```
Making leather from cactus
```

Visible information:

- sustainability promise
- possible fashion applications
- material innovation concept

## Premium View

After unlocking:

- raw material processing method
- chemical treatment logic
- plant process description
- industrial equipment requirements
- production calculations
- estimated plant capacity
- preliminary economic analysis

---

# Business Model

Ideas2Invest monetizes innovation access through several mechanisms.

## Idea unlock fees

Investors pay to access full technical documentation.

Example:

Idea unlock price: $150  
Platform fee: 10-20%

## Patent / Brevet assistance

Future services may include assistance with:

- Moroccan brevet filing
- innovation documentation
- patent preparation workflows

## Premium investor tools

Potential premium features:

- advanced idea discovery
- investor dashboards
- innovation analytics
- early access to new ideas

---

# Security and Intellectual Property Logic

The platform uses **controlled disclosure**.

Key mechanisms:

- teaser-only public information
- paid access to full content
- access logging
- potential NDA workflow
- optional patent protection path

The goal is not absolute secrecy, but **structured and intentional disclosure**.

---

# Mobile App Architecture

The Flutter mobile app follows a **hybrid architecture**.

```
Flutter Mobile App
        │
        │ WebView
        ▼
Ideas2Invest Web Platform
        │
        ▼
Backend API + Database
```

This allows:

- fast mobile deployment
- reuse of the web platform
- consistent platform logic
- native navigation experience

---

# Key Features

- Cross-platform Flutter application
- Mobile WebView integration
- Bottom navigation tabs
- Drawer navigation menu
- Pull-to-refresh support
- External link detection
- Environment-based backend configuration
- Material 3 UI

---

# Technical Stack

Core technologies:

- Flutter
- Dart

Main packages:

| Package | Purpose |
|---|---|
| webview_flutter | Render the web platform inside the app |
| flutter_dotenv | Load backend configuration |
| url_launcher | Open external links |
| flutter_spinkit | Loading animations |

---

# Project Structure

```
.
├── .env.example
├── analysis_options.yaml
├── pubspec.yaml
├── assets/
│   └── icons/
│       └── app_icon.png
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── config/
│   ├── theme/
│   ├── navigation/
│   ├── screens/
│   └── web/
└── test/
```

---

# Installation

Clone the repository:

```
git clone https://github.com/TahaBo04/Ideas2Invest-mobile.git
cd Ideas2Invest-mobile
```

Install dependencies:

```
flutter pub get
```

---

# Configuration

Copy the environment template:

```
cp .env.example .env
```

Edit `.env`:

```
BACKEND_BASE_URL=https://ideas2invest-self.vercel.app/
```

---

# Running the App

Run locally:

```
flutter run
```

Run in Chrome:

```
flutter run -d chrome
```

---

# Building the APK

Generate Android APK:

```
flutter build apk --release
```

Output:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

# Testing

Run tests:

```
flutter test
```

---

# JNITI 2026 Demo Flow

Demo sequence:

1. Present the innovation marketplace concept  
2. Browse teaser ideas  
3. Show unlock mechanism  
4. Display full technical documentation  
5. Demonstrate the mobile application  

---

# Future Roadmap

Phase 1  
Core platform and mobile access

Phase 2  
NDA integration and improved access control

Phase 3  
Patent / brevet assistance workflow

Phase 4  
Investor dashboards and project funding tools

---

# Author

**Boulaamane Taha**  
EMI Process
École Mohammadia d’Ingénieurs  

Founder of the **Ideas2Invest concept**

---

# License

This project is currently private and under active development.
