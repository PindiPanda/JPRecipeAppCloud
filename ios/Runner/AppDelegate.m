#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
//#include "Firebase"

@implementation AppDelegate
//@import Firebase

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[FIRApp configure];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
