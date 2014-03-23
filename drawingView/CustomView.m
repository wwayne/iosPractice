//
//  CustomView.m
//  drawingView
//
//  Created by wayne on 14-3-12.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "Hypnosis.h"
#import "CustomView.h"

@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGPoint center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius=MIN(self.bounds.size.width/2-10,self.bounds.size.height/2-10);
    UIBezierPath *path=[[UIBezierPath alloc] init];
    for (int i=0;i<ceil(radius/12.0);i++){
        [path addArcWithCenter:center
                        radius:radius-i*12
                    startAngle:0.0
                      endAngle:M_PI*2
                     clockwise:YES];
        [path moveToPoint:CGPointMake(self.bounds.size.width/2+radius-(i+1)*12, self.bounds.size.height/2)];
    }
    
    path.lineWidth=3;
    [[UIColor lightGrayColor] setStroke];
    [path stroke];
    
}


@end
