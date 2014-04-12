//
//  ItemCell.h
//  Homepwner
//
//  Created by wayne on 14-4-10.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemSerial;
@property (weak, nonatomic) IBOutlet UILabel *itemValue;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;
@property (copy,nonatomic) void(^tapButton)();
@end
