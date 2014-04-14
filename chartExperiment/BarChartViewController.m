//
//  BarChartViewController.m
//  chartExperiment
//
//  Created by wayne on 14-4-10.
//  Copyright (c) 2014年 brilliantech. All rights reserved.
//

#import "BarChartViewController.h"
#import "JBBarChartView.h"
@interface BarChartViewController ()<JBBarChartViewDelegate,JBBarChartViewDataSource>
@property (nonatomic,strong) UILabel *label;
@end

@implementation BarChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       self.tabBarItem.title=@"Bar";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JBBarChartView *barChart=[[JBBarChartView alloc] initWithFrame:CGRectMake(0, 30,self.view.bounds.size.width,self.view.bounds.size.height/2)];
    barChart.delegate=self;
    barChart.dataSource=self;
//    barChart.backgroundColor=[UIColor blackColor];
    [self.view addSubview:barChart];
    [barChart reloadData];
}
-(CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtAtIndex:(NSUInteger)index
{
    return arc4random()%20;
}
-(NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return 331;
}
- (UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView
{
    return [UIColor greenColor];
}
- (UIView *)barChartView:(JBBarChartView *)barChartView barViewAtIndex:(NSUInteger)index
{
    UIView *barView = [[UIView alloc] init];
     barView.backgroundColor = (index % 2 == 0) ? [UIColor redColor] : [UIColor blueColor];
    return barView;
}
- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint
{
    
    if(self.label){
        [self.label removeFromSuperview];
        self.label=nil;
    }
    UILabel *label=[[UILabel alloc] init];
    label.text=@"wangzixiao";
    label.frame=CGRectMake(20,330,250,20);
    [self.view addSubview:label];
    self.label=label;
}

- (void)didUnselectBarChartView:(JBBarChartView *)barChartView
{
    // Update view
    [self.label removeFromSuperview];
    self.label=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
