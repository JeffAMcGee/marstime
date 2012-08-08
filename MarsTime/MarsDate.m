//
//  MarsDate.m
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MarsDate.h"

const double SECS_PER_MARS_HR = 3698.9685;
const double SECS_PER_MARS_MIN = 61.649475;
const double SECS_PER_MARS_SEC = 1.02749125;

@implementation MarsDate
@synthesize sol,time,tz;

- (MarsDate*) initWithTZ:(MarsTimeZone *)theTZ atSol: (int) theSol andTime:(NSTimeInterval) theTime {
    tz = theTZ;
    sol = theSol;
    time = theTime;
    return self;
}


- (MarsDate*) initWithTZ:(MarsTimeZone *)theTZ atSol: (int) theSol
                  atHour:(int)hr andMin:(int)min {
    tz = theTZ;
    sol = theSol;
    time = hr*SECS_PER_MARS_HR+min*SECS_PER_MARS_MIN;
    return self;
}


- (int) hrs {
    return floor(time/SECS_PER_MARS_HR);
}

- (int) mins {
    double minutes = fmod(time, SECS_PER_MARS_HR);
    return floor(minutes/SECS_PER_MARS_MIN);
}

- (float) secs {
    double earth_secs = fmod(time,SECS_PER_MARS_MIN);
    return earth_secs/SECS_PER_MARS_SEC;
}
@end
