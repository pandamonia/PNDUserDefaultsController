//
//  PNDUserDefaultsControllerTests.m
//  PNDUserDefaultsControllerTests
//
//  Created by Alexsander Akers on 2/15/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import "PNDUserDefaultsControllerTests.h"

@implementation PNDUserDefaultsControllerTests

- (void)setUp
{
    [super setUp];
	
	if (!self.userDefaultsController)
		self.userDefaultsController = [PNDTestUserDefaultsController sharedController];
	
	NSUserDefaults *sud = [NSUserDefaults standardUserDefaults];
	[[PNDTestUserDefaultsController propertiesForUserDefaultsKeys] enumerateKeysAndObjectsUsingBlock:^(NSString *propertyName, NSString *userDefaultsKey, BOOL *stop) {
		[sud removeObjectForKey:userDefaultsKey];
	}];
	[sud synchronize];
}

- (void)tearDown
{
	[super tearDown];
}

#define testNumberWrappedProperty(propertyName, type, key, NSNumberConstructor, NSNumberUnpackingSelector, oldValue, newValue) \
- (void)propertyName \
{ \
	self.userDefaultsController.propertyName = (oldValue); \
	STAssertEquals(self.userDefaultsController.propertyName, (type)(oldValue), nil); \
	\
	type propertyName = [[[NSUserDefaults standardUserDefaults] objectForKey:(key)] NSNumberUnpackingSelector]; \
	STAssertEquals(propertyName, (type)(oldValue), @"NSUserDefaults did not update"); \
	\
	propertyName = (newValue); \
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber NSNumberConstructor:(newValue)] forKey:key]; \
	\
	STAssertEquals(self.userDefaultsController.propertyName, propertyName, @"PNDTestUserDefaultsController did not update"); \
}

#define testStringWrappedProperty(propertyName, type, key, NSStringConstructor, NSStringDeconstructor, oldValue, newValue) \
- (void)propertyName \
{ \
	self.userDefaultsController.propertyName = (oldValue); \
	STAssertEquals(self.userDefaultsController.propertyName, (type)(oldValue), nil); \
	\
	type propertyName = NSStringDeconstructor([[NSUserDefaults standardUserDefaults] objectForKey:(key)]); \
	STAssertEquals(propertyName, (type)(oldValue), @"NSUserDefaults did not update"); \
	\
	propertyName = (newValue); \
	[[NSUserDefaults standardUserDefaults] setObject:NSStringConstructor(newValue) forKey:key]; \
	\
	STAssertEquals(self.userDefaultsController.propertyName, propertyName, @"PNDTestUserDefaultsController did not update"); \
}

testNumberWrappedProperty(testChar, char, PNDTestCharKey, numberWithChar, charValue, 'A', '2')
testNumberWrappedProperty(testInt, int, PNDTestIntKey, numberWithInt, intValue, 89, 90)
testNumberWrappedProperty(testShort, short, PNDTestShortKey, numberWithShort, shortValue, 89, 90)
testNumberWrappedProperty(testLong, long, PNDTestLongKey, numberWithLong, longValue, 89l, 90l)
testNumberWrappedProperty(testLongLong, long long, PNDTestLongLongKey, numberWithLongLong, longLongValue, 89ll, 90ll)
testNumberWrappedProperty(testUnsignedChar, unsigned char, PNDTestUnsignedCharKey, numberWithUnsignedChar, unsignedCharValue, 'A', '2')
testNumberWrappedProperty(testUnsignedInt, unsigned int, PNDTestUnsignedIntKey, numberWithUnsignedInt, unsignedIntValue, 89, 90)
testNumberWrappedProperty(testUnsignedShort, unsigned short, PNDTestUnsignedShortKey, numberWithUnsignedShort, unsignedShortValue, 89u, 90u)
testNumberWrappedProperty(testUnsignedLong, unsigned long, PNDTestUnsignedLongKey, numberWithUnsignedLong, unsignedLongValue, 89lu, 90lu)
testNumberWrappedProperty(testUnsignedLongLong, unsigned long long, PNDTestUnsignedLongLongKey, numberWithUnsignedLongLong, unsignedLongLongValue, 89llu, 90llu)
testNumberWrappedProperty(testFloat, float, PNDTestFloatKey, numberWithFloat, floatValue, 89.0f, 90.0f);
testNumberWrappedProperty(testDouble, double, PNDTestDoubleKey, numberWithDouble, doubleValue, 89.0, 90.0);
testNumberWrappedProperty(testBoolean, Boolean, PNDTestBooleanKey, numberWithBool, boolValue, true, false);

testStringWrappedProperty(testCGAffineTransform, CGAffineTransform, PNDTestCGAffineTransformKey, NSStringFromCGAffineTransform, CGAffineTransformFromString, CGAffineTransformMake(1.0, 2.0, 3.0, 4.0, 5.0, 6.0), CGAffineTransformMake(101.0, 102.0, 103.0, 104.0, 105.0, 106.0))
testStringWrappedProperty(testCGPoint, CGPoint, PNDTestCGPointKey, NSStringFromCGPoint, CGPointFromString, CGPointMake(1.0, 2.0), CGPointMake(101.0, 102.0))
testStringWrappedProperty(testCGRect, CGRect, PNDTestCGRectKey, NSStringFromCGRect, CGRectFromString, CGRectMake(1.0, 2.0, 3.0, 4.0), CGRectMake(101.0, 102.0, 103.0, 104.0))
testStringWrappedProperty(testCGSize, CGSize, PNDTestCGSizeKey, NSStringFromCGSize, CGSizeFromString, CGSizeMake(1.0, 2.0), CGSizeMake(101.0, 102.0))
testStringWrappedProperty(testRange, NSRange, PNDTestRangeKey, NSStringFromRange, NSRangeFromString, NSMakeRange(1, 2), NSMakeRange(101, 102))
testStringWrappedProperty(testUIEdgeInsets, UIEdgeInsets, PNDTestUIEdgeInsetsKey, NSStringFromUIEdgeInsets, UIEdgeInsetsFromString, UIEdgeInsetsMake(1.0, 2.0, 3.0, 4.0), UIEdgeInsetsMake(101.0, 102.0, 103.0, 104.0))
testStringWrappedProperty(testUIOffset, UIOffset, PNDTestUIOffsetKey, NSStringFromUIOffset, UIOffsetFromString, UIOffsetMake(1.0, 2.0), UIOffsetMake(101.0, 102.0))
testStringWrappedProperty(testClass, Class, PNDTestClassKey, NSStringFromClass, NSClassFromString, [NSString class], [NSNumber class])
testStringWrappedProperty(testId, id, PNDTestIdKey,,, @"Hello", @"World")

@end
