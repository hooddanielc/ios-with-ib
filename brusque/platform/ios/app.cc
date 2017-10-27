#include <stdexcept>
#include <iostream>
#include <brusque/app.h>

@implementation BRUMainWindow
- (UIView *) hitTest: (CGPoint) point withEvent: (UIEvent *) event {
    UIView *res;
    res = [super hitTest: point withEvent: event];
    std::cout << "user touched screen" << std::endl;
    return res;
}
@end

namespace brusque {

static app_t *active_app = nullptr;

int app_t::exec(int argc, char *argv[]) {
  return main(argc, argv);
}

int app_t::main(int argc, char *argv[]) {
  active_app = this;
  @autoreleasepool {
    int result = UIApplicationMain(argc, argv, nil, @"BRUAppDelegate");
    on_destroy();
    return result;
  }
}

void app_t::start_run_loop() {
  ((BRUAppDelegate*) [[UIApplication sharedApplication] delegate]).displayLink.paused = NO;
}

void app_t::stop_run_loop() {
  ((BRUAppDelegate*) [[UIApplication sharedApplication] delegate]).displayLink.paused = YES;
}

};  // brusque

@implementation BRUAppDelegate {
  GLKView *view;
}

- (void) render:(CADisplayLink*) displayLink {
  #pragma unused(displayLink)
  [view display];
}

- (BOOL) application: (UIApplication *) application willFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
  #pragma unused(launchOptions)
  #pragma unused(application)

  self.context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
  self.displayLink = [CADisplayLink displayLinkWithTarget: self selector: @selector (render:)];
  self.displayLink.paused = YES;
  [self.displayLink addToRunLoop: [NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];

  if (!self.context) {
    throw std::runtime_error("initialize OpenGLES failed");
    exit(1);
  }

  view = [[GLKView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
  view.context = self.context;
  view.delegate = self;
  view.enableSetNeedsDisplay = NO;

  self.window = [[BRUMainWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
  [self.window addSubview: view];
  [self.window makeKeyAndVisible];
  brusque::active_app->on_create();
  return YES;
}

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
  #pragma unused(launchOptions)
  #pragma unused(application)
  assert(brusque::active_app);
  brusque::active_app->on_start();
  return YES;
}

- (void) glkView: (GLKView *) view drawInRect: (CGRect) rect {
  #pragma unused(rect)
  #pragma unused(view)
  assert(brusque::active_app);
  brusque::active_app->render();
}

- (void) applicationWillResignActive: (UIApplication *) application {
  #pragma unused(application)
  assert(brusque::active_app);
  brusque::active_app->on_pause();
}

- (void) applicationDidEnterBackground: (UIApplication *) application {
  #pragma unused(application)
  assert(brusque::active_app);
  brusque::active_app->on_stop();
}

- (void) applicationWillEnterForeground: (UIApplication *) application {
  #pragma unused(application)
  assert(brusque::active_app);
  brusque::active_app->on_start();
}

- (void) applicationDidBecomeActive: (UIApplication *) application {
  #pragma unused(application)
  assert(brusque::active_app);
  brusque::active_app->on_resume();
}

- (void) applicationWillTerminate: (UIApplication *) application {
  #pragma unused(application)
  assert(brusque::active_app);
  brusque::active_app->on_destroy();
}
@end
