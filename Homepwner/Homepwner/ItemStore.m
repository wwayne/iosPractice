//
//  ItemStore.m
//  Homepwner
//
//  Created by wayne on 14-3-24.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"
@interface ItemStore()
@property (nonatomic,strong)NSMutableArray *privateItemsArray;
@end

@implementation ItemStore
+(instancetype)sharedStore
{
    static ItemStore *store=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store=[[self alloc] initPrivate];
    });
    return store;
}
-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +shareStore"
                                 userInfo:nil];
    return nil;
}
-(instancetype)initPrivate
{
    self=[super init];
    if(self){
        NSString *path=[self itemPath];
        self.privateItemsArray=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if(!self.privateItemsArray){
            self.privateItemsArray=[[NSMutableArray alloc] init];
        }
    }
    return self;
}
-(NSArray *)allItems{
    return [self.privateItemsArray copy];
}
-(Item *)addStoreItem{
    Item *item=[[Item alloc] init];
    [self.privateItemsArray addObject:item];

    return item;
}
-(void)removeStoreItem:(Item *)item{
    [self.privateItemsArray removeObjectIdenticalTo:item];

}
-(void)moveItemPositon:(NSUInteger)from to:(NSUInteger)to
{
    Item *moveItem=self.privateItemsArray[from];
    [self.privateItemsArray removeObjectAtIndex:from];
    [self.privateItemsArray insertObject:moveItem atIndex:to];
}
-(NSString *)itemPath
{
    NSArray *documentDictionary=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document=[documentDictionary firstObject];
    return [document stringByAppendingPathComponent:@"items2.0.archive"];
}
-(BOOL)saveChange
{
    NSString *path=[self itemPath];
    return [NSKeyedArchiver archiveRootObject:self.privateItemsArray toFile:path];
}
@end
