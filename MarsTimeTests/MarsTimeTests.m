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
    STAssertEquals([d hrs], 1,nil);
    STAssertEquals([d mins], 58,nil);
}


@end
