#!/bin/bash
###########################################
## Deps: 
##
## Be sure to check the license file.
##
## Script to make a preconfigured browser for I2P
###########################################

# Prepping profile
wget -c "https://github.com/eyedeekay/i2p.plugins.firefox/releases/download/1.0.1/i2pbrowser.zip"
unzip i2pbrowser.zip
cd i2pbrowser || exit

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
cp -v ../../firefox.sh firefox
chmod +x ./$FILENAME
chmod +x ./firefox
