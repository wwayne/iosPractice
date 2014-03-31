//
//  DrawView.m
//  UserDraw
//
//  Created by wayne on 14-3-27.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "DrawView.h"
#import "LineView.h"

@interface DrawView()
@property (nonatomic,strong) NSMutableDictionary *currentLines;
@property (nonatomic,strong) NSMutableArray *finishLines;
@end

@implementation DrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.currentLines=[[NSMutableDictionary alloc] init];
        self.finishLines=[[NSMutableArray alloc] init];
        self.multipleTouchEnabled=YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.backgroundColor=[UIColor whiteColor];
    // Drawing code
    [[UIColor lightGrayColor] setStroke];
    for (LineView *line in self.finishLines){
        [self drawLine:line];
    }
    [[UIColor blueColor] setStroke];
    for(NSValue *key in self.currentLines){
        LineView *line=self.currentLines[key];
        [self drawLine:line];
    }
}
-(void)drawLine:(LineView *)line{
    UIBezierPath *bezier=[[UIBezierPath alloc] init];
    bezier.lineCapStyle=kCGLineCapRound;
    bezier.lineWidth=2;
    [bezier moveToPoint:line.begin];
    [bezier addLineToPoint:line.end];
    [bezier stroke];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in touches){
        NSValue *key=[NSValue valueWithNonretainedObject:touch];
        CGPoint location=[touch locationInView:self];
        LineView *line=[[LineView alloc] init];
        line.begin=location;
        line.end=location;
        self.currentLines[key]=line;
    }
    [self setNeedsDisplay];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in touches){
        NSValue *key=[NSValue valueWithNonretainedObject:touch];
        CGPoint location=[touch locationInView:self];
        [self.currentLines[key] setEnd:location];
    }
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in touches){
        NSValue *key=[NSValue valueWithNonretainedObject:touch];
        [self.finishLines addObject:self.currentLines[key]];
        [self.currentLines removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.currentLines removeAllObjects];
    [self setNeedsDisplay];
}
@end
