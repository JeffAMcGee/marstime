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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    hr = [prefs integerForKey:@"alarm_hr"];
    min = [prefs integerForKey:@"alarm_min"];
    armed = [prefs boolForKey:@"alarm_armed"];
    [self.timePicker selectRow:hr inComponent:0 animated:NO];
    [self.timePicker selectRow:min inComponent:1 animated:NO];
    self.alarmSwitch.on = armed;
    [self.alarmSwitch addTarget:self action:@selector(switchFlipped:) forControlEvents:UIControlEventValueChanged];
    [self updateEarthLabel];
    [self updateAlarms];
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

- (void)switchFlipped:(id)sender {
    UISwitch* sw =(UISwitch*)sender;
    armed = sw.on;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:armed forKey:@"alarm_armed"];
    [self updateEarthLabel];
    [self updateAlarms];
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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(component==0) {
        hr = row;
        [prefs setInteger:row forKey:@"alarm_hr"];
    } else {
        min = row;
        [prefs setInteger:row forKey:@"alarm_min"];
    }
    [self updateEarthLabel];
    [self updateAlarms];
}

// helpers

- (void)updateEarthLabel {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MarsTimeZone *timeZone = [appDelegate currentTimeZone];
    NSDate *nextDate = [timeZone earthDate:[timeZone nextMarsDateAtHour:hr andMin:min]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    NSString *intro;
    if (armed) {
        intro = @"The";
    } else {
        intro = @"If you turn it on, the";
    }
    self.earthAlarmLabel.text = [NSString stringWithFormat:
            @"%@ next time this alarm will go off is %@.",
            intro,
            [dateFormatter stringFromDate:nextDate]];
}

- (void)updateAlarms {
    UIApplication* app = [UIApplication sharedApplication];

    if(armed) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MarsTimeZone *timeZone = [appDelegate currentTimeZone];
        MarsDate *trigger = [timeZone nextMarsDateAtHour:hr andMin:min];
        int ALARM_COUNT = 60;
        NSMutableArray *notifs = [NSMutableArray arrayWithCapacity:ALARM_COUNT];
        NSString *alert = [NSString stringWithFormat:@"It is %d:%02d!",hr,min];

        for(int day=0; day<ALARM_COUNT; day++) {
            MarsDate *marsDate = [[MarsDate alloc]
                                  initWithTZ:trigger.tz
                                  atSol:trigger.sol+day
                                  andTime:trigger.time];
            UILocalNotification *notif = [[UILocalNotification alloc] init];
            notif.alertBody = alert;
            notif.fireDate = [timeZone earthDate:marsDate];
            notif.soundName = UILocalNotificationDefaultSoundName;
            [notifs addObject:notif];
        }
        app.scheduledLocalNotifications = notifs;
    } else {
        [app cancelAllLocalNotifications];
    }
}

@end
