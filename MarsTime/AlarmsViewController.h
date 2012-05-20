//
//  AlarmsViewController.h
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *alarm_switch;
@property (weak, nonatomic) IBOutlet UIPickerView *time_picker;

@end
