//
//  WebViewController.h
//  Nerdcourse
//
//  Created by wayne on 14-4-13.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UISplitViewControllerDelegate>
@property (nonatomic,strong) NSURL *url;
@end
