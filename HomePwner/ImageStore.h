//
//  ImageStore.h
//  HomePwner
//
//  Created by Sander Peerna on 7/4/15.
//  Copyright (c) 2015 Sander Peerna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
