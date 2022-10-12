#!/bin/bash
###########################################
## Deps: 
##
## Be sure to check the license file.
##
## Script to make a preconfigured browser for I2P
###########################################

# Get LibreWolf and make it portable
echo "Let's do this..."
wget -4 -q --show-progress "https://github.com/AmyMoriyama/fetch-librewolf/archive/refs/heads/main.zip"
unzip main.zip
rm main.zip

echo ""
echo "Getting LibreWolf AppImage..."
mv fetch-librewolf-main i2pwolf
cd i2pwolf
chmod +x ./1run.sh
./1run.sh
FILENAME=$(ls LibreWolf*.AppImage)
chmod +x ./$FILENAME
chmod +x ./LibreWolf.AppImage.portable.sh

# Prepping profile
echo ""
echo "Prepping the profile..."
tar -xzf ../firefox.profile.i2p.tar.gz
mv firefox.profile.i2p profile

echo ""
echo "You should now have a preconfigured browser for I2P"
