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
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *hostView;

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
    [self constructScatterPlot];
//    self.dataArray=[[NSMutableArray alloc] init];
//    for(int i=0;i<10;i++){
//        [self.dataArray addObject:[NSNumber numberWithInt:arc4random()%20+1]];
//    }
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
-(void)constructScatterPlot
{
    //在CPTGragh中画图，CPTXYGraph是个曲线图
    CGRect frame=self.hostView.frame;
    self.hostView=[[CPTGraphHostingView alloc] initWithFrame:frame];
    CPTXYGraph *graph=[[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    if(graph){
        CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
        [graph applyTheme:theme];
        self.hostView.hostedGraph=graph;
        
        graph.paddingLeft   = 10.0;
        graph.paddingTop    = 10.0;
        graph.paddingRight  = 10.0;
        graph.paddingBottom = 10.0;
        
        
        // Setup plot space
        CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
        plotSpace.allowsUserInteraction = YES;
        plotSpace.xRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(1.0) length:CPTDecimalFromDouble(2.0)];
        plotSpace.yRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(1.0) length:CPTDecimalFromDouble(3.0)];
        
        // Axes
        CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
        CPTXYAxis *x          = axisSet.xAxis;
        x.majorIntervalLength         = CPTDecimalFromDouble(0.5);
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(2.0);
        x.minorTicksPerInterval       = 2;
        NSArray *exclusionRanges = @[[CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(1.99) length:CPTDecimalFromDouble(0.02)],
                                     [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.99) length:CPTDecimalFromDouble(0.02)],
                                     [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(2.99) length:CPTDecimalFromDouble(0.02)]];
        x.labelExclusionRanges = exclusionRanges;
        
        CPTXYAxis *y = axisSet.yAxis;
        y.majorIntervalLength         = CPTDecimalFromDouble(0.5);
        y.minorTicksPerInterval       = 5;
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(2.0);
        exclusionRanges               = @[[CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(1.99) length:CPTDecimalFromDouble(0.02)],
                                          [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.99) length:CPTDecimalFromDouble(0.02)],
                                          [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(3.99) length:CPTDecimalFromDouble(0.02)]];
        y.labelExclusionRanges = exclusionRanges;
        
        // Create a green plot area
        CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
        dataSourceLinePlot.identifier = @"Green Plot";
        
        CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
        lineStyle.lineWidth              = 3.0;
        lineStyle.lineColor              = [CPTColor greenColor];
        lineStyle.dashPattern            = @[@5.0f, @5.0f];
        dataSourceLinePlot.dataLineStyle = lineStyle;
        
        dataSourceLinePlot.dataSource = self;
        
        // Put an area gradient under the plot above
        CPTColor *areaColor       = [CPTColor colorWithComponentRed:0.3 green:1.0 blue:0.3 alpha:0.8];
        CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
        areaGradient.angle = -90.0;
        CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient];
        dataSourceLinePlot.areaFill      = areaGradientFill;
        dataSourceLinePlot.areaBaseValue = CPTDecimalFromDouble(1.75);
        
        // Animate in the new plot, as an example
        dataSourceLinePlot.opacity        = 0.0;
        dataSourceLinePlot.cachePrecision = CPTPlotCachePrecisionDecimal;
        [graph addPlot:dataSourceLinePlot];
        
        CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeInAnimation.duration            = 1.0;
        fadeInAnimation.removedOnCompletion = NO;
        fadeInAnimation.fillMode            = kCAFillModeForwards;
        fadeInAnimation.toValue             = @1.0;
        [dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
        
        // Create a blue plot area
        CPTScatterPlot *boundLinePlot = [[CPTScatterPlot alloc] init];
        boundLinePlot.identifier = @"Blue Plot";
        
        lineStyle            = [boundLinePlot.dataLineStyle mutableCopy];
        lineStyle.miterLimit = 1.0;
        lineStyle.lineWidth  = 3.0;
        lineStyle.lineColor  = [CPTColor blueColor];
        
        boundLinePlot.dataSource     = self;
        boundLinePlot.cachePrecision = CPTPlotCachePrecisionDouble;
        boundLinePlot.interpolation  = CPTScatterPlotInterpolationHistogram;
        [graph addPlot:boundLinePlot];
        
        // Do a blue gradient
        CPTColor *areaColor1       = [CPTColor colorWithComponentRed:0.3 green:0.3 blue:1.0 alpha:0.8];
        CPTGradient *areaGradient1 = [CPTGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
        areaGradient1.angle         = -90.0;
        areaGradientFill            = [CPTFill fillWithGradient:areaGradient1];
        boundLinePlot.areaFill      = areaGradientFill;
        boundLinePlot.areaBaseValue = [[NSDecimalNumber zero] decimalValue];
        
        // Add plot symbols
        CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
        symbolLineStyle.lineColor = [CPTColor blackColor];
        CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor blueColor]];
        plotSymbol.lineStyle     = symbolLineStyle;
        plotSymbol.size          = CGSizeMake(10.0, 10.0);
        boundLinePlot.plotSymbol = plotSymbol;
        
        // Add some initial data
        NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:100];
        for ( NSUInteger i = 0; i < 60; i++ ) {
            NSNumber *x = @(1 + i * 0.05);
            NSNumber *y = @(1.2 * rand() / (double)RAND_MAX + 1.2);
            [contentArray addObject:@{ @"x": x, @"y": y }];
        }
        self.dataArray = contentArray;
        
        
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //图形要放在一个CPTGraphHosting中(uiview)
    [self fixOrientation];
    

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
