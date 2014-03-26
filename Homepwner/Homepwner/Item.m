//
//  Item.m
//  Homepwner
//
//  Created by wayne on 14-3-24.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "Item.h"
@interface Item()

@end

@implementation Item
-(instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self=[super init];
    if(self){
        self.itemName=name;
        self.valueInDollars=value;
        self.serialNumber=sNumber;
        self.description=[NSString stringWithFormat:@"%@ with %i money",name,value];
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
    Item *item=[[Item alloc] initWithItemName:@"wayne"
                               valueInDollars:arc4random()%100
                                 serialNumber:[NSString stringWithFormat:@"%f",(arc4random()%100*0.5)]];
    return item;
}
@end
