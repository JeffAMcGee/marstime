//  FirstViewController.h
//  MarsTime
//
//  Created by Jeffrey McGee on 5/20/12.
//  Copyright (c) 2012 Jeffrey McGee. Licensed under the MIT license.
//

#import <UIKit/UIKit.h>

@class MarsTimeZone;

@interface ClockViewController : UIViewController {
    NSTimer *clockTimer;
}

@property (weak, nonatomic) IBOutlet UILabel *tz_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *date_label;
@property (weak, nonatomic) MarsTimeZone *timeZone;

@end
