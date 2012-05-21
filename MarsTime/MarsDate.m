//
//  MarsDate.m
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MarsDate.h"

@implementation MarsDate
@synthesize sol,time,tz;

- (MarsDate*) initWithTZ:(MarsTimeZone *)theTZ atSol: (int) theSol andTime:(NSTimeInterval) theTime {
    tz = theTZ;
    sol = theSol;
    time = theTime;
    return self;
}
- (int) hrs {
    return floor(time/3600.0);
}

- (int) mins {
    double minutes = fmod(time, 3600.0);
    return floor(minutes/60.0);
}

- (NSTimeInterval) secs {
    return fmod(time,60);
}
@end
