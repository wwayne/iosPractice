//
//  Item.m
//  Homepwner
//
//  Created by wayne on 14-3-24.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "Item.h"
#import "ImageStore.h"
@interface Item()<NSCoding>

@end

@implementation Item
-(instancetype)init{
    self=[self initWithItemName:@"" valueInDollars:0 serialNumber:@""];
    return self;
}
-(instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self=[super init];
    if(self){
        self.itemName=name;
        self.valueInDollars=value;
        self.serialNumber=sNumber;
        self.description=[NSString stringWithFormat:@"%@ with %i money",name,value];
        self.uniqueKey=[[[NSUUID alloc] init] UUIDString];
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
                                 serialNumber:[NSString stringWithFormat:@"%0.2f",(arc4random()%100*0.5)]];
    return item;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@ with %i money",self.itemName,self.valueInDollars];
}
-(UIImage *)itemImage
{
    ImageStore *imageStore=[ImageStore sharedImage];
    return [imageStore fetchImage:self.uniqueKey
            ];
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.uniqueKey forKey:@"uniqueKey"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if(self){
        _itemName=[aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber=[aDecoder decodeObjectForKey:@"serialNumber"];
        _description=[aDecoder decodeObjectForKey:@"description"];
        _uniqueKey=[aDecoder decodeObjectForKey:@"uniqueKey"];
        _valueInDollars=[aDecoder decodeIntForKey:@"valueInDollars"];
    }
    return self;
}
@end
