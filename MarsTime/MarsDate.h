//
//  MarsDate.h
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const double SECS_PER_MARS_HR;
extern const double SECS_PER_MARS_MIN;
extern const double SECS_PER_MARS_SEC;

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
- (float) secs;

@end
