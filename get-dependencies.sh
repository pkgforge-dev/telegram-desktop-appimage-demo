#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm webkit2gtk-4.1 pipewire-audio pipewire-jack

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Getting telegram binary..."
echo "---------------------------------------------------------------"
mkdir -p ./AppDir/bin
TARBALL_LINK=$(wget --retry-connrefused --tries=30 \
	https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest -O - \
	| sed 's/[()",{} ]/\n/g' | grep -o -m 1 'https.*releases.*tsetup.*tar.xz'
)
wget "$TARBALL_LINK" -O /tmp/telegram.tar.xz
tar xvf /tmp/telegram.tar.xz
rm -f /tmp/telegram.tar.xz
mv -v ./Telegram/Telegram ./AppDir/bin
echo "$TARBALL_LINK" | awk -F'/' '{print $(NF-1)}' > ~/version
