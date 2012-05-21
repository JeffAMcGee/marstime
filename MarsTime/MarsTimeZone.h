//
//  MarsTimeZone.h
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MarsDate;

@interface MarsTimeZone : NSObject
@property(retain, readonly) NSString *label;

// The offset is the number of secnods from first instant of 1 January 2001, UTC
// to the first instant of Sol 0
- (MarsTimeZone*) initWithOffset:(NSTimeInterval)theOffset
                    andDayLength: (NSTimeInterval) theDayLength;

- (MarsDate *)marsDate:(NSDate *)date;
- (NSDate *)earthDate:(MarsDate *)date;

@end
