//
//  ARTAppDelegate.m
//  Foursquare
//
//  Created by Bruno Berisso on 18/01/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import "ARTAppDelegate.h"
#import "ARTViewController.h"
#import "ARTFoursquare.h"

@implementation ARTAppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ARTViewController alloc] initWithNibName:@"ARTViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([ARTFoursquare shouldHandleUrl:url])
        return [ARTFoursquare.session handleOpenURL:url];
    return NO;
}

@end
