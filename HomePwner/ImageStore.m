//
//  ImageStore.m
//  HomePwner
//
//  Created by Sander Peerna on 7/4/15.
//  Copyright (c) 2015 Sander Peerna. All rights reserved.
//

#import "ImageStore.h"

@interface ImageStore()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation ImageStore

+ (instancetype)sharedStore
{
    static ImageStore *sharedStore = nil;
    
    if (!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ImageStore sharedStore]" userInfo:nil];
            
    return nil;
}
            
- (instancetype)initPrivate
{
    self = [super init];
    
    if (self)
    {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)setImage:(id)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key)
    {
        return;
    }
    
    [self.dictionary removeObjectForKey:key];
}

@end
