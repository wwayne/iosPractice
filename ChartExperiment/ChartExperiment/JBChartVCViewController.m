//
//  JBChartVCViewController.m
//  ChartExperiment
//
//  Created by wayne on 14-3-28.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "JBChartVCViewController.h"
#import "JBBarChartView.h"

@interface JBChartVCViewController ()<JBBarChartViewDelegate, JBBarChartViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet JBBarChartView *barChart;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation JBChartVCViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArray=[[NSArray alloc] initWithObjects:@1.0,@2.0,@3.0,@4.0,@5.0, nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}
-(void)loadView
{
    [super loadView];
    self.barChart.delegate = self;
    self.barChart.dataSource = self;
    [self.barChart reloadData];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.barChart setState:JBChartViewStateExpanded];
    self.label.text=@"bar";
 
}
- (UIView *)barChartView:(JBBarChartView *)barChartView barViewAtIndex:(NSUInteger)index
{
    UIView *barView = [[UIView alloc] init];
    barView.backgroundColor = [UIColor greenColor];
    return barView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return 5;
}
- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtAtIndex:(NSUInteger)index
{
    return [self.dataArray[index] floatValue];
}


@end
