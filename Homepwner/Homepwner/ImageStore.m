//
//  ImageStore.m
//  Homepwner
//
//  Created by wayne on 14-3-27.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "ImageStore.h"

@interface ImageStore ()
@property (nonatomic,strong) NSMutableDictionary *dictionary;
@end

@implementation ImageStore
+(instancetype)sharedImage{
    static ImageStore* imageStore=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        imageStore=[[ImageStore alloc] initPrivate];
    });
    return imageStore;
}
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"init fault"
                                   reason:@"u should use sharedImage"
                                 userInfo:nil];
    return nil;
}
-(instancetype)initPrivate
{
    self=[super init];
    if(self){
        self.dictionary=[[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)addImage:(UIImage *)image forKey:(NSString *)key
{
    [self.dictionary setObject:image forKey:key];
    
}
-(id)fetchImage:(NSString *)key{
    return[self.dictionary objectForKey:key];
}
-(void)deleteImage:(NSString *)key
{
    [self.dictionary removeObjectForKey:key];
}
-(NSArray *)getImageArray
{
    return [self.dictionary copy];
}
@end
