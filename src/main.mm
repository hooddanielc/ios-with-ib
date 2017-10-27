#include <iostream>
#include "util/stats.h"
#include <UIKit/UIKit.h>
#include <GLKit/GLKit.h>
#include <QuartzCore/QuartzCore.h>

@interface MainWindow : UIWindow
@end

@implementation MainWindow
- (UIView *) hitTest: (CGPoint) point withEvent: (UIEvent *) event {
    UIView *res;
    res = [super hitTest: point withEvent: event];
    std::cout << "TOUCHY" << std::endl;
    return res;
}   
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate, GLKViewDelegate>
@property (strong, nonatomic) MainWindow *window;
@end

@implementation AppDelegate{
  float red_value;
  BOOL is_increasing;
}

- (void) render:(CADisplayLink*) displayLink {
  #pragma unused(displayLink)
  GLKView *view = [self.window.subviews objectAtIndex: 0];
  [view display];
}

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
  #pragma unused(launchOptions)
  #pragma unused(application)
  self.window = [[MainWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
  is_increasing = YES;
  red_value = 0.0;

  EAGLContext *context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];

  if (!context) {
    std::cout << "Failed to initialize OpenGLES 2.0 context" << std::endl;
    exit(1);
  }

  print_stats();

  GLKView *view = [[GLKView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
  view.context = context;
  view.delegate = self;
  [self.window addSubview: view];
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];

  view.enableSetNeedsDisplay = NO;
  CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget: self selector: @selector (render:)];
  [displayLink addToRunLoop: [NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];

  return YES;
}

- (void) glkView: (GLKView *) view drawInRect: (CGRect) rect {
  #pragma unused(rect)
  #pragma unused(view)

  if (is_increasing) {
    red_value += 0.01;
  } else {
    red_value -= 0.01;
  }
  if (red_value >= 1.0) {
    red_value = 1.0;
    is_increasing = NO;
  }
  if (red_value <= 0.0) {
    red_value = 0.0;
    is_increasing = YES;
  }

  glClearColor(red_value, 0.0, 0.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
}

- (void) applicationWillResignActive: (UIApplication *) application {
  #pragma unused(application)
}

- (void) applicationDidEnterBackground: (UIApplication *) application {
  #pragma unused(application)
}

- (void) applicationWillEnterForeground: (UIApplication *) application {
  #pragma unused(application)
}

- (void) applicationDidBecomeActive: (UIApplication *) application {
  #pragma unused(application)
}

- (void) applicationWillTerminate: (UIApplication *) application {
  #pragma unused(application)
}
@end

int main(int argc, char *argv[]) {
  std::cout << "I think; therefore, ib." << std::endl;
  @autoreleasepool {
    return UIApplicationMain(argc, argv, nil, @"AppDelegate");
  }
}
