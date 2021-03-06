//  AlarmsViewController.h
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 Jeffrey McGee. Licensed under the MIT license.
//

#import <UIKit/UIKit.h>

@interface AlarmsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    int hr;
    int min;
    BOOL armed;
    NSArray *soundLabels;
    NSArray *soundPaths;
    int soundIndex;
}

@property (weak, nonatomic) IBOutlet UISwitch *alarmSwitch;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;
@property (weak, nonatomic) IBOutlet UILabel *earthAlarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *pickerLabel;

- (void)updateEarthLabel;
- (void)toggleView:(UIView*)view;
- (void)updateAlarms;
- (void)switchFlipped:(id)sender;

@end
