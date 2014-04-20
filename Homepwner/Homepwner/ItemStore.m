//
//  ItemStore.m
//  Homepwner
//
//  Created by wayne on 14-3-24.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"
#import <CoreData/CoreData.h>
#import "ImageStore.h"

@interface ItemStore()
@property (nonatomic,strong) NSMutableArray *privateItemsArray;
@property (nonatomic,strong) NSManagedObjectContext *manageContext;
@property (nonatomic,strong) NSManagedObjectModel *manageModel;
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
//        NSString *path=[self itemPath];
//        self.privateItemsArray=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        
//        if(!self.privateItemsArray){
//            self.privateItemsArray=[[NSMutableArray alloc] init];
//        }
        self.manageModel=[NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psd=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.manageModel];
        
        //where the data sqlite file go
        NSString *urlString=[self itemPath];
        NSURL *url=[NSURL URLWithString:urlString];
        
        NSError *error=nil;
        if(![psd addPersistentStoreWithType:NSSQLiteStoreType
                             configuration:nil
                                       URL:url
                                   options:nil
                                     error:&error])
        {
            @throw [NSException exceptionWithName:@"sqlite error"
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
        
        //create manage object context
        self.manageContext=[[NSManagedObjectContext alloc] init];
        self.manageContext.persistentStoreCoordinator=psd;
        [self loadFetch];
        
    }
    return self;
}
-(NSArray *)allItems{
    return [self.privateItemsArray copy];
}
-(Item *)addStoreItem{
//    Item *item=[[Item alloc] init];
    double order;
    if([self.privateItemsArray count]==0){
        order=1.0;
    }
    else{
        order=[[self.privateItemsArray lastObject] order] + 1.0 ;
    }
    NSLog(@"after adding %lu , the order is %.2f",[self.privateItemsArray count],order);
    
    Item *item=[NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.manageContext];
    [self.privateItemsArray addObject:item];

    return item;
}
-(void)removeStoreItem:(Item *)item{
    NSString *key=item.key;
    [[ImageStore sharedImage] deleteImage:key];
    [self.privateItemsArray removeObjectIdenticalTo:item];
    [self.manageContext deleteObject:item];
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
//    return [document stringByAppendingPathComponent:@"items2.0.archive"];
    return [document stringByAppendingPathComponent:@"store.data"];
}
-(BOOL)saveChange
{
//    NSString *path=[self itemPath];
//    return [NSKeyedArchiver archiveRootObject:self.privateItemsArray toFile:path];
    NSError *error;
    BOOL success=[self.manageContext save:&error];
    if(!success)
    {
        NSLog(@"error saving : %@",[error localizedDescription]);
    }
    return success;
}
-(void)loadFetch
{
    if(!self.privateItemsArray)
    {
        NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity=[NSEntityDescription entityForName:@"Item" inManagedObjectContext:self.manageContext];
        fetch.entity=entity;
        NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"order"
                                                             ascending:YES];
        fetch.sortDescriptors=@[sort];
        NSError *error;
        NSArray *itemArray=[self.manageContext executeFetchRequest:fetch
                                                             error:&error];
        if(!itemArray)
        {
            [NSException raise:@"fail"
                        format:@"%@",[error localizedDescription]];
        }
        self.privateItemsArray=[[NSMutableArray alloc] initWithArray:itemArray];
    }
}
@end
