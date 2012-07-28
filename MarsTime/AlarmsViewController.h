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
}

@property (weak, nonatomic) IBOutlet UISwitch *alarmSwitch;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;
@property (weak, nonatomic) IBOutlet UILabel *earthAlarmLabel;

- (void)updateEarthLabel;
@end
