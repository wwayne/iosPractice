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
    if(!store){
        store=[[self alloc] initPrivate];
    }
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
        self.privateItemsArray=[[NSMutableArray alloc] init];
    }
    return self;
}
-(NSArray *)allItems{
    return [self.privateItemsArray copy];
}
-(Item *)addStoreItem{
    return nil;
}
@end
