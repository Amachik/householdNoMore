#!/bin/bash
set -e
echo "Building extension for Safari..."
cd ..

# Requires full Xcode (not just the Command Line Tools) so that
# `safari-web-extension-converter` is available.
if ! xcrun --find safari-web-extension-converter >/dev/null 2>&1; then
    echo "Error: safari-web-extension-converter not found."
    echo "Install full Xcode from the App Store, open it once to accept the license/install"
    echo "additional components, then re-run this script."
    exit 1
fi

# Stage the unpacked extension source that Safari will convert (mirrors build-for-chrome.sh)
rm -rf build_tools/build/safari-src
mkdir -p build_tools/build/safari-src
cp build_tools/manifest-safari.json build_tools/build/safari-src/manifest.json
cp background.js content.js popup.html popup.css popup.js build_tools/build/safari-src/
cp -r icons build_tools/build/safari-src/

rm -rf build_tools/build/safari
mkdir -p build_tools/build/safari

# NOTE: This has not been run/verified locally (this machine only has the Xcode
# Command Line Tools, not full Xcode). Flag names below match Apple's documented
# converter options as of this writing, but run
# `xcrun safari-web-extension-converter --help`
# and adjust if your Xcode version's flags differ.
xcrun safari-web-extension-converter build_tools/build/safari-src \
    --project-location build_tools/build/safari \
    --app-name "Netflix Household No More" \
    --bundle-identifier "com.householdnomore.netflix-bypass" \
    --swift \
    --no-open \
    --force

echo "Done. Open the generated Xcode project in build_tools/build/safari/ to build, sign, and run it."
