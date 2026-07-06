# DowgNut — Donut Shopping App

DowgNut is a Flutter donut shopping app with a bold, playful, graffiti-inspired brand system. The current implementation is mobile-first, uses Provider for local state, and ships as a Flutter Web/PWA build as well as standard Flutter platform targets.

Active source of truth:

```text
G:/DowgNut-Apps/donut-app
```

If you are an AI agent continuing this project, load the Hermes skill first:

```text
dowgnut-flutter-app
```

That skill contains the detailed architecture map, brand guide, mobile-first rules, and verification checklist.

---

## Current verified state

Recently verified on this machine:

```text
Flutter 3.27.1 stable
Dart 3.6.0
flutter analyze -> No issues found
flutter build web --release -> success
build warnings -> false
390x844 mobile viewport -> horizontalOverflow false
browser console -> 0 errors, 0 warnings
```

Live preview port used during development:

```text
http://127.0.0.1:52317/
```

---

## What changed from the original template

This repo is no longer the generic Flutter donut demo README/project state.

Current app now includes:

- DowgNut branding and logo extracted from the supplied brand image.
- Local brand assets under `assets/brand/`.
- Brand-aware Flutter theme under `lib/theme/`.
- Updated web/PWA metadata and icons.
- Mobile-first flavour filter and product grid.
- Clean Flutter 3.27 analyzer/build status.
- Project-specific Hermes skill for future agent handoff.

---

## Brand system

Reference image originally supplied from:

```text
G:/DowgNut-HQ/b68372d3-09ce-4dae-a36e-e949f9dddae2.jpg
```

Copied into this app as:

```text
assets/brand/dowgnut_brand_reference.jpg
```

Logo asset used in the app:

```text
assets/brand/dowgnut_logo_wordmark_transparent.png
```

Main palette:

| Token | Hex | Use |
|---|---:|---|
| DowgNut Blue | `#07579B` | Primary brand, selected chips, price pills, icons |
| Frosting Pink | `#F05A9B` | Secondary accent / CTA / donut frosting |
| Neon Lime | `#E8F866` | Splash, sidebar, high-energy brand background |
| Dark Navy | `#07334F` | Text, icons, high-contrast accents |
| Cream Surface | `#FFF9E8` | Cards and warm app surfaces |

Implementation files:

```text
lib/theme/dowgnut_theme.dart
lib/theme/dowgnut_logo.dart
web/index.html
web/manifest.json
web/icons/
```

Brand phrase:

```text
BOLD PLAYFUL AUTHENTIC
```

---

## App architecture

Entry point:

```text
lib/main.dart
```

Runtime flow:

```text
main()
  -> MultiProvider
  -> MaterialApp
  -> SplashPage
  -> DonutShopMain
      -> Drawer: DonutSideMenu
      -> AppBar: DowgNutLogo
      -> Nested Navigator: Utils.mainListnav
          -> /main: DonutMainPage
          -> /favorite: placeholder
          -> /shoppingCart: DonutShoppingCartPage
      -> DonutBottomBar
  -> DonutShopDetails
```

State services:

```text
lib/services/bottomnav.dart     # bottom tab state
lib/services/donutservice.dart  # selected flavour, filtered donuts, selected donut navigation
lib/services/cartservice.dart   # cart list and totals
```

Product data is currently local seed data:

```text
lib/utilities.dart
```

Models:

```text
lib/models/donutmodel.dart
lib/models/donutfilterbaritem.dart
lib/models/donutpage.dart
```

---

## Important file map

```text
lib/
  main.dart
  splashpage.dart
  utilities.dart
  theme/
    dowgnut_theme.dart
    dowgnut_logo.dart
  pages/
    initialpage.dart
    mainpage.dart
    detailspage.dart
    cartpage.dart
  main page stuff/
    donutpager.dart
    donutfilterbar.dart
    donutlist.dart
    donutcard.dart
  initial page stuff/
    sidebar.dart
    bottombar.dart
  cart page stuff/
    cartbadge.dart
    cartlist.dart
    cartlistrow.dart
  services/
    bottomnav.dart
    donutservice.dart
    cartservice.dart
  models/
    donutmodel.dart
    donutfilterbaritem.dart
    donutpage.dart
assets/brand/
web/
```

Note: some folders still contain spaces because the original project used names like `main page stuff`. Do not rename casually; it affects imports.

---

## Mobile-first rules

This app must be phone-first by default.

Expected mobile layout:

- Header logo centered with hamburger icon.
- Hero carousel sized for phone width.
- Flavour filter as touch-friendly pill chips.
- Product list as a vertical responsive grid.
- No horizontal product rail on phone.
- Bottom nav must not cover final product cards.

Known old web-style patterns that must not return:

