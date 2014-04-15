//
//  BarVC.m
//  Chart
//
//  Created by wayne on 14-4-15.
//  Copyright (c) 2014年 brilliantech. All rights reserved.
//

#import "BarVC.h"
#import "JBBarChartView.h"
#import "JBChartInformationView.h"

CGFloat const kJBBarChartViewControllerChartHeight = 250.0f;
CGFloat const kJBBarChartViewControllerChartPadding = 10.0f;
CGFloat const kJBBarChartViewControllerChartHeaderHeight = 80.0f;
CGFloat const kJBBarChartViewControllerChartHeaderPadding = 10.0f;
CGFloat const kJBBarChartViewControllerChartFooterHeight = 25.0f;
CGFloat const kJBBarChartViewControllerChartFooterPadding = 5.0f;
CGFloat const kJBBarChartViewControllerBarPadding = 10;
NSInteger const kJBBarChartViewControllerNumBars = 120;
NSInteger const kJBBarChartViewControllerMaxBarHeight = 10;
NSInteger const kJBBarChartViewControllerMinBarHeight = 5;




@interface BarVC ()<JBBarChartViewDelegate,JBBarChartViewDataSource>
@property (strong, nonatomic) IBOutlet JBBarChartView *barView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (nonatomic, strong) JBChartInformationView *informationView;
@end



@implementation BarVC

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
    // Do any additional setup after loading the view.
    
    self.barView = [[JBBarChartView alloc] init];
    
    self.barView.delegate=self;
    self.barView.dataSource=self;
    //    barChart.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.barView];
    
}
-(void) loadView
{
    [super loadView];
    self.informationView = [[JBChartInformationView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, CGRectGetMaxY(self.barView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.barView.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    [self.view addSubview:self.informationView];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.barView.frame = CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height/2);
    [self.barView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.barView.frame = CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height/2);
    [self.barView reloadData];
}
-(CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtAtIndex:(NSUInteger)index
{
    return arc4random()%20;
}
-(NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return 30;
}
- (UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView
{
    return [UIColor redColor];
}
- (UIView *)barChartView:(JBBarChartView *)barChartView barViewAtIndex:(NSUInteger)index
{
    UIView *barView = [[UIView alloc] init];
    barView.backgroundColor = (index % 2 == 0) ? [UIColor blueColor] : [UIColor grayColor];
    return barView;
}

- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint
{
    NSNumber *valueNumber = @22;
    [self.informationView setValueText:[NSString stringWithFormat:@"%d",[valueNumber intValue]] unitText:nil];
    [self.informationView setHidden:NO animated:YES];
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
