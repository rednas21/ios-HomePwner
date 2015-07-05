//
//  ItemStore.m
//  HomePwner
//
//  Created by Sander Peerna on 6/19/15.
//  Copyright (c) 2015 Sander Peerna. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"
#import "ImageStore.h"

@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation ItemStore

+ (instancetype)sharedStore
{
    static ItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (Item *)createItem
{
    Item *item = [Item randomItem];
    
    [self.privateItems addObject:item];
    
    return item;
}

- (void)addItem:(Item *)item
{
    [self.privateItems addObject:item];
}

- (void)removeItem:(Item *)item
{
    NSString *key = item.itemKey;
    
    [[ImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) return;
    
    Item *fromItem = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:toIndex];
    [self.privateItems insertObject:fromItem atIndex:toIndex];
}

@end
