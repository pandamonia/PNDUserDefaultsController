[PNDUserDefaultsController](https://github.com/pandamonia/PNDUserDefaultsController)
===================================================================================

PNDUserDefaultsController is a KVO-compatible controller class. Properties of the shared instance of this class can be bound to user interface elements to access and modify values stored in NSUserDefaults.

PNDUserDefaultsController is a class for iOS 4.3 and newer.

Installation
============

PNDUserDefaultsController can be added to a project using [CocoaPods](https://github.com/cocoapods/cocoapods).

Usage
=====

1. Subclass *PNDUserDefaultsController.m*
2. Add properties for each user default you want to model.
3. Bind properties to user defaults by overriding `+propertiesForUserDefaultsKeys`.

Example
=======

In *XYUserDefaultsController.h*:

```objc
//
//  XYUserDefaultsController.h
//
//  Created by Pandamonia LLC on 2/15/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import "PNDUserDefaultsController.h"

extern NSString *const XYUserAcceptedTermsOfServiceKey;
extern NSString *const XYUsernameKey;

@interface XYUserDefaultsController : PNDUserDefaultsController

@property (nonatomic) BOOL acceptedTermsOfService;
@property (nonatomic) NSString *username;

@end
```

In *XYUserDefaultsController.m*:

```objc
//
//  XYUserDefaultsController.m
//
//  Created by Pandamonia LLC on 2/15/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import "XYUserDefaultsController.h"

NSString *const XYUserAcceptedTermsOfServiceKey = @"XYAcceptedTermsOfService";
NSString *const XYUsernameKey = @"XYUsername";

@implementation XYUserDefaultsController

/*

Depending on your version of Xcode, you may need to  include the following variable synthesis:

@synthesize acceptedTermsOfService = _acceptedTermsOfService;
@synthesize username = _username

*/

+ (NSDictionary *)propertiesForUserDefaultsKeys
{
	static NSDictionary *propertiesForUserDefaultsKeys;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		propertiesForUserDefaultsKeys = @{
			@"acceptedTermsOfService": XYUserAcceptedTermsOfServiceKey,
			@"username": XYUsernameKey
		};
	});
	
	return propertiesForUserDefaultsKeys;
}

@end
```

License
=======

PNDUserDefaultsController is created and maintained by [Pandamonia LLC](https://github.com/pandamonia) under the MIT license.  **The project itself is free for use in any and all projects.**  You can use PNDUserDefaultsController in any project, public or private, with or without attribution - though we prefer attribution! It helps us.

Unsure about your rights? [Read more.](LICENSE)