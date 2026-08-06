#!/bin/bash
echo "Building extension for Chrome..."
cd ..

# Reset the unpacked build directory
rm -rf build_tools/build/chrome
mkdir -p build_tools/build/chrome

# Copy the extension source files into the unpacked folder
cp build_tools/manifest-chrome.json build_tools/build/chrome/manifest.json
cp background.js content.js popup.html popup.css popup.js build_tools/build/chrome/
cp -r icons build_tools/build/chrome/

echo "Done. Unpacked extension is in build_tools/build/chrome/ (load this folder via 'Load unpacked')."

# Also produce a zip for store upload
( cd build_tools/build/chrome && zip -r ../netflix-bypass-chrome.zip . --exclude='*.DS_Store*' )
echo "Done. Created build_tools/build/netflix-bypass-chrome.zip"
