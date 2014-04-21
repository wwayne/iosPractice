//
//  Item.m
//  Homepwner
//
//  Created by wayne on 14-4-21.
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
- (void)awakeFromInsert
{
    [super awakeFromInsert];
    // Create an NSUUID object - and get its string representation NSUUID *uuid = [[NSUUID alloc] init];
    NSUUID *uuid=[[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    self.Key = key;
}

- (void)setThumbNailFromImage:(UIImage *)image
{
    CGSize origImageSize = image.size;
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    float ratio = MAX(newRect.size.width / origImageSize.width, newRect.size.height / origImageSize.height);
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0); UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
                                                                                         
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width; projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0; projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    [image drawInRect:projectRect];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext(); self.thumbnail = smallImage;
    UIGraphicsEndImageContext(); }

@end
