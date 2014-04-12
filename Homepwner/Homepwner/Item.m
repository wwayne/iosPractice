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
-(void)setThumbNailFromImage:(UIImage *)originImage{
    CGSize originSize=originImage.size;
    CGRect newRect=CGRectMake(0,0,40,40);
    CGFloat ratio=MIN(originSize.width/newRect.size.width,originSize.height/newRect.size.height);
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0);
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:newRect
                                                  cornerRadius:5.0];
    [path addClip];
    
    CGRect pathRect;
    pathRect.size=CGSizeMake(originSize.width/ratio, originSize.height/ratio);
    pathRect.origin=CGPointMake((newRect.size.width-pathRect.size.width)/2.0, (newRect.size.height-pathRect.size.height)/2.0);
    [originImage drawInRect:pathRect];
   
    UIImage *smallImage=UIGraphicsGetImageFromCurrentImageContext();
    self.thumbNail=smallImage;
    
    UIGraphicsEndImageContext();
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.uniqueKey forKey:@"uniqueKey"];
    [aCoder encodeObject:self.thumbNail forKey:@"thumbNail"];
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
        _thumbNail=[aDecoder decodeObjectForKey:@"thumbNail"];
    }
    return self;
}
@end
