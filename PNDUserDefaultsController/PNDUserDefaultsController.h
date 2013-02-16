//
//  PNDUserDefaultsController.h
//  PNDUserDefaultsController
//
//  Created by Alexsander Akers on 2/15/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNDUserDefaultsController : NSObject

+ (instancetype)sharedController;

+ (NSDictionary *)propertiesForUserDefaultsKeys;

@end
