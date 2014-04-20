//
//  NSManageItem.m
//  Homepwner
//
//  Created by wayne on 14-4-18.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "Item.h"


@implementation Item

@dynamic key;
@dynamic name;
@dynamic order;
@dynamic serial;
@dynamic thumbnail;
@dynamic value;
@dynamic toAsset;
-(void)awakeFromInsert
{
    [super awakeFromInsert];
    NSUUID *key=[[NSUUID alloc] init];
    NSString *keyString=[key UUIDString];
    self.key=keyString;
}
-(void)setThumbNailFromImage:(UIImage *)originImage{
    static NSDictionary *sizeDictionary;
    if(!sizeDictionary){
        sizeDictionary=@{
                         UIContentSizeCategoryExtraSmall:@40,
                         UIContentSizeCategorySmall:@40,
                         UIContentSizeCategoryMedium:@40,
                         UIContentSizeCategoryLarge:@40,
                         UIContentSizeCategoryExtraLarge:@50,
                         UIContentSizeCategoryExtraExtraLarge:@60,
                         UIContentSizeCategoryExtraExtraExtraLarge:@70
                         };
    }
    NSString *userChoose=[[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *size=sizeDictionary[userChoose];
    
    CGSize originSize=originImage.size;
    CGRect newRect=CGRectMake(0,0,[size floatValue],[size floatValue]);
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
    self.thumbnail=smallImage;
    
    UIGraphicsEndImageContext();
}

@end
