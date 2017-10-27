#pragma once

#include <UIKit/UIKit.h>
#include <GLKit/GLKit.h>
#include <QuartzCore/QuartzCore.h>

@interface BRUMainWindow : UIWindow
@end

@interface BRUAppDelegate : UIResponder <UIApplicationDelegate, GLKViewDelegate>
@property (strong, nonatomic) BRUMainWindow *window;
@property (assign) CADisplayLink *displayLink;
@property (assign) EAGLContext *context;
@end
