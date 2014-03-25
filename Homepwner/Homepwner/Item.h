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
@property int valueInDollars;
@property (nonatomic,strong,readonly)NSDate *dateCreated;
+(instancetype)randomItem;
-(instancetype)initWithItemName:(NSString *)name
                 valueInDollars:(int)value
                   serialNumber:(NSString *)sNumber;
-(instancetype)initWithItemName:(NSString *)name;
@end
