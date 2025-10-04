#!/bin/sh
# Name: KOReader installer
# Author: HackerAUG
# Icon:

OTA_SERVER="https://ota.koreader.rocks/"
CHANNEL="nightly"
OTA_ZSYNC="koreader-kindlehf-latest-$CHANNEL.zsync"

echo "Installing/Updating KOReader :)"

if [ -f /lib/ld-linux-armhf.so.3 ]; then
  echo "Detected firmware above 5.16.2.1.1, choosing kindlehf binaries"
else
  echo "Detected firmware <= 5.16.2.1.1, choosing kindlepw2 binaries"
  OTA_ZSYNC="koreader-kindlepw2-latest-$CHANNEL.zsync"
fi

echo "Finding the latest available nightly."
OTA_FILENAME=$(curl "$OTA_SERVER$OTA_ZSYNC" -s -r 0-150 | grep Filename | sed 's/Filename: //')

if [ "$OTA_FILENAME" = "" ]; then
  echo "A $CHANNEL release couldn't be found for your kindle!"
  sleep 5
  exit
fi

echo "Latest available nightly is $OTA_FILENAME. Downloading it."
curl $OTA_SERVER$OTA_FILENAME -s --output /tmp/KoreaderInstall.tar.gz

echo "KOReader OTA file downloaded, installing it!"
tar -xf /tmp/KoreaderInstall.tar.gz -C /mnt/us/

echo "Done!"
sleep 5
