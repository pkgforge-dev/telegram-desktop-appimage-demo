#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/telegramdesktop/tdesktop/refs/heads/dev/Telegram/Resources/art/icon256.png
export DESKTOP=https://raw.githubusercontent.com/telegramdesktop/tdesktop/refs/heads/dev/lib/xdg/org.telegram.desktop.desktop
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1

# Deploy dependencies
quick-sharun \
	/usr/bin/Telegram     \
	/usr/lib/libwayland-*.so* \
	/usr/lib/libgeoclue*.so*  \
	/usr/lib/libwebkit2gtk-4.1.so*
echo 'DESKTOPINTEGRATION=0' >> ./AppDir/.env

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
