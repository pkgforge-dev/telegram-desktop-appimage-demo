#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm libappindicator

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Getting telegram binary..."
echo "---------------------------------------------------------------"
mkdir -p ./AppDir/bin
if [ "$ARCH" = "x86_64" ]; then

	TARBALL_LINK=$(wget --retry-connrefused --tries=30 \
		https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest -O - \
		| sed 's/[()",{} ]/\n/g' | grep -o -m 1 'https.*releases.*tsetup.*tar.xz'
	)
	wget "$TARBALL_LINK" -O /tmp/telegram.tar.xz
	tar xvf /tmp/telegram.tar.xz
	rm -f /tmp/telegram.tar.xz
	mv -v ./Telegram/Telegram ./AppDir/bin
	echo "$TARBALL_LINK" | awk -F'/' '{print $(NF-1)}' > ~/version
else
	pacman -S --noconfirm telegram-desktop
	VERSION=$(pacman -Q telegram-desktop | awk '{print $2; exit}')
	mv -v /usr/bin/Telegram ./AppDir/bin
fi
