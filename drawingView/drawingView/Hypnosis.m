//
//  Hypnosis.m
//  drawingView
//
//  Created by wayne on 14-3-18.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "Hypnosis.h"
#import "CustomView.h"

@interface Hypnosis ()<UITextFieldDelegate>

@end

@implementation Hypnosis

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title=@"Hypnosis";
        self.tabBarItem.image=[UIImage imageNamed:@"Hypno"];
    }
    return self;
}
-(void)loadView
{
    CustomView *backgroundView=[[CustomView alloc] init];
    CGRect textFieldRect=CGRectMake(100,150,150,20);
    UITextField *textField=[[UITextField alloc] initWithFrame:textFieldRect];
    textField.borderStyle=UITextBorderStyleRoundedRect;
    textField.placeholder=@"wangzixiao";
    textField.returnKeyType=UIReturnKeyDone;
    textField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    textField.enablesReturnKeyAutomatically=YES;
    textField.delegate=self;
    [backgroundView addSubview:textField];
    self.view=backgroundView;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self getRandomLabel:textField.text];
    textField.text=@"";
    [textField resignFirstResponder];
    return YES;
}
-(void)getRandomLabel:(NSString *)text{
    UILabel *label=[[UILabel alloc] init];
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor blackColor];
    label.text=text;
    [label sizeToFit];
    
    int y=(int)(self.view.bounds.size.height-label.bounds.size.height);
    int originY=arc4random()%y;
    int x=(int)(self.view.bounds.size.width-label.bounds.size.width);
    int originX=arc4random()%x;
    CGRect frame=label.frame;
    frame.origin=CGPointMake(originX, originY);
    label.frame=frame;
    [self.view addSubview:label];
    
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
