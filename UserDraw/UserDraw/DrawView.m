//
//  DrawView.m
//  UserDraw
//
//  Created by wayne on 14-3-27.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "DrawView.h"
#import "LineView.h"

@interface DrawView()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSMutableDictionary *currentLines;
@property (nonatomic,strong) NSMutableArray *finishLines;
@property (nonatomic,weak) LineView *selectedLine;
@property (nonatomic,strong) UIPanGestureRecognizer *panGesture;
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
        //doucble tap delete
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        tapGesture.numberOfTapsRequired=2;
        tapGesture.delaysTouchesBegan=YES;
        [self addGestureRecognizer:tapGesture];
        //one tap choose a line
        UITapGestureRecognizer *chooseLineTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPoint:)];
        tapGesture.delaysTouchesBegan=YES;
        [tapGesture requireGestureRecognizerToFail:tapGesture];
        [self addGestureRecognizer:chooseLineTap];
        //long gesture
        UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
        //pan
        self.panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(dragMove:)];
        self.panGesture.delegate=self;
        self.panGesture.cancelsTouchesInView=NO;
        [self addGestureRecognizer:self.panGesture];
    }
    return self;
}
-(void)dragMove:(UIPanGestureRecognizer *)gesture{
    if(!self.selectedLine){
        return;
    }
    if(gesture.state==UIGestureRecognizerStateChanged){
        //just how far from the origin
        CGPoint location=[gesture translationInView:self];
        CGPoint begin=self.selectedLine.begin;
        CGPoint end=self.selectedLine.end;
        begin.x=begin.x+location.x;
        begin.y=begin.y+location.y;
        end.x=end.x+location.x;
        end.y=end.y+location.y;
        self.selectedLine.begin=begin;
        self.selectedLine.end=end;
        [self setNeedsDisplay];
        [gesture setTranslation:CGPointZero inView:self];
    }
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if(gestureRecognizer==self.panGesture){
        return YES;
    }
    return NO;
}
-(void)doubleTap:(UIGestureRecognizer *)gesture
{
    [self.currentLines removeAllObjects];
    [self.finishLines removeAllObjects];
    [self setNeedsDisplay];
}
-(void)tapPoint:(UIGestureRecognizer *)gesture
{
    CGPoint point=[gesture locationInView:self];
    self.selectedLine=[self chooseLine:point];
    if(self.selectedLine){
        [self becomeFirstResponder];
        UIMenuController *menu=[UIMenuController sharedMenuController];
        UIMenuItem *delete=[[UIMenuItem alloc] initWithTitle:@"delete"
                                                      action:@selector(deleteALine)];
        UIMenuItem *deleteAll=[[UIMenuItem alloc] initWithTitle:@"deleteAll"
                                                      action:@selector(deleteAllLine)];
        menu.menuItems=@[delete,deleteAll];
        [menu setTargetRect:CGRectMake(point.x, point.y, 0,0) inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
    else{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    [self setNeedsDisplay];
}
-(void)longPress:(UIGestureRecognizer *)gesture
{
    if(gesture.state==UIGestureRecognizerStateBegan){
        CGPoint location=[gesture locationInView:self];
        self.selectedLine=[self chooseLine:location];
        if(self.selectedLine){
            self.currentLines=nil;
        }
    }
    else if(gesture.state==UIGestureRecognizerStateEnded){
        self.selectedLine=nil;
    }
    [self setNeedsDisplay];
}
-(BOOL)canBecomeFirstResponder{
    return  YES;
}
-(void)deleteAllLine
{
    [self.finishLines removeAllObjects];
    [self setNeedsDisplay];
}
-(void)deleteALine
{
    [self.finishLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
}
-(LineView *)chooseLine:(CGPoint)point
{
    for (LineView *line in self.finishLines){
        CGPoint begin=line.begin;
        CGPoint end=line.end;
        for(float i =0 ;i<1.0;i+=0.05){
            float x=begin.x+(end.x-begin.x)*i;
            float y=begin.y+(end.y-begin.y)*i;
            float distance=hypot(x - point.x, y - point.y);
            if(distance<20.0){
                return line;
            }
        }
    }
    return nil;
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
    [[UIColor greenColor] setStroke];
    if(self.selectedLine){
        [self drawLine:self.selectedLine];
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
