//
//  CountDownViewController.m
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 14/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import "CountDownViewController.h"

@interface CountDownViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblDays;
@property (weak, nonatomic) IBOutlet UILabel *lblHours;
@property (weak, nonatomic) IBOutlet UILabel *lblMinutes;
@property (weak, nonatomic) IBOutlet UILabel *lblSenconds;

@end

@implementation CountDownViewController
{
    NSTimer *timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationEnteredInBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    // Do any additional setup after loading the view.
}

-(void)applicationEnteredInBackground : (NSNotification *)notification
{
    UIApplication *app = [UIApplication sharedApplication];
    
    //create new uiBackgroundTask
    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    //and create new timer with async call:
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //run function methodRunAfterBackground
        NSTimer* t = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
}

-(void) updateCountdown
{
    
    NSString *dateString = @"16-12-2015";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    
    NSDateComponents *componentsHours = [calendar components:NSCalendarUnitHour fromDate:now];
    NSDateComponents *componentMint = [calendar components:NSCalendarUnitMinute fromDate:now];
    NSDateComponents *componentSec = [calendar components:NSCalendarUnitSecond fromDate:now];
    
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componentsDaysDiff = [gregorianCalendar components:NSCalendarUnitDay
                                                                fromDate:now
                                                                  toDate:dateFromString
                                                                 options:0];
    
    
    
    self.lblDays.text=[NSString stringWithFormat:@"%02ld",(long)componentsDaysDiff.day];
    self.lblHours.text=[NSString stringWithFormat:@"%02ld",(24-componentsHours.hour)];
    self.lblMinutes.text=[NSString stringWithFormat:@"%02ld",(60-componentMint.minute)];
    self.lblSenconds.text=[NSString stringWithFormat:@"%02ld",(60-componentSec.second)];
    
    
    
}


@end
