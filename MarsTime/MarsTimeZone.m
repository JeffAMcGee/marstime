//
//  MarsTimeZone.m
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MarsTimeZone.h"
#import "MarsDate.h"

@implementation MarsTimeZone
{
    NSTimeInterval offset;
    NSTimeInterval dayLength;
}
@synthesize label;
+ (NSDictionary*) timeZones {
    static NSDictionary* tzs = nil;
    if(!tzs) {
        tzs = [NSDictionary dictionaryWithObjectsAndKeys:
               [[MarsTimeZone alloc] initWithOffset:365867400 andDayLength:88775.244],
               @"MSL",
               nil];
    }
    return tzs;
}

- (MarsTimeZone*) initWithOffset:(NSTimeInterval)theOffset
                andDayLength: (NSTimeInterval) theDayLength {
    dayLength = theDayLength;
    offset = theOffset;
    return self;
}

- (MarsDate *)marsDate:(NSDate *)date {
    NSTimeInterval secs = [date timeIntervalSinceReferenceDate]-offset;
    int sol = floor(secs/dayLength);
    NSTimeInterval time = secs-dayLength*sol;
    return [[MarsDate alloc] initWithTZ:self atSol:sol andTime:time];
}

- (MarsDate *)nextMarsDateAtHour:(int)hr andMin:(int)min {
    MarsDate *now = [self marsDate:[NSDate date]];
    // FIXME: this is a mess!
    int time = hr*SECS_PER_MARS_HR+min*SECS_PER_MARS_MIN;
    int sol = now.sol;
    if(time<now.time) {
        sol++;
    }
    return [[MarsDate alloc] initWithTZ:self atSol:sol andTime:time];
}

- (NSDate *)earthDate:(MarsDate *)date {
    NSAssert(date.tz==self,@"wrong timezone");
    NSTimeInterval secs= date.sol*dayLength+date.time;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:secs+offset];
}

@end
