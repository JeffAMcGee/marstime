//  AlarmsViewController.m
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 Jeffrey McGee. Licensed under the MIT license.
//

#import "AlarmsViewController.h"
#import "MarsTimeZone.h"
#import "MarsDate.h"
#import "AppDelegate.h"

@interface AlarmsViewController ()

@end

@implementation AlarmsViewController
@synthesize alarmSwitch;
@synthesize timePicker;
@synthesize earthAlarmLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        hr = 0;
        min = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self updateEarthLabel];
}

- (void)viewDidUnload
{
    [self setAlarmSwitch:nil];
    [self setTimePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Time Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0) {
        return 25;
    } else {
        return 60;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%02d", row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return 40;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

- (void)pickerView:(UIPickerView *)pickerView
            didSelectRow:(NSInteger)row
            inComponent:(NSInteger)component {
    if(component==0) {
        hr = row;
    } else {
        min = row;
    }
    [self updateEarthLabel];
}


- (void)updateEarthLabel {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MarsTimeZone *timeZone = [appDelegate currentTimeZone];
    NSDate *nextDate = [timeZone earthDate:[timeZone nextMarsDateAtHour:hr andMin:min]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    self.earthAlarmLabel.text = [NSString stringWithFormat:
            @"The next time this alarm will trigger is %@.",
            [dateFormatter stringFromDate:nextDate]];
}

@end
