//
//  MarsTimeTests.m
//  MarsTimeTests
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MarsTimeTests.h"
#import "MarsDate.h"
#import "MarsTimeZone.h"

@implementation MarsTimeTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testMarsDate
{
    MarsDate *d = [[MarsDate alloc] initWithTZ:nil atSol:3 andTime:7275.5];
    STAssertEquals(d.sol, 3,nil);
    STAssertEquals([d hrs], 2,nil);
    STAssertEquals([d mins], 1,nil);
    STAssertEquals([d secs], 15.5,nil);
}

- (void)testMarsTimeZone
{
    MarsTimeZone *tz = [[MarsTimeZone alloc]
                        initWithOffset:30*60
                        andDayLength:24*60*60+40*60];
    MarsDate *md = [[MarsDate alloc] initWithTZ:tz atSol:1 andTime:5];
    NSDate *ed = [tz earthDate:md];
    MarsDate *md_cp = [tz marsDate:ed];
    
    
    STAssertEquals(ed.timeIntervalSinceReferenceDate,
                   30*60 + 24*60*60 + 40*60 + 5,nil);
    STAssertEquals(md.tz, tz, nil);
    STAssertEquals(md_cp.tz, tz, nil);
    STAssertEquals(md.sol, md_cp.sol,nil);
    STAssertEquals(md.time, md_cp.time,nil);
    STAssertEquals([md_cp secs], 5.0,nil);
    
}

@end
