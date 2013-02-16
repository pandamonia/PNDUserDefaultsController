//
//  PNDUserDefaultsController.m
//  PNDUserDefaultsController
//
//  Created by Alexsander Akers on 2/15/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

#import "PNDUserDefaultsController.h"

static char *const PNDUserDefaultsControllerKVOContext = "PNDUserDefaultsControllerKVOContext";
static char *const PNDUserDefaultsControllerSharedControllerKey = "PNDUserDefaultsControllerSharedControllerKey";
static const char *const PNDUserDefaultsControllerValidPropertyTypes = "cislqCISLQfdB@#";
static const char *const PNDUserDefaultsControllerValidComplexPropertyTypes[] = {
	@encode(CGAffineTransform),
	@encode(CGPoint),
	@encode(CGRect),
	@encode(CGSize),
	@encode(NSRange),
	@encode(UIEdgeInsets),
	@encode(UIOffset)
};

static dispatch_queue_t pnd_backgroundQueue(void)
{
	static dispatch_queue_t backgroundQueue;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		backgroundQueue = dispatch_queue_create("us.pandamonia.PNDUserDefaultsController.backgroundQueue", DISPATCH_QUEUE_SERIAL);
	});
	
	return backgroundQueue;
}

@interface PNDUserDefaultsController ()

@property (nonatomic, getter = pnd_isUpdatingUserDefaults, setter = pnd_setUpdatingUserDefaults:) BOOL pnd_updatingUserDefaults;

@end

@implementation PNDUserDefaultsController

- (id)init
{
	self = [super init];
	if (!self) return nil;
	
	[self validatePropertiesForUserDefaultsKeys];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDefaultsDidChange:) name:NSUserDefaultsDidChangeNotification object:nil];
	[self userDefaultsDidChange:nil];
	
	return self;
}

