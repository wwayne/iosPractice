//
//  ItemDetailVC.h
//  Homepwner
//
//  Created by wayne on 14-3-26.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface ItemDetailVC : UIViewController
@property (nonatomic,strong) Item *item;
@property (nonatomic,copy) void (^dismiss)(void);
-(instancetype)initForBool:(BOOL)modal;
@end
