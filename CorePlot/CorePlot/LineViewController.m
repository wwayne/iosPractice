//
//  LineViewController.m
//  CorePlot
//
//  Created by wayne on 14-4-14.
//  Copyright (c) 2014年 brilliantech. All rights reserved.
//

#import "LineViewController.h"

@interface LineViewController ()<CPTPlotDataSource,CPTAxisDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hostViewHeight;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *hostView;

@end

@implementation LineViewController

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
    self.dataArray=[[NSMutableArray alloc] init];
    for(int i=0;i<10;i++){
        [self.dataArray addObject:[NSNumber numberWithInt:arc4random()%20+1]];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self fixOrientation];
}
-(void)fixOrientation
{
    self.hostViewHeight.constant=self.view.frame.size.height/2 ;
//    UIDeviceOrientation currentOrientation=[[UIDevice currentDevice] orientation];
//    if(UIDeviceOrientationIsLandscape(currentOrientation)){
//        self.hostViewHeight.constant=self.view.frame.size.height/2 ;
//    }
//    else{
//        self.hostViewHeight.constant=self.view.frame.size.height/2 ;
//    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //图形要放在一个CPTGraphHosting中(uiview)
    [self fixOrientation];
    //在CPTGragh中画图，CPTXYGraph是个曲线图
    CPTXYGraph *graph=[[CPTXYGraph alloc] initWithFrame:self.hostView.frame];
    if(graph){
        self.hostView.hostedGraph=graph;
        CPTScatterPlot *scatter=[[CPTScatterPlot alloc] initWithFrame:graph.bounds];
        [graph addPlot:scatter];
        scatter.dataSource=self;
        
        //设置 PlotSpace，这里的 xRange 和 yRange 要理解好，它决定了点是否落在图形的可见区域
        //location 值表示坐标起始值，一般可以设置元素中的最小值
        //length 值表示从起始值上浮多少，一般可以用最大值减去最小值的结果
        CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace *)scatter.plotSpace;
        plotSpace.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0)
                                                      length:CPTDecimalFromFloat([self.dataArray count]-1)];
        plotSpace.yRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0)
                                                      length:CPTDecimalFromFloat(20)];
    }
   

}
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self.dataArray count];
}
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx
{
    if(fieldEnum == CPTScatterPlotFieldY){
        //询问 Y 值时
        return [self.dataArray objectAtIndex:idx];
    }else{
        //询问 X 值时
        return [NSNumber numberWithInt:idx];
    }
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
