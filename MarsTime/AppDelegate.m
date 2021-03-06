//  AppDelegate.m
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 Jeffrey McGee. Licensed under the MIT license.
//

#import "AppDelegate.h"
#import "MarsTimeZone.h"


@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:
(UILocalNotification *)notification {
    /* This is all kinds of broken. If the application is running in the foreground,
     * iOS does not play the sound and display the local notification, so we have
     * to fake it.
     */
    if(application.applicationState == UIApplicationStateActive ) {
        NSString *soundPath = [[NSBundle mainBundle]
                               pathForResource:notification.soundName ofType:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &notifSound);
        AudioServicesPlaySystemSound (notifSound);
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"MarsTime"
                              message: notification.alertBody
                              delegate: self
                              cancelButtonTitle:@"Close"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    AudioServicesDisposeSystemSoundID(notifSound);
}

- (MarsTimeZone*)currentTimeZone
{
    // FIXME: let the user pick a timezone.
    return [[MarsTimeZone timeZones] valueForKey:@"MSL"];
}
@end
