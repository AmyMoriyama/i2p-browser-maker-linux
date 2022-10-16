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
##echo ""
##echo "Prepping the profile..."
##tar -xzf ../firefox.profile.i2p.tar.gz
##mv firefox.profile.i2p profile
##

# get release version
vers=$(curl --silent "https://api.github.com/repos/eyedeekay/i2p.plugins.firefox/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# download release
wget -4 "https://github.com/eyedeekay/i2p.plugins.firefox/archive/refs/tags/$vers.tar.gz"

# extract release and pry out the profile using excessive force and do some tweaks
tar -xzf "$vers.tar.gz"
rm "$vers.tar.gz"
mv "./i2p.plugins.firefox-$vers/src/i2p.firefox.base.profile" "profile"
rm -rf "./i2p.plugins.firefox-$vers/"

# tweaks
sed -i 's|user_pref("browser.startup.homepage", "about:blank");|user_pref("browser.startup.homepage", "http://127.0.0.1:7657");|g' profile/prefs.js

echo "" >> profile/prefs.js
echo 'user_pref("browser.startup.page", "1");
user_pref("browser.toolbars.bookmarks.visibility", "always");
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"home-button\",\"urlbar-container\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"developer-button\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":17,\"newElementCount\":4}");' >> profile/prefs.js

sed -i 's|user_pref("browser.startup.page", 0);|/*user_pref("browser.startup.page", 0);*/|g' profile/user.js
sed -i 's|user_pref("browser.startup.homepage", "about:blank");|/*user_pref("browser.startup.homepage", "about:blank");*/|g' profile/user.js

sed -i 's|user_pref("_user.js.parrot", "SUCCESS: No no he's not dead, he's, he's restin'!");|/*user_pref("_user.js.parrot", "SUCCESS: No no he's not dead, he's, he's restin'!");*/|g' profile/user.js
echo "" >> profile/user.js
echo '/* 0811: disable Form Autofill
 * [NOTE] Stored data is NOT secure (uses a JSON file)
 * [NOTE] Heuristics controls Form Autofill on forms without @autocomplete attributes
 * [SETTING] Privacy & Security>Forms and Autofill>Autofill addresses
 * [1] https://wiki.mozilla.org/Firefox/Features/Form_Autofill ***/
user_pref("extensions.formautofill.addresses.enabled", false); // [FF55+]
user_pref("extensions.formautofill.available", "off"); // [FF56+]
user_pref("extensions.formautofill.creditCards.available", false); // [FF57+]
user_pref("extensions.formautofill.creditCards.enabled", false); // [FF56+]
user_pref("extensions.formautofill.heuristics.enabled", false); // [FF55+]
/* 1401: disable rendering of SVG OpenType fonts ***/
user_pref("gfx.font_rendering.opentype_svg.enabled", false);
user_pref("_user.js.parrot", "SUCCESS: No no he's not dead, he's, he's restin'!");' >> profile/user.js


echo ""
echo "You should now have a preconfigured browser for I2P"
