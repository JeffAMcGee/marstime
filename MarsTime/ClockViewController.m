//  FirstViewController.m
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 Jeffrey McGee. Licensed under the MIT license.
//

#import "ClockViewController.h"
#import "MarsTimeZone.h"
#import "MarsDate.h"
#import "AppDelegate.h"

@interface ClockViewController ()

@end

@implementation ClockViewController
@synthesize tz_label;
@synthesize time_label;
@synthesize date_label;
@synthesize timeZone;

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.timeZone = [appDelegate currentTimeZone];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateTime];
}

- (void)viewDidUnload
{
    [self setTz_label:nil];
    [self setTime_label:nil];
    [self setDate_label:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)updateTime
{
    MarsDate *now = [self.timeZone marsDate:[NSDate date]];
    self.date_label.text = [NSString stringWithFormat:@"Sol %d", [now sol]];
    self.time_label.text = [NSString
                            stringWithFormat:@"%d:%02d:%02d",
                            [now hrs], [now mins], (int)[now secs]];
}
@end
