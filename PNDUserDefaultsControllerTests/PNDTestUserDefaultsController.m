//
//  PNDTestUserDefaultsController.m
//  PNDUserDefaultsController
//
//  Created by Alexsander Akers on 2/15/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import "PNDTestUserDefaultsController.h"

NSString *const PNDTestCharKey = @"PNDTestChar";
NSString *const PNDTestIntKey = @"PNDTestInt";
NSString *const PNDTestShortKey = @"PNDTestShort";
NSString *const PNDTestLongKey = @"PNDTestLong";
NSString *const PNDTestLongLongKey = @"PNDTestLongLong";
NSString *const PNDTestUnsignedCharKey = @"PNDTestUnsignedChar";
NSString *const PNDTestUnsignedIntKey = @"PNDTestUnsignedInt";
NSString *const PNDTestUnsignedShortKey = @"PNDTestUnsignedShort";
NSString *const PNDTestUnsignedLongKey = @"PNDTestUnsignedLong";
NSString *const PNDTestUnsignedLongLongKey = @"PNDTestUnsignedLongLong";
NSString *const PNDTestFloatKey = @"PNDTestFloat";
NSString *const PNDTestDoubleKey = @"PNDTestDouble";
NSString *const PNDTestBooleanKey = @"PNDTestBoolean";
NSString *const PNDTestIdKey = @"PNDTestId";
NSString *const PNDTestClassKey = @"PNDTestClass";
NSString *const PNDTestCGAffineTransformKey = @"PNDTestCGAffineTransform";
NSString *const PNDTestCGPointKey = @"PNDTestCGPoint";
NSString *const PNDTestCGRectKey = @"PNDTestCGRect";
NSString *const PNDTestCGSizeKey = @"PNDTestCGSize";
NSString *const PNDTestRangeKey = @"PNDTestRange";
NSString *const PNDTestUIEdgeInsetsKey = @"PNDTestUIEdgeInsets";
NSString *const PNDTestUIOffsetKey = @"PNDTestUIOffset";

@implementation PNDTestUserDefaultsController

+ (NSDictionary *)propertiesForUserDefaultsKeys
{
	static NSDictionary *propertiesForUserDefaultsKeys;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		propertiesForUserDefaultsKeys = @{
			@"testChar": PNDTestCharKey,
			@"testInt": PNDTestIntKey,
			@"testShort": PNDTestShortKey,
			@"testLong": PNDTestLongKey,
			@"testLongLong": PNDTestLongLongKey,
			@"testUnsignedChar": PNDTestUnsignedCharKey,
			@"testUnsignedInt": PNDTestUnsignedIntKey,
			@"testUnsignedShort": PNDTestUnsignedShortKey,
			@"testUnsignedLong": PNDTestUnsignedLongKey,
			@"testUnsignedLongLong": PNDTestUnsignedLongLongKey,
			@"testFloat": PNDTestFloatKey,
			@"testDouble": PNDTestDoubleKey,
			@"testBoolean": PNDTestBooleanKey,
			@"testId": PNDTestIdKey,
			@"testClass": PNDTestClassKey,
			@"testCGAffineTransform": PNDTestCGAffineTransformKey,
			@"testCGPoint": PNDTestCGPointKey,
			@"testCGRect": PNDTestCGRectKey,
			@"testCGSize": PNDTestCGSizeKey,
			@"testRange": PNDTestRangeKey,
			@"testUIEdgeInsets": PNDTestUIEdgeInsetsKey,
			@"testUIOffset": PNDTestUIOffsetKey
		};
	});
	
	return propertiesForUserDefaultsKeys;
}

@end