+ (instancetype)sharedController
{
	__block PNDUserDefaultsController *controller;
	
	dispatch_sync(pnd_backgroundQueue(), ^{
		controller = objc_getAssociatedObject(self, PNDUserDefaultsControllerSharedControllerKey);
		
		if (!controller)
		{
			controller = [[self alloc] init];
			objc_setAssociatedObject(self, PNDUserDefaultsControllerSharedControllerKey, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		}
	});
	
	return controller;
}

+ (NSDictionary *)propertiesForUserDefaultsKeys
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (void)dealloc
{
	Class cls = self.class;
	[[cls propertiesForUserDefaultsKeys] enumerateKeysAndObjectsUsingBlock:^(NSString *propertyName, NSString *userDefaultsKey, BOOL *stop) {
		[self removeObserver:self forKeyPath:propertyName context:PNDUserDefaultsControllerKVOContext];
	}];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == PNDUserDefaultsControllerKVOContext)
	{
		Class cls = self.class;
		NSString *userDefaultsKey = [self.class propertiesForUserDefaultsKeys][keyPath];
		if (!userDefaultsKey) return;
		
		self.pnd_updatingUserDefaults = YES;
		
		id obj = [self valueForKey:keyPath];
		NSUserDefaults *sud = [NSUserDefaults standardUserDefaults];
		
		objc_property_t property = class_getProperty(cls, keyPath.UTF8String);
		char *type = property_copyAttributeValue(property, "T");
		
		switch (*type)
		{
			case _C_CHR:
				[sud setObject:[NSNumber numberWithChar:[obj charValue]] forKey:userDefaultsKey];
				break;
			case _C_INT:
				[sud setObject:[NSNumber numberWithInt:[obj intValue]] forKey:userDefaultsKey];
				break;
			case _C_SHT:
				[sud setObject:[NSNumber numberWithShort:[obj shortValue]] forKey:userDefaultsKey];
				break;
			case _C_LNG:
				[sud setObject:[NSNumber numberWithLong:[obj longValue]] forKey:userDefaultsKey];
				break;
			case _C_LNG_LNG:
				[sud setObject:[NSNumber numberWithLongLong:[obj longLongValue]] forKey:userDefaultsKey];
				break;
			case _C_UCHR:
				[sud setObject:[NSNumber numberWithUnsignedChar:[obj unsignedCharValue]] forKey:userDefaultsKey];
				break;
			case _C_UINT:
				[sud setObject:[NSNumber numberWithUnsignedInt:[obj unsignedIntValue]] forKey:userDefaultsKey];
				break;
			case _C_USHT:
				[sud setObject:[NSNumber numberWithUnsignedShort:[obj unsignedShortValue]] forKey:userDefaultsKey];
				break;
			case _C_ULNG:
				[sud setObject:[NSNumber numberWithUnsignedLong:[obj unsignedLongValue]] forKey:userDefaultsKey];
				break;
			case _C_ULNG_LNG:
				[sud setObject:[NSNumber numberWithUnsignedLongLong:[obj unsignedLongLongValue]] forKey:userDefaultsKey];
				break;
			case _C_FLT:
				[sud setObject:[NSNumber numberWithFloat:[obj floatValue]] forKey:userDefaultsKey];
				break;
			case _C_DBL:
				[sud setObject:[NSNumber numberWithDouble:[obj doubleValue]] forKey:userDefaultsKey];
				break;
			case _C_BOOL:
				[sud setObject:[NSNumber numberWithBool:[obj boolValue]] forKey:userDefaultsKey];
				break;
			case _C_ID:
				[sud setObject:obj forKey:userDefaultsKey];
				break;
			case _C_CLASS:
				[sud setObject:NSStringFromClass(obj) forKey:userDefaultsKey];
				break;
			default:
			{
				if (strcmp(type, @encode(CGAffineTransform)) == 0)
					[sud setObject:NSStringFromCGAffineTransform([obj CGAffineTransformValue]) forKey:userDefaultsKey];
				else if (strcmp(type, @encode(CGPoint)) == 0)
					[sud setObject:NSStringFromCGPoint([obj CGPointValue]) forKey:userDefaultsKey];
				else if (strcmp(type, @encode(CGRect)) == 0)
					[sud setObject:NSStringFromCGRect([obj CGRectValue]) forKey:userDefaultsKey];
				else if (strcmp(type, @encode(CGSize)) == 0)
					[sud setObject:NSStringFromCGSize([obj CGSizeValue]) forKey:userDefaultsKey];
				else if (strcmp(type, @encode(NSRange)) == 0)
					[sud setObject:NSStringFromRange([obj rangeValue]) forKey:userDefaultsKey];
				else if (strcmp(type, @encode(UIEdgeInsets)) == 0)
					[sud setObject:NSStringFromUIEdgeInsets([obj UIEdgeInsetsValue]) forKey:userDefaultsKey];
				else if (strcmp(type, @encode(UIOffset)) == 0)
					[sud setObject:NSStringFromUIOffset([obj UIOffsetValue]) forKey:userDefaultsKey];
			}
		}
		
		free(type);
		
		self.pnd_updatingUserDefaults = NO;
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}
- (void)userDefaultsDidChange:(NSNotification *)note
{
	if (self.pnd_updatingUserDefaults)
		return;
	
	NSUserDefaults *sud = [NSUserDefaults standardUserDefaults];
	if (note.object && ![note.object isEqual:sud])
		return;
	
	Class cls = self.class;
	[[cls propertiesForUserDefaultsKeys] enumerateKeysAndObjectsUsingBlock:^(NSString *propertyName, NSString *userDefaultsKey, BOOL *stop) {
		objc_property_t property = class_getProperty(cls, propertyName.UTF8String);
		char *type = property_copyAttributeValue(property, "T");
		
		id obj = [sud objectForKey:userDefaultsKey];
		
		switch (*type)
		{
			case _C_CHR:
				[self setValue:@([obj charValue]) forKey:propertyName];
				break;
			case _C_INT:
				[self setValue:@([obj intValue]) forKey:propertyName];
				break;
			case _C_SHT:
				[self setValue:@([obj shortValue]) forKey:propertyName];
				break;
			case _C_LNG:
				[self setValue:@([obj longValue]) forKey:propertyName];
				break;
			case _C_LNG_LNG:
				[self setValue:@([obj longLongValue]) forKey:propertyName];
				break;
			case _C_UCHR:
				[self setValue:@([obj unsignedCharValue]) forKey:propertyName];
				break;
			case _C_UINT:
				[self setValue:@([obj unsignedIntValue]) forKey:propertyName];
				break;
			case _C_USHT:
				[self setValue:@([obj unsignedShortValue]) forKey:propertyName];
				break;
			case _C_ULNG:
				[self setValue:@([obj unsignedLongValue]) forKey:propertyName];
				break;
			case _C_ULNG_LNG:
				[self setValue:@([obj unsignedLongLongValue]) forKey:propertyName];
				break;
			case _C_FLT:
				[self setValue:@([obj floatValue]) forKey:propertyName];
				break;
			case _C_DBL:
				[self setValue:@([obj doubleValue]) forKey:propertyName];
				break;
			case _C_BOOL:
				[self setValue:@([obj boolValue]) forKey:propertyName];
				break;
			case _C_ID:
				[self setValue:obj forKey:propertyName];
				break;
			case _C_CLASS:
				[self setValue:NSClassFromString([obj description]) forKey:propertyName];
				break;
			default:
			{
				NSString *string = [obj description];
				if (strcmp(type, @encode(CGAffineTransform)) == 0)
					[self setValue:[NSValue valueWithCGAffineTransform:CGAffineTransformFromString(string)] forKey:propertyName];
				else if (strcmp(type, @encode(CGPoint)) == 0)
					[self setValue:[NSValue valueWithCGPoint:CGPointFromString(string)] forKey:propertyName];
				else if (strcmp(type, @encode(CGRect)) == 0)
					[self setValue:[NSValue valueWithCGRect:CGRectFromString(string)] forKey:propertyName];
				else if (strcmp(type, @encode(CGSize)) == 0)
					[self setValue:[NSValue valueWithCGSize:CGSizeFromString(string)] forKey:propertyName];
				else if (strcmp(type, @encode(NSRange)) == 0)
					[self setValue:[NSValue valueWithRange:NSRangeFromString(string)] forKey:propertyName];
				else if (strcmp(type, @encode(UIEdgeInsets)) == 0)
					[self setValue:[NSValue valueWithUIEdgeInsets:UIEdgeInsetsFromString(string)] forKey:propertyName];
				else if (strcmp(type, @encode(UIOffset)) == 0)
					[self setValue:[NSValue valueWithUIOffset:UIOffsetFromString(string)] forKey:propertyName];
			}
		}
		
		free(type);
	}];
}
- (void)validatePropertiesForUserDefaultsKeys
{
	Class cls = self.class;
	[[cls propertiesForUserDefaultsKeys] enumerateKeysAndObjectsUsingBlock:^(NSString *propertyName, NSString *userDefaultsKey, BOOL *stop) {
		objc_property_t property = class_getProperty(cls, propertyName.UTF8String);
		NSCAssert2(property, @"Property \"%@\" does not exist on class %s", propertyName, class_getName(cls));
		
		char *dynamic = property_copyAttributeValue(property, "D");
		NSCAssert2(!dynamic, @"Property \"%@\" on class %s must not be backed with \"@dynamic\"", propertyName, class_getName(cls));
		free(dynamic);
		
		char *type = property_copyAttributeValue(property, "T");
		BOOL isValidType = !!strchr(PNDUserDefaultsControllerValidPropertyTypes, *type);
		
		if (!isValidType)
		{
			NSUInteger i, count = sizeof(PNDUserDefaultsControllerValidComplexPropertyTypes) / sizeof(PNDUserDefaultsControllerValidComplexPropertyTypes[0]);
			for (i = 0; !isValidType && i < count; ++i)
				if (strcmp(type, PNDUserDefaultsControllerValidComplexPropertyTypes[i]) == 0)
					isValidType = YES;
		}
		
		NSCAssert4(isValidType, @"Property \"%@\" on class %s is of incompatible type \"%s\" (only simple types in the set \"%s\" and complex types in the set { CGAffineTransform, CGPoint, CGRect, CGSize, NSRange, UIEdgeInsets, UIOffset } are allowed)", propertyName, class_getName(cls), type, PNDUserDefaultsControllerValidPropertyTypes);
		free(type);
		
		[self addObserver:self forKeyPath:propertyName options:kNilOptions context:PNDUserDefaultsControllerKVOContext];
	}];
}

@end
