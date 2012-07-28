//
//  MarsDate.h
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MarsTimeZone;

@interface MarsDate : NSObject
@property(weak, readonly) MarsTimeZone* tz;
@property(assign, readonly) int sol;
@property(assign, readonly) NSTimeInterval time;

- (MarsDate*) initWithTZ:(MarsTimeZone *)theTZ atSol: (int) theSol andTime:(NSTimeInterval) theTime;

- (MarsDate*) initWithTZ:(MarsTimeZone *)theTZ atSol: (int) theSol
                  atHour:(int)hr andMin:(int)min;

- (int) hrs;
- (int) mins;
- (NSTimeInterval) secs;

@end
