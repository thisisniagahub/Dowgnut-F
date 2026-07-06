#!/usr/bin/env bash
set -euo pipefail

# Install Flutter SDK if missing (Vercel sandbox does not include Flutter by default).
if [ ! -d "/opt/flutter" ]; then
  echo ">>> Installing Flutter SDK to /opt/flutter"
  apt-get update -y >/dev/null
  apt-get install -y curl git unzip xz-utils libglu1-mesa >/dev/null
  cd /opt
  curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.1-stable.tar.xz -o flutter.tar.xz
  tar xf flutter.tar.xz
  rm flutter.tar.xz
fi

export PATH="/opt/flutter/bin:$PATH"
git config --global --add safe.directory /opt/flutter

flutter channel stable
flutter --disable-analytics >/dev/null 2>&1 || true
flutter config --enable-web
flutter pub get
flutter build web --release
