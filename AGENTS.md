# Repository Guidelines

## Project Structure & Module Organization

This Flutter app lives at `G:/DowgNut-Apps/donut-app`. Main source is under `lib/`: `main.dart` starts the app, `pages/` holds screens, `services/` contains Provider-backed state, `models/` defines app data types, and `theme/` contains DowgNut branding. Legacy UI folders such as `main page stuff/`, `cart page stuff/`, and `initial page stuff/` still have spaces; do not rename them casually because imports depend on those paths. Tests live in `test/`, brand assets in `assets/brand/`, and Flutter Web/PWA files in `web/`.

## Build, Test, and Development Commands

Run commands from `G:/DowgNut-Apps/donut-app`:

- `flutter pub get` installs dependencies from `pubspec.yaml`.
- `flutter run -d chrome` starts the app in Chrome for local development.
- `dart format lib test` formats Dart source and tests.
- `flutter analyze` runs static analysis using `flutter_lints`.
- `flutter test` runs widget and unit tests under `test/`.
- `flutter build web --release` creates the production web build in `build/web`.

Do not run `dart format` on YAML or JSON files.

## Coding Style & Naming Conventions

Use Dart defaults: two-space indentation, trailing commas for readable widget trees, `UpperCamelCase` for classes/widgets, `lowerCamelCase` for methods, fields, and variables, and `snake_case.dart` file names when adding new files. Keep UI code mobile-first and preserve the DowgNut palette and local logo assets. Prefer existing Provider service patterns before adding new state abstractions.

## Testing Guidelines

Use `flutter_test` for widget tests. Name test files with `_test.dart` and keep tests near user-visible behavior, such as splash copy, navigation, cart totals, and filtering. For UI changes, run `flutter test` and `flutter analyze`; for web/PWA changes, also run `flutter build web --release` and inspect a 390x844 mobile viewport for horizontal overflow.

## Commit & Pull Request Guidelines

Current history uses conventional-style subjects such as `feat: DowgNut Flutter app ...`. Keep commits short, imperative, and scoped (`feat:`, `fix:`, `docs:`, `test:`). Pull requests should include a summary, validation commands run, screenshots for UI changes, linked issues when available, and notes about any brand, asset, or platform-file changes.

## Security & Configuration Tips

Do not commit secrets, API keys, private customer data, or generated local diagnostics. Keep `pubspec.yaml` asset declarations aligned with files under `assets/brand/`. Treat platform folders (`android/`, `ios/`, `web/`, `windows/`, `linux/`, `macos/`) as release-impacting surfaces and verify builds after changes there.
