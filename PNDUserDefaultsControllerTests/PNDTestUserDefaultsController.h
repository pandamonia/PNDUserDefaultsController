//
//  PNDTestUserDefaultsController.h
//  PNDUserDefaultsController
//
//  Created by Alexsander Akers on 2/15/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "PNDUserDefaultsController.h"

extern NSString *const PNDTestCharKey;
extern NSString *const PNDTestIntKey;
extern NSString *const PNDTestShortKey;
extern NSString *const PNDTestLongKey;
extern NSString *const PNDTestLongLongKey;
extern NSString *const PNDTestUnsignedCharKey;
extern NSString *const PNDTestUnsignedIntKey;
extern NSString *const PNDTestUnsignedShortKey;
extern NSString *const PNDTestUnsignedLongKey;
extern NSString *const PNDTestUnsignedLongLongKey;
extern NSString *const PNDTestFloatKey;
extern NSString *const PNDTestDoubleKey;
extern NSString *const PNDTestBooleanKey;
extern NSString *const PNDTestIdKey;
extern NSString *const PNDTestClassKey;
extern NSString *const PNDTestCGAffineTransformKey;
extern NSString *const PNDTestCGPointKey;
extern NSString *const PNDTestCGRectKey;
extern NSString *const PNDTestCGSizeKey;
extern NSString *const PNDTestRangeKey;
extern NSString *const PNDTestUIEdgeInsetsKey;
extern NSString *const PNDTestUIOffsetKey;

@interface PNDTestUserDefaultsController : PNDUserDefaultsController

@property (nonatomic) char testChar;
@property (nonatomic) int testInt;
@property (nonatomic) short testShort;
@property (nonatomic) long testLong;
@property (nonatomic) long long testLongLong;
@property (nonatomic) unsigned char testUnsignedChar;
@property (nonatomic) unsigned int testUnsignedInt;
@property (nonatomic) unsigned short testUnsignedShort;
@property (nonatomic) unsigned long testUnsignedLong;
@property (nonatomic) unsigned long long testUnsignedLongLong;
@property (nonatomic) float testFloat;
@property (nonatomic) double testDouble;
@property (nonatomic) Boolean testBoolean;
@property (nonatomic, strong) id testId;
@property (nonatomic, strong) Class testClass;
@property (nonatomic) CGAffineTransform testCGAffineTransform;
@property (nonatomic) CGPoint testCGPoint;
@property (nonatomic) CGRect testCGRect;
@property (nonatomic) CGSize testCGSize;
@property (nonatomic) NSRange testRange;
@property (nonatomic) UIEdgeInsets testUIEdgeInsets;
@property (nonatomic) UIOffset testUIOffset;

@end
