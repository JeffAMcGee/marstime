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

@property (weak, nonatomic) IBOutlet UILabel *tzLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) MarsTimeZone *timeZone;

@end
