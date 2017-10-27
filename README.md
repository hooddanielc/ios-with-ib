Build iOS Apps With IB
==========================

Building ios apps is a piece of cake as long as you know the correct compiler flags. This project does not require a you to buy a developer account, but you still need to log into xcode if you want to run it. Apple forces developers to code sign bundles as it is is part of their plan to rule the entire world. Fortunately they do not require developers to build using the IDE. We can get around the code signing and packaging by adding a "Copy Files" build phase, which signs and copies executable built by ib.

## Build for iOS Simulator

- Build using ib `ib src/main`
- Open Xcode, go to  `product->run`

## Build for iOS Device

- Build using `ib --cfg iphone_debug src/main`
- Open Xcode, go to `product->run`

You might get a build error saying you need to select a team for codesigning. To do this, click on the project on the left sidebar. Select general tab and locate the "Signing" section.

## Create your own Xcode Project

- Open Xcode
- Create a project
- Select Single View iOS App
- Delete all files except for Info.plist and assets
- Create a copy files build phase
- Rename Executable field in info.plist to the executable you are copying

## Build from command line

`xcodebuild`


## Build and Run Script

`./build-and-run.sh` will build and deploy to an ios simulator and log standard output.

## security unlock-keychain

You might need to execute `security unlock-keychain` to allow users logged in through ssh to use code sign key