#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[FlutterViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    // Honye do it. Sleep 1.5s
    [NSThread sleepForTimeInterval:1.5];
    
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
