//
//  ImagePopoverViewController.m
//  Homepwner
//
//  Created by wayne on 14-4-12.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "ImagePopoverViewController.h"

@interface ImagePopoverViewController ()

@end

@implementation ImagePopoverViewController
-(void)loadView
{
    [super loadView];
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    self.view=imageView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImageView *imageView=(UIImageView *)self.view;
    imageView.image=self.image;
}
@end