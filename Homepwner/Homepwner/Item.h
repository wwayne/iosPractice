//
//  Item.h
//  Homepwner
//
//  Created by wayne on 14-3-24.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Item : NSObject

@property (nonatomic,copy)NSString *itemName;
@property (nonatomic,copy)NSString *serialNumber;
@property (nonatomic,copy)NSString *description;
@property int valueInDollars;
@property (nonatomic,copy)UIImage *itemImage;
@property (nonatomic,copy)UIImage *thumbNail;
@property (nonatomic,strong)NSString *uniqueKey;
+(instancetype)randomItem;
-(instancetype)initWithItemName:(NSString *)name
                 valueInDollars:(int)value
                   serialNumber:(NSString *)sNumber;
-(instancetype)initWithItemName:(NSString *)name;
@end
