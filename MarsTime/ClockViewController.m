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
@synthesize tzLabel;
@synthesize timeLabel;
@synthesize dateLabel;
@synthesize timeZone;

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.timeZone = [appDelegate currentTimeZone];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateTime:NULL];

    clockTimer = [NSTimer scheduledTimerWithTimeInterval:.25
                    target:self
                    selector:@selector(updateTime:)
                    userInfo:nil
                    repeats:YES];
}

- (void)viewDidUnload
{
    [self setTzLabel:nil];
    [self setTimeLabel:nil];
    [self setDateLabel:nil];
    [clockTimer invalidate];
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

- (void)updateTime:(NSTimer *) theTimer
{
    MarsDate *now = [self.timeZone marsDate:[NSDate date]];
    self.dateLabel.text = [NSString stringWithFormat:@"Sol %d", [now sol]];
    self.timeLabel.text = [NSString
                            stringWithFormat:@"%d:%02d:%02d",
                            [now hrs], [now mins], (int)[now secs]];
}
@end
