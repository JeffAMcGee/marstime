//  AlarmsViewController.h
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 Jeffrey McGee. Licensed under the MIT license.
//

#import <UIKit/UIKit.h>

@interface AlarmsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *alarm_switch;
@property (weak, nonatomic) IBOutlet UIPickerView *time_picker;
@property (weak, nonatomic) IBOutlet UILabel *earthAlarmLabel;
@end
