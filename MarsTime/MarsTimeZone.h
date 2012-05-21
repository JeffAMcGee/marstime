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

- (MarsDate *)marsDate:(NSDate *)date;
- (NSDate *)earthDate:(MarsDate *)date;

@end
