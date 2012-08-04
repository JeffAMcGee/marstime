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

#import <AudioToolbox/AudioToolbox.h>

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
        //FIXME: Why is initWithNibName not getting called?
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    soundLabels = [NSArray arrayWithObjects:@"Buzzer",@"Computers",@"Launch",@"Noise",@"Sputnik", nil];
    soundPaths = [NSArray arrayWithObjects:@"pds_buzz.m4a",@"computers.m4a",@"launch.m4a",@"pds_noise.m4a",@"sputnik.m4a", nil];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    hr = [prefs integerForKey:@"alarm_hr"];
    min = [prefs integerForKey:@"alarm_min"];
    armed = [prefs boolForKey:@"alarm_armed"];
    NSString *soundPath = [prefs objectForKey:@"alarm_sound"];
    if(soundPath) {
        soundIndex = [soundPaths indexOfObject:soundPath];
    } else {
        soundIndex = 2;
    }

    [self.timePicker selectRow:hr inComponent:0 animated:NO];
    [self.timePicker selectRow:min inComponent:1 animated:NO];
    [self.timePicker selectRow:soundIndex inComponent:2 animated:NO];
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
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0) {
        return 25;
    } else if(component==1){
        return 60;
    } else {
        return [soundLabels count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component==2) {
        return [soundLabels objectAtIndex:row];
    } else {
        return [NSString stringWithFormat:@"%02d", row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if(component==2) {
        return 120;
    } else {
        return 40;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

- (void)pickerView:(UIPickerView *)pickerView
            didSelectRow:(NSInteger)row
            inComponent:(NSInteger)component {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    // FIXME: this seems wrong.
    static SystemSoundID latestSound = -1;

    if(component==0) {
        hr = row;
        [prefs setInteger:row forKey:@"alarm_hr"];
    } else if (component==1) {
        min = row;
        [prefs setInteger:row forKey:@"alarm_min"];
    } else {
        soundIndex = row;
        // Store the path instead of the index so that we can add new sounds
        // without breaking things.
        NSString *path = [soundPaths objectAtIndex:row];
        [prefs setObject:path forKey:@"alarm_sound"];
        //play the sound
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
        if (latestSound!=-1) {
            AudioServicesDisposeSystemSoundID(latestSound);
        }
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &latestSound);
        AudioServicesPlaySystemSound (latestSound);
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
            notif.soundName = [soundPaths objectAtIndex:soundIndex];
            [notifs addObject:notif];
        }
        app.scheduledLocalNotifications = notifs;
    } else {
        [app cancelAllLocalNotifications];
    }
}

@end
