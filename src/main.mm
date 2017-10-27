#include <iostream>
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, GLKViewDelegate>
@property (strong, nonatomic) UIWindow *window;
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
  self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
  is_increasing = YES;
  red_value = 0.0;

  EAGLContext *context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
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

- (void) glkView:(GLKView *) view drawInRect: (CGRect) rect {
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

  glClearColor(0.0, red_value, 0.0, 1.0);
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

int main(int argc, char * argv[]) {
  std::cout << "I think; therefore, ib." << std::endl;
  @autoreleasepool {
      return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}
