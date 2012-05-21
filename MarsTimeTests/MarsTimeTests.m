//
//  MarsTimeTests.m
//  MarsTimeTests
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MarsTimeTests.h"
#import "MarsDate.h"

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

- (void)testExample
{
    MarsDate *d = [[MarsDate alloc] initWithTZ:nil atSol:3 andTime:7275.5];
    STAssertEquals(d.sol, 3,nil);
    
    STAssertEquals([d hrs], 2,nil);
    STAssertEquals([d mins], 1,nil);
    STAssertEquals([d secs], 15.5,nil);

}

@end
