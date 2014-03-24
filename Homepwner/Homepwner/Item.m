//
//  Item.m
//  Homepwner
//
//  Created by wayne on 14-3-24.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "Item.h"

@implementation Item
-(instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self=[super init];
    if(self){
        self.itemName=name;
        self.valueInDollars=value;
        self.serialNumber=sNumber;
    }
    return self;
}
-(instancetype)initWithItemName:(NSString *)name
{
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:@""];
}
+(instancetype)randomItem{
    
}
@end
