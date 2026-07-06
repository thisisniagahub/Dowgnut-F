#!/usr/bin/env bash
set -euo pipefail
flutter channel stable
flutter upgrade
flutter config --enable-web
flutter pub get
flutter build web --release
