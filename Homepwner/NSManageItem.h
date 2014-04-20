//
//  NSManageItem.h
//  Homepwner
//
//  Created by wayne on 14-4-18.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface NSManageItem : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) float  * order;
@property (nonatomic, retain) NSString * serial;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic) int * value;
@property (nonatomic, retain) NSManagedObject *toAsset;
-(void)setThumbNailFromImage:(UIImage *)image;
@end
