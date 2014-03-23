//
//  Calendar.m
//  drawingView
//
//  Created by wayne on 14-3-18.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "Calendar.h"

@interface Calendar ()
@property (weak,nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation Calendar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title=@"Time";
        self.tabBarItem.image=[UIImage imageNamed:@"Time"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)addReminder:(id)sender{
    NSDate *date=self.datePicker.date;
    NSLog(@"Date is %@",date);
    
    UILocalNotification *note=[[UILocalNotification alloc] init];
    note.alertBody=@"wangzixiao";
    note.fireDate=date;
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
