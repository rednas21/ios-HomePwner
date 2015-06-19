//
//  Item.h
//  HomePwner
//
//  Created by Sander Peerna on 6/19/15.
//  Copyright (c) 2015 Sander Peerna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

@property (nonatomic, strong) Item *containedItem;
@property (nonatomic, weak) Item *container;

+(instancetype)randomItem;

-(instancetype)initWithItemName: (NSString *)name valueInDollars: (int)value serialNumber: (NSString *)sNumber;
-(instancetype)initWithItemName: (NSString *)name;

@end
