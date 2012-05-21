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

- (NSDate *)earthDate:(MarsDate *)date {
    NSAssert(date.tz==self,@"wrong timezone");
    NSTimeInterval secs= date.sol*dayLength+date.time;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:secs+offset];
}

@end
