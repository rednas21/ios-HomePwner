//
//  ItemStore.h
//  HomePwner
//
//  Created by Sander Peerna on 6/19/15.
//  Copyright (c) 2015 Sander Peerna. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;

@interface ItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (Item *)createItem;

@end
