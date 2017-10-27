#pragma once

#include <iostream>
#include <UIKit/UIKit.h>

void print_stats() {
  CGRect screenBounds = [[UIScreen mainScreen] bounds];
  CGFloat screenScale = [[UIScreen mainScreen] scale];
  std::cout << "screen width: " << screenBounds.size.width << std::endl;
  std::cout << "screen height " << screenBounds.size.height << std::endl;
  std::cout << "screen scale " << screenScale << std::endl;
  std::cout << "screen pixels horizontal: " << screenBounds.size.width * screenScale << std::endl;
  std::cout << "screen pixels vertical: " << screenBounds.size.height * screenScale << std::endl;
  std::cout << "name: " << [[UIDevice currentDevice].name UTF8String] << std::endl;
  std::cout << "system name: " << [[UIDevice currentDevice].systemName UTF8String] << std::endl;
  std::cout << "model: " << [[UIDevice currentDevice].model UTF8String] << std::endl;
  std::cout << "system version: " << [[UIDevice currentDevice].systemVersion UTF8String] << std::endl;
  std::cout << "localized model: " << [[UIDevice currentDevice].localizedModel UTF8String] << std::endl;
  std::cout << "identifier for vendor: " << [[UIDevice currentDevice].identifierForVendor.UUIDString UTF8String] << std::endl;

  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomUnspecified) {
    std::cout << "user interface idion == UIUserInterfaceIdiomUnspecified" << std::endl;
  } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    std::cout << "user interface idion == UIUserInterfaceIdiomPhone" << std::endl;
  } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    std::cout << "user interface idion == UIUserInterfaceIdiomPad" << std::endl;
  } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomTV) {
    std::cout << "user interface idion == UIUserInterfaceIdiomTV" << std::endl;
  } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomCarPlay) {
    std::cout << "user interface idion == UIUserInterfaceIdiomCarPlay" << std::endl;
  }

}