```text
AnimatedList(scrollDirection: Axis.horizontal) for products
fixed DonutCard width: 150
MediaQuery width * 0.3 underline for filter tabs
fixed hero height: 400 for every device
```

Current mobile-first implementation:

```text
lib/pages/mainpage.dart                 # parent ListView + bottom padding
lib/main page stuff/donutfilterbar.dart # horizontal touch chips
lib/main page stuff/donutlist.dart      # responsive GridView, 2 columns on phone
lib/main page stuff/donutcard.dart      # flexible card, no fixed width
lib/main page stuff/donutpager.dart     # responsive hero height
```

Minimum mobile verification:

```text
viewport: 390x844
bodyScrollWidth: 390
docScrollWidth: 390
horizontalOverflow: false
console warnings/errors: 0
```

---

## Setup

Requirements:

- Flutter 3.27.x stable or compatible
- Dart 3.6.x or compatible
- Python 3.x only if serving `build/web` locally

Install dependencies:

```bash
cd "G:/DowgNut-Apps/donut-app"
flutter pub get
```

Run analyzer:

```bash
flutter analyze
```

Format Dart files:

```bash
dart format lib test
```

Important: do not run `dart format` on `pubspec.yaml` or `web/manifest.json`. Dart formatter treats them as Dart source and fails.

---

## Development commands

Run Flutter directly:

```bash
cd "G:/DowgNut-Apps/donut-app"
flutter run -d chrome
```

Build web release:

```bash
cd "G:/DowgNut-Apps/donut-app"
flutter build web --release
```

Serve built web output:

```bash
cd "G:/DowgNut-Apps/donut-app/build/web"
python -m http.server 52317 --bind 127.0.0.1
```

Open:

```text
http://127.0.0.1:52317/
```

After launch, wait for splash to redirect to:

```text
http://127.0.0.1:52317/#/main
```

---

## Verification checklist before saying “done”

Run from project root:

```bash
cd "G:/DowgNut-Apps/donut-app"
dart format lib test
flutter analyze
flutter build web --release
```

Expected:

```text
No issues found!
✓ Built build\web
warnings_found=false
```

For web preview:

```bash
curl -sI http://127.0.0.1:52317/ | sed -n '1,8p'
curl -s http://127.0.0.1:52317/ | grep -E "theme-color|title|mobile-web-app-capable"
curl -sI http://127.0.0.1:52317/assets/assets/brand/dowgnut_logo_wordmark_transparent.png | sed -n '1,5p'
curl -sI http://127.0.0.1:52317/icons/Icon-192.png | sed -n '1,5p'
```

Expected:

```text
HTTP/1.0 200 OK
<title>DowgNut</title>
<meta name="theme-color" content="#07579B">
```

Browser/mobile verification:

1. Open `http://127.0.0.1:52317/`.
2. Wait for `#/main`.
3. Resize to `390x844`.
4. Confirm no horizontal overflow.
5. Confirm flavour filter/product display is mobile-first.
6. Confirm console has 0 errors and 0 warnings.
7. Capture screenshot if making UI changes.

---

## Agent handoff notes

If you are another AI agent:

1. Load the Hermes skill `dowgnut-flutter-app`.
2. Confirm active repo:
   ```bash
   cd "G:/DowgNut-Apps/donut-app"
   git status --short
   ```
3. Read these files before editing UI:
   ```text
   pubspec.yaml
   lib/main.dart
   lib/theme/dowgnut_theme.dart
   lib/theme/dowgnut_logo.dart
   lib/pages/mainpage.dart
   lib/main page stuff/donutfilterbar.dart
   lib/main page stuff/donutlist.dart
   lib/main page stuff/donutcard.dart
   lib/services/donutservice.dart
   lib/utilities.dart
   ```
4. Never claim mobile-first from code alone. Render and inspect 390x844.
5. Do not commit/push unless the user explicitly asks.
6. Preserve brand palette and local logo assets.
7. Watch for pre-existing modified files; inspect `git status --short` before summarizing.

---

## Current known technical debt

- Favorites screen is still a placeholder.
- Product data is still hardcoded in `lib/utilities.dart` with remote image URLs.
- Original folder names contain spaces.
- SDK constraint in `pubspec.yaml` is old (`>=2.18.6 <3.0.0`) even though current toolchain is Dart 3.6.0.
- Generated platform plugin files may change after Flutter commands.
- There are local analysis result text files from prior work; inspect before deciding whether to keep or clean.

---

## Related local verification artifacts

Recent screenshots may exist locally under:

```text
C:/.playwright-mcp/dowgnut-logo-theme-final.png
C:/.playwright-mcp/dowgnut-mobile-first-final-390x844.png
```

These are local proof screenshots, not source-controlled app assets.
