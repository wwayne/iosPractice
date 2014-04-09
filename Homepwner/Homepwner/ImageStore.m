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
    NSString *storePath=[self imageStorePath:key];
    NSData *data=UIImageJPEGRepresentation(image, 0.5);
    [data writeToFile:storePath atomically:YES];
}

-(id)fetchImage:(NSString *)key{
    UIImage *result=[self.dictionary objectForKey:key];
    if(!result){
        NSString *path=[self imageStorePath:key];
        result=[UIImage imageWithContentsOfFile:path];
        if(result){
            self.dictionary[key]=result;
        }
        else{
            NSLog(@"can;t find the image");
        }
    }
    return result;
}

-(void)deleteImage:(NSString *)key
{
    [self.dictionary removeObjectForKey:key];
    NSString *storePath=[self imageStorePath:key];
    [[NSFileManager defaultManager] removeItemAtPath:storePath
                                               error:nil];
}

-(NSArray *)getImageArray
{
    return [self.dictionary copy];
}
//储存image的路径
-(NSString *)imageStorePath:(NSString *)key
{
    NSArray *documents=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document=[documents firstObject];
    return [document stringByAppendingPathComponent:key];
}
@end
