//
//  JBChartVCViewController.m
//  ChartExperiment
//
//  Created by wayne on 14-3-28.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "JBChartVCViewController.h"

@interface JBChartVCViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation JBChartVCViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.label.text=@"bar";
 
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
