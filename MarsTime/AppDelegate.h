//  AppDelegate.h
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 Jeffrey McGee. Licensed under the MIT license.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class MarsTimeZone;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate> {
    SystemSoundID notifSound;
}

@property (strong, nonatomic) UIWindow *window;

- (MarsTimeZone*)currentTimeZone;

@end
