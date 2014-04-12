//
//  ImageStore.h
//  Homepwner
//
//  Created by wayne on 14-3-27.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageStore : UIViewController

+(instancetype)sharedImage;
-(void)addImage:(UIImage *)image forKey:(NSString *)key;
-(id)fetchImage:(NSString *)key;
-(void)deleteImage:(NSString *)key;
-(NSDictionary *)getImageArray;
-(NSString *)imageStorePath:(NSString *)key;
@end
