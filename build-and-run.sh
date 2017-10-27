set -e

ib --cfg iphone_simulator_debug src/main

# check if key chain is locked
security unlock-keychain -u

if [ $? != 0 ]; then
  echo 'unlock your login keychain for codesign tasks'
  echo 'alternatively, execute "security unlock-keychain"'
  security unlock-keychain
fi

# build to out dir
xcodebuild -target iphone_simulator -configuration Debug -sdk iphonesimulator11.0 build

# check if My-iPhone-8 exists or is running
HAS_BOOTED_SIM=$(xcrun simctl list | grep 'My-iPhone-8' | grep Booted || true)
HAS_CREATED_SIM=$(xcrun simctl list | grep 'My-iPhone-8' || true)

if [ -z "$HAS_CREATED_SIM" ]; then
  echo 'creating simulator'
  xcrun simctl create 'My-iPhone-8' \
    com.apple.CoreSimulator.SimDeviceType.iPhone-8 \
    com.apple.CoreSimulator.SimRuntime.iOS-11-0
fi

# do we have a booted device
if [ -z "$HAS_BOOTED_SIM" ]; then
  echo 'booting simulator'
  xcrun simctl boot 'My-iPhone-8'
fi

xcrun simctl install booted build/Debug-iphonesimulator/iphone_simulator.app
open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app
xcrun simctl launch --console booted testing.built-with-ib
