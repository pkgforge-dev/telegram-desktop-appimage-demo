#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	geoclue          \
	gst-libav        \
	gst-plugins-base \
	gst-plugins-bad  \
	gst-plugins-good \
	gst-plugin-va    \
	pipewire-audio   \
	pipewire-jack    \
	telegram-desktop \
	webkit2gtk-4.1

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini
